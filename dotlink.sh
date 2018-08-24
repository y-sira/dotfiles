#!/usr/bin/env bash

for dotfile in .*; do
	if [[ "$dotfile" == "." || "$dotfile" == ".." || "$dotfile" == ".git" || "$dotfile" == ".gitmodules" ]]; then
		continue
	fi
	if [[ -e "${HOME}/${dotfile}" ]]; then
		echo "${HOME}/${dotfile} already exists."
		read -p "Overwrite (y/N)? " answer
		if [[ "$answer" == "${answer#[Yy]}" ]]; then
			continue
		fi
		if [[ -f "${HOME}/${dotfile}" ]]; then
			rm "${HOME}/${dotfile}"
		elif [[ -d "${HOME}/${dotfile}" ]]; then
			rm -rf "${HOME}/${dotfile}"
		elif [[ -L "${HOME}/${dotfile}" ]]; then
			unlink "${HOME}/${dotfile}"
		else
			echo "Unknown file found."
			exit 1
		fi
	fi
	echo "${HOME}/${dotfile} -> $(pwd)/${dotfile}"
	ln -s "$(pwd)/${dotfile}" "${HOME}/${dotfile}"
done
