#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear

uci set system.@system[0].zonename='Asia/Tehran'

uci set network.wan.peerdns="0"

uci set network.wan6.peerdns="0"

uci set network.wan.dns='1.1.1.1'

uci set network.wan6.dns='2001:4860:4860::8888'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system

uci commit network

uci commit

/sbin/reload_config

### Update Packages ###

opkg update

opkg install luci

opkg install wget-ssl

### Add Src ###

wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub

opkg-key add passwall.pub


>/etc/opkg/customfeeds.conf

read arch << EOF
$(. /etc/openwrt_release ; echo $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

### Install package ###

opkg update

echo -e "${GREEN} INSTALLING PASSWALL.2 FOR SNAPSHOT . ${NC}"

opkg remove dnsmasq
sleep 3
opkg install dnsmasq-full
sleep 2
opkg install unzip
sleep 2
opkg install luci-app-passwall2
sleep 3
opkg install ipset
sleep 2
opkg install ipt2socks
sleep 2
opkg install iptables
sleep 2
opkg install iptables-legacy
sleep 2
opkg install iptables-mod-conntrack-extra
sleep 2
opkg install iptables-mod-iprange
sleep 2
opkg install iptables-mod-socket
sleep 2
opkg install iptables-mod-tproxy
sleep 2
opkg install kmod-ipt-nat
sleep 2
opkg install ca-bundle
sleep 1
opkg install kmod-inet-diag
sleep 1
opkg install kernel
sleep 1
opkg install kmod-netlink-diag
sleep 1
opkg install kmod-tun

echo -e "${GREEN}Done ! ${NC}"


>/etc/banner

echo "     ██╗ ██████╗ ██████╗ ██████╗ ██████╗ ██╗  ██╗
     ██║██╔═══██╗╚════██╗╚════██╗██╔══██╗██║  ██║
     ██║██║   ██║ █████╔╝ █████╔╝██████╔╝███████║
██   ██║██║   ██║ ╚═══██╗ ╚═══██╗██╔═══╝ ██╔══██║
╚█████╔╝╚██████╔╝██████╔╝██████╔╝██║     ██║  ██║
 ╚════╝  ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝  ╚═╝                                                                                              
telegram : @Jo33pH" >> /etc/banner

sleep 1


RESULT=`ls /etc/init.d/passwall2`

if [ "$RESULT" == "/etc/init.d/passwall2" ]; then

echo -e "${GREEN} Passwall.2 Installed Successfully ! ${NC}"

 else

 echo -e "${RED} Can not Download Packages ... Check your internet Connection . ${NC}"

 exit 1

fi


DNS=`ls /usr/lib/opkg/info/dnsmasq-full.control`

if [ "$DNS" == "/usr/lib/opkg/info/dnsmasq-full.control" ]; then

echo -e "${GREEN} dnsmaq-full Installed successfully ! ${NC}"

 else
           
echo -e "${RED} Package : dnsmasq-full not installed ! (Bad internet connection .) ${NC}"

exit 1

fi



####install_xray
opkg install xray-core

RESULT=`ls /usr/bin/xray`

if [ "$RESULT" == "/usr/bin/xray" ]; then

echo -e "${GREEN} Xray : OK ${NC}"

 else
           
rm -f joseph.sh && wget https://raw.githubusercontent.com/zeustm/owrt/main/joseph.sh && chmod 777 joseph.sh && sh joseph.sh

fi



####improve

cd /tmp

wget -q https://skadi.ir/improvetherouter.zip

unzip -o improvetherouter.zip -d /

cd

########


uci set passwall2.@global_forwarding[0]=global_forwarding
uci set passwall2.@global_forwarding[0].tcp_no_redir_ports='disable'
uci set passwall2.@global_forwarding[0].udp_no_redir_ports='disable'
uci set passwall2.@global_forwarding[0].tcp_redir_ports='1:65535'
uci set passwall2.@global_forwarding[0].udp_redir_ports='1:65535'
uci set passwall2.@global[0].remote_dns='8.8.4.4'

uci set passwall2.Direct=shunt_rules
uci set passwall2.Direct.network='tcp,udp'
uci set passwall2.Direct.remarks='IRAN'
uci set passwall2.Direct.ip_list='0.0.0.0/8
10.0.0.0/8
100.64.0.0/10
127.0.0.0/8
169.254.0.0/16
172.16.0.0/12
192.0.0.0/24
192.0.2.0/24
192.88.99.0/24
192.168.0.0/16
198.19.0.0/16
198.51.100.0/24
203.0.113.0/24
224.0.0.0/4
240.0.0.0/4
255.255.255.255/32
::/128
::1/128
::ffff:0:0:0/96
64:ff9b::/96
100::/64
2001::/32
2001:20::/28
2001:db8::/32
2002::/16
fc00::/7
fe80::/10
ff00::/8
geoip:ir'
uci set passwall2.Direct.domain_list='regexp:^.+\.ir$
geosite:category-ir'

uci set passwall2.myshunt.Direct='_direct'

uci commit passwall2

uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system

echo -e "${YELLOW} WiFi SSID : Router ${ENDCOLOR}"
echo -e "${GREEN} Password : Qwerty@3333 ${ENDCOLOR}"
echo -e "${YELLOW} WiFi SSID : Router ${ENDCOLOR}"
echo -e "${GREEN} Password : Qwerty@3333 ${ENDCOLOR}"

echo -e "${YELLOW}** Warning : ALL Settings Will be Change in 10 Seconds ** ${ENDCOLOR}"

echo -e "${MAGENTA} Made With Love By : Jo33pH ${ENDCOLOR}"

sleep 10

uci delete wireless.radio0.disabled='1'
uci set wireless.default_radio0.ssid='Router'
uci set wireless.default_radio0.encryption='psk2+ccmp'
uci set wireless.default_radio0.key='Qwerty@3333'
uci set wireless.default_radio0.mode='ap'
uci set wireless.default_radio0.network='lan'

uci commit wireless

uci set system.@system[0].hostname=Router

uci commit system

uci set network.lan.proto='static'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.ipaddr='192.168.33.1'
uci set network.lan.delegate='0'

uci commit network

uci set dhcp.@dnsmasq[0].rebind_domain='www.ebanksepah.ir 
my.irancell.ir'

uci commit

echo -e "${YELLOW}** Warning : Router Will Be Reboot ... After That Login With New IP Address : 192.168.27.1 ** ${ENDCOLOR}"

echo -e "${YELLOW} WiFi SSID : Router ${ENDCOLOR}"

echo -e "${GREEN} WiFi Key : Qwerty@3333 ${ENDCOLOR}"

sleep 5

rm passwalls.sh

reboot
