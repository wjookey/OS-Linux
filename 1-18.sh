#!/bin/bash
if [[ "$#" -eq 0 ]]     # checking if there is no parameters
then
    if [[ -n "${PREFIX_CATALOG}" && -n "${CATALOGS_NUMBER}" && -n "${DEST_CATALOG}" ]]    # checking if all three parameters exist and aren't empty
    then
	if [[ ! "${CATALOGS_NUMBER}" =~ ^[0-9]+$ ]]     # checking if there is non-integer symbols
	then
	    printf "\033[31mError: CATALOGS_NUMBERS isn't an integer number\033[0m\n"
	    exit 1
	fi

	if [[ ! -e "${DEST_CATALOG}" ]]     # checking if destination catalog doesn't exist
	then
	    mkdir ${DEST_CATALOG}     # creating destination catalog
	fi

	if [[ -f "${DEST_CATALOG}" ]]     # checking if destination catalog is a file
	then
	    printf "\033[31mError: Cannot write to '${DEST_CATALOG}'. This is a file\033[0m\n"
	    exit 1
	fi

	if [[ -d "${DEST_CATALOG}" && ! -w "${DEST_CATALOG}" ]]     # checking if we can't write anything to the catalog
	then
	    printf "\033[31mError: Cannot write to the catalog '${DEST_CATALOG}'. No access\033[0m\n"
	    exit 1
	fi

	for (( i = 1; i <= ${CATALOGS_NUMBER}; i++ ))
	do
	    nameDir="${DEST_CATALOG}/${PREFIX_CATALOG}_$i"
	    if [[ ! -e "${nameDir}" ]]
	    then
		mkdir ${nameDir}			# creating catalog if it doesn't exist yet
	    else
		printf "\033[33mWarning: File '${nameDir}' exists\033[0m\n"
	    fi
	done
	printf "\033[32mScript is done\033[0m\n"
	exit 0
    else
	printf "\033[31mError: Cannot find all environment variables\033[0m\n"
	exit 1
    fi
elif [[ "$#" -eq 1 && ( "$1" == "--help" || "$1" == "-h" ) ]]     # checking if user wants to learn more about script
then
    printf "\033[36mThis script creates 'n' folders with prefix in specified directory\033[0m\n"
    echo "All values (number, prefix, destination) are taken from environment variables:"
    printf "> \033[31mPREFIX_CATALOG, CATALOG_NUMBERS, DEST_CATALOG\033[0m\n"
    echo "Before running this script make sure these variables are set"
    printf "To set them run this command: \033[32m'export'nameVar'='...'\n\033[0m"
    printf "Add flags \033[33m'--help'\033[0m or \033[33m'-h'\033[0m to get documentation\n"
    exit 0
else
    printf "\033[31mError: Cannot execute. Wrong format\033[0m\n"     # incorrect running of the script
    exit 1
fi
