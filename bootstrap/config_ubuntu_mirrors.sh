
PACKAGE_MIRROR="au"
PACKAGE_PAT="s|http://us.|http://${PACKAGE_MIRROR}.|g"
PACKAGE_PAT2="s/(\/\/)(archive\.ubuntu)/\1au.\2/"

SP=/etc/apt/sources.list

echo "${SP} before: $(cat ${SP})"

sed -i $PACKAGE_PAT $SP
sed --in-place --regexp-extended $PACKAGE_PAT2 $SP

apt-get -y update
apt-get -y install software-properties-common

add-apt-repository -y universe
add-apt-repository -y  multiverse

apt-get -y update

apt-get -y install apt-utils
sed -i $PACKAGE_PAT $SP
sed --in-place --regexp-extended $PACKAGE_PAT2 $SP

echo "${SP} after: $(cat ${SP})"
