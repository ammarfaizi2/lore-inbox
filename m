Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVDEVY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVDEVY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVDEVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:24:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:50998 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262033AbVDEVLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:11:36 -0400
Date: Tue, 5 Apr 2005 23:11:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, davem@davemloft.net
Cc: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: [PATCH] networking: restructuring of net/ kconfig
Message-ID: <20050405211120.GB10325@mars.ravnborg.org>
References: <20050331185226.GA8146@mars.ravnborg.org> <424C5745.7020501@osdl.org> <20050331203010.GA8034@mars.ravnborg.org> <4250B4C5.2000200@osdl.org> <20050404195051.GA12364@mars.ravnborg.org> <4251A830.5030905@osdl.org> <20050404215554.GA29170@mars.ravnborg.org> <4251C9A5.3020704@osdl.org> <20050405154538.GA9130@mars.ravnborg.org> <4252DD15.5020605@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4252DD15.5020605@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rany et all.

I have committed the following patch and it will be present in next -mm.

It is present (as the only additional cset) in
bk://linux-sam.bkbits.net/kconfig

davem - any suggestion for next step.
Preferably this goes to Linus via you - or?

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/04/05 22:59:54+02:00 sam@mars.ravnborg.org 
#   networking: restructure kconfig for net/
#   
#   Based on patch and several rounds of comments from:
#   "Randy.Dunlap" <rddunlap@osdl.org>
#   
#   Restructure Networking menu structure creating a separate menu
#   just before Device Drivers.
#   Device drivers for ordinary NIC's are still to be found
#   in the Device Drivers section, but Bluetooth, IrDA and ax25
#   are located with their corresponding menu entries.
#   
#   The patch does the following:
#   o Create a new "Networking" menu just before "Device Drivers"
#   o push all config bits to relevant Kconfig files in net/ hirachy
#   o create new Kconfig files for some subsystem to further push config
#     bits out of net/Kconfig
#   o Make more consistent use of menu's avoiding the menuconfig statement
#   o Fix all menu indention for net/
#   
#   No intentional functional changes introduced.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# net/x25/Kconfig
#   2005/04/05 22:59:31+02:00 sam@mars.ravnborg.org +35 -0
# 
# net/x25/Kconfig
#   2005/04/05 22:59:31+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/x25/Kconfig
# 
# net/wanrouter/Kconfig
#   2005/04/05 22:59:30+02:00 sam@mars.ravnborg.org +31 -0
# 
# net/wanrouter/Kconfig
#   2005/04/05 22:59:30+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/wanrouter/Kconfig
# 
# net/unix/Kconfig
#   2005/04/05 22:59:28+02:00 sam@mars.ravnborg.org +22 -0
# 
# net/unix/Kconfig
#   2005/04/05 22:59:28+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/unix/Kconfig
# 
# net/packet/Kconfig
#   2005/04/05 22:59:26+02:00 sam@mars.ravnborg.org +26 -0
# 
# net/packet/Kconfig
#   2005/04/05 22:59:26+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/packet/Kconfig
# 
# net/lapb/Kconfig
#   2005/04/05 22:59:24+02:00 sam@mars.ravnborg.org +24 -0
# 
# net/lapb/Kconfig
#   2005/04/05 22:59:24+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/lapb/Kconfig
# 
# net/econet/Kconfig
#   2005/04/05 22:59:22+02:00 sam@mars.ravnborg.org +34 -0
# 
# net/econet/Kconfig
#   2005/04/05 22:59:22+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/econet/Kconfig
# 
# net/core/Kconfig
#   2005/04/05 22:59:21+02:00 sam@mars.ravnborg.org +67 -0
# 
# net/core/Kconfig
#   2005/04/05 22:59:21+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/core/Kconfig
# 
# net/bridge/Kconfig
#   2005/04/05 22:59:19+02:00 sam@mars.ravnborg.org +32 -0
# 
# net/bridge/Kconfig
#   2005/04/05 22:59:19+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/bridge/Kconfig
# 
# net/atm/Kconfig
#   2005/04/05 22:59:17+02:00 sam@mars.ravnborg.org +79 -0
# 
# net/atm/Kconfig
#   2005/04/05 22:59:17+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/atm/Kconfig
# 
# net/appletalk/Kconfig
#   2005/04/05 22:59:16+02:00 sam@mars.ravnborg.org +33 -0
# 
# net/appletalk/Kconfig
#   2005/04/05 22:59:16+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/appletalk/Kconfig
# 
# net/8021q/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +21 -0
# 
# net/xfrm/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +14 -0
#   Move top-level config options from net/Kconfig
# 
# net/sctp/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +6 -3
#   Skip menu - no longer relevant
#   Added config option to fix indention in menuconfig
# 
# net/sched/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +40 -0
#   Move top-level config option from net/Kconfig
#   Wrap it in a menu
# 
# net/irda/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +4 -1
#   Use a real menu for IrDA"
# 
# net/ipx/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +33 -0
#   Move top-level config option from net/Kconfig
# 
# net/ipv6/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +20 -0
#   Move top-level config option from net/Kconfig
# 
# net/ipv4/netfilter/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +0 -5
#   Skip menu - no longer relevant
# 
# net/decnet/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +24 -0
#   Include high level config option from net/Kconfig
# 
# net/bridge/netfilter/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +1 -0
#   BRIDGE depends on INET
# 
# net/bluetooth/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +5 -1
#   Use a real menu for "Bluetooth"
# 
# net/ax25/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +4 -1
#   Use a real menu for "Amateur Radio Support"
# 
# net/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +34 -507
#   Push out all config bits to relevant Kconfig files.
#   Use if XXX / endif to make all depencies correct.
#   source a lot of new Kconfig files
# 
# net/8021q/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/v2.6/net/8021q/Kconfig
# 
# drivers/net/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +4 -1
#   Add all net drivers in a new menu "Network device support"
# 
# drivers/Kconfig
#   2005/04/05 22:59:14+02:00 sam@mars.ravnborg.org +3 -1
#   Move "Networking" menu up before "Device Drivers"
#   Explicit include net drivers
# 
diff -Nru a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/drivers/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,5 +1,7 @@
 # drivers/Kconfig
 
+source "net/Kconfig"
+
 menu "Device Drivers"
 
 source "drivers/base/Kconfig"
@@ -28,7 +30,7 @@
 
 source "drivers/macintosh/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/drivers/net/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,8 +1,9 @@
-
 #
 # Network device configuration
 #
 
+menu "Network device support"
+
 config NETDEVICES
 	depends on NET
 	bool "Network device support"
@@ -2535,4 +2536,6 @@
 	---help---
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
+
+endmenu
 
diff -Nru a/net/8021q/Kconfig b/net/8021q/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/8021q/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,21 @@
+#
+# Configuration for 802.1Q VLAN support
+#
+
+config VLAN_8021Q
+	tristate "802.1Q VLAN Support"
+	---help---
+	  Select this and you will be able to create 802.1Q VLAN interfaces
+	  on your ethernet interfaces.  802.1Q VLAN supports almost
+	  everything a regular ethernet interface does, including
+	  firewalling, bridging, and of course IP traffic.  You will need
+	  the 'vconfig' tool from the VLAN project in order to effectively
+	  use VLANs.  See the VLAN web page for more information:
+	  <http://www.candelatech.com/~greear/vlan.html>
+
+	  To compile this code as a module, choose M here: the module
+	  will be called 8021q.
+
+	  If unsure, say N.
+
+
diff -Nru a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/Kconfig	2005-04-05 23:02:06 +02:00
@@ -2,7 +2,7 @@
 # Network configuration
 #
 
-menu "Networking support"
+menu "Networking"
 
 config NET
 	bool "Networking support"
@@ -10,7 +10,9 @@
 	  Unless you really know what you are doing, you should say Y here.
 	  The reason is that some programs need kernel networking support even
 	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
+	  other computer.
+
+	  If you are upgrading from an older kernel, you
 	  should consider updating your networking tools too because changes
 	  in the kernel and the tools often go hand in hand. The tools are
 	  contained in the package net-tools, the location and version number
@@ -20,57 +22,9 @@
 	  recommended to read the NET-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-menu "Networking options"
-	depends on NET
-
-config PACKET
-	tristate "Packet socket"
-	---help---
-	  The Packet protocol is used by applications which communicate
-	  directly with network devices without an intermediate network
-	  protocol implemented in the kernel, e.g. tcpdump.  If you want them
-	  to work, choose Y.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called af_packet.
-
-	  If unsure, say Y.
-
-config PACKET_MMAP
-	bool "Packet socket: mmapped IO"
-	depends on PACKET
-	help
-	  If you say Y here, the Packet protocol driver will use an IO
-	  mechanism that results in faster communication.
-
-	  If unsure, say N.
-
-config UNIX
-	tristate "Unix domain sockets"
-	---help---
-	  If you say Y here, you will include support for Unix domain sockets;
-	  sockets are the standard Unix mechanism for establishing and
-	  accessing network connections.  Many commonly used programs such as
-	  the X Window system and syslog use these sockets even if your
-	  machine is not connected to any network.  Unless you are working on
-	  an embedded system or something similar, you therefore definitely
-	  want to say Y here.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called unix.  Note that several important services won't work
-	  correctly if you say M here and then neglect to load the module.
-
-	  Say Y unless you know what you are doing.
-
-config NET_KEY
-	tristate "PF_KEY sockets"
-	select XFRM
-	---help---
-	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
+if NET
 
-	  Say Y unless you know what you are doing.
+menu "Networking protocols"
 
 config INET
 	bool "TCP/IP networking"
@@ -94,31 +48,26 @@
 
 	  Short answer: say Y.
 
+if INET
 source "net/ipv4/Kconfig"
+source "net/ipv6/Kconfig"
+source "net/sctp/Kconfig"
+endif
 
-#   IPv6 as module will cause a CRASH if you try to unload it
-config IPV6
-	tristate "The IPv6 protocol"
-	depends on INET
-	default m
-	select CRYPTO if IPV6_PRIVACY
-	select CRYPTO_MD5 if IPV6_PRIVACY
-	---help---
-	  This is complemental support for the IP version 6.
-	  You will still be able to do traditional IPv4 networking as well.
-
-	  For general information about IPv6, see
-	  <http://playground.sun.com/pub/ipng/html/ipng-main.html>.
-	  For Linux IPv6 development information, see <http://www.linux-ipv6.org>.
-	  For specific information about IPv6 under Linux, read the HOWTO at
-	  <http://www.bieringer.de/linux/IPv6/>.
+source "net/decnet/Kconfig"
+source "net/llc/Kconfig"
+source "net/ipx/Kconfig"
+source "net/appletalk/Kconfig"
+source "net/x25/Kconfig"
+source "net/lapb/Kconfig"
+source "net/econet/Kconfig"
 
-	  To compile this protocol support as a module, choose M here: the 
-	  module will be called ipv6.
+endmenu
+# end options and protocols
 
-source "net/ipv6/Kconfig"
+menu "Network packet filtering"
 
-menuconfig NETFILTER
+config NETFILTER
 	bool "Network packet filtering (replaces ipchains)"
 	---help---
 	  Netfilter is a framework for filtering and mangling network packets
@@ -181,14 +130,13 @@
 
 config NETFILTER_DEBUG
 	bool "Network packet filtering debugging"
-	depends on NETFILTER
 	help
 	  You can say Y here if you want to get additional messages useful in
 	  debugging the netfilter code.
 
 config BRIDGE_NETFILTER
 	bool "Bridged IP/ARP packets filtering"
-	depends on BRIDGE && NETFILTER && INET
+	depends on BRIDGE && INET
 	default y
 	---help---
 	  Enabling this option will let arptables resp. iptables see bridged
@@ -204,443 +152,22 @@
 source "net/decnet/netfilter/Kconfig"
 source "net/bridge/netfilter/Kconfig"
 
-endif
-
-config XFRM
-       bool
-       depends on NET
-
-source "net/xfrm/Kconfig"
-
-source "net/sctp/Kconfig"
-
-config ATM
-	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  ATM is a high-speed networking technology for Local Area Networks
-	  and Wide Area Networks.  It uses a fixed packet size and is
-	  connection oriented, allowing for the negotiation of minimum
-	  bandwidth requirements.
-
-	  In order to participate in an ATM network, your Linux box needs an
-	  ATM networking card. If you have that, say Y here and to the driver
-	  of your ATM card below.
-
-	  Note that you need a set of user-space programs to actually make use
-	  of ATM.  See the file <file:Documentation/networking/atm.txt> for
-	  further details.
-
-config ATM_CLIP
-	tristate "Classical IP over ATM (EXPERIMENTAL)"
-	depends on ATM && INET
-	help
-	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
-	  ATMARP. If you want to communication with other IP hosts on your ATM
-	  network, you will typically either say Y here or to "LAN Emulation
-	  (LANE)" below.
-
-config ATM_CLIP_NO_ICMP
-	bool "Do NOT send ICMP if no neighbour (EXPERIMENTAL)"
-	depends on ATM_CLIP
-	help
-	  Normally, an "ICMP host unreachable" message is sent if a neighbour
-	  cannot be reached because there is no VC to it in the kernel's
-	  ATMARP table. This may cause problems when ATMARP table entries are
-	  briefly removed during revalidation. If you say Y here, packets to
-	  such neighbours are silently discarded instead.
-
-config ATM_LANE
-	tristate "LAN Emulation (LANE) support (EXPERIMENTAL)"
-	depends on ATM
-	help
-	  LAN Emulation emulates services of existing LANs across an ATM
-	  network. Besides operating as a normal ATM end station client, Linux
-	  LANE client can also act as an proxy client bridging packets between
-	  ELAN and Ethernet segments. You need LANE if you want to try MPOA.
-
-config ATM_MPOA
-	tristate "Multi-Protocol Over ATM (MPOA) support (EXPERIMENTAL)"
-	depends on ATM && INET && ATM_LANE!=n
-	help
-	  Multi-Protocol Over ATM allows ATM edge devices such as routers,
-	  bridges and ATM attached hosts establish direct ATM VCs across
-	  subnetwork boundaries. These shortcut connections bypass routers
-	  enhancing overall network performance.
-
-config ATM_BR2684
-	tristate "RFC1483/2684 Bridged protocols"
-	depends on ATM && INET
-	help
-	  ATM PVCs can carry ethernet PDUs according to rfc2684 (formerly 1483)
-	  This device will act like an ethernet from the kernels point of view,
-	  with the traffic being carried by ATM PVCs (currently 1 PVC/device).
-	  This is sometimes used over DSL lines.  If in doubt, say N.
-
-config ATM_BR2684_IPFILTER
-	bool "Per-VC IP filter kludge"
-	depends on ATM_BR2684
-	help
-	  This is an experimental mechanism for users who need to terminating a
-	  large number of IP-only vcc's.  Do not enable this unless you are sure
-	  you know what you are doing.
-
-config BRIDGE
-	tristate "802.1d Ethernet Bridging"
-	---help---
-	  If you say Y here, then your Linux box will be able to act as an
-	  Ethernet bridge, which means that the different Ethernet segments it
-	  is connected to will appear as one Ethernet to the participants.
-	  Several such bridges can work together to create even larger
-	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
-	  As this is a standard, Linux bridges will cooperate properly with
-	  other third party bridge products.
-
-	  In order to use the Ethernet bridge, you'll need the bridge
-	  configuration tools; see <file:Documentation/networking/bridge.txt>
-	  for location. Please read the Bridge mini-HOWTO for more
-	  information.
-
-	  If you enable iptables support along with the bridge support then you
-	  turn your bridge into a bridging IP firewall.
-	  iptables will then see the IP packets being bridged, so you need to
-	  take this into account when setting up your firewall rules.
-	  Enabling arptables support when bridging will let arptables see
-	  bridged ARP traffic in the arptables FORWARD chain.
-
-	  To compile this code as a module, choose M here: the module
-	  will be called bridge.
-
-	  If unsure, say N.
-
-config VLAN_8021Q
-	tristate "802.1Q VLAN Support"
-	---help---
-	  Select this and you will be able to create 802.1Q VLAN interfaces
-	  on your ethernet interfaces.  802.1Q VLAN supports almost
-	  everything a regular ethernet interface does, including
-	  firewalling, bridging, and of course IP traffic.  You will need
-	  the 'vconfig' tool from the VLAN project in order to effectively
-	  use VLANs.  See the VLAN web page for more information:
-	  <http://www.candelatech.com/~greear/vlan.html>
-
-	  To compile this code as a module, choose M here: the module
-	  will be called 8021q.
-
-	  If unsure, say N.
-
-config DECNET
-	tristate "DECnet Support"
-	---help---
-	  The DECnet networking protocol was used in many products made by
-	  Digital (now Compaq).  It provides reliable stream and sequenced
-	  packet communications over which run a variety of services similar
-	  to those which run over TCP/IP.
-
-	  To find some tools to use with the kernel layer support, please
-	  look at Patrick Caulfield's web site:
-	  <http://linux-decnet.sourceforge.net/>.
-
-	  More detailed documentation is available in
-	  <file:Documentation/networking/decnet.txt>.
-
-	  Be sure to say Y to "/proc file system support" and "Sysctl support"
-	  below when using DECnet, since you will need sysctl support to aid
-	  in configuration at run time.
-
-	  The DECnet code is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called decnet.
-
-source "net/decnet/Kconfig"
-
-source "net/llc/Kconfig"
-
-config IPX
-	tristate "The IPX protocol"
-	select LLC
-	---help---
-	  This is support for the Novell networking protocol, IPX, commonly
-	  used for local networks of Windows machines.  You need it if you
-	  want to access Novell NetWare file or print servers using the Linux
-	  Novell client ncpfs (available from
-	  <ftp://platan.vc.cvut.cz/pub/linux/ncpfs/>) or from
-	  within the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO,
-	  available from <http://www.tldp.org/docs.html#howto>).  In order
-	  to do the former, you'll also have to say Y to "NCP file system
-	  support", below.
-
-	  IPX is similar in scope to IP, while SPX, which runs on top of IPX,
-	  is similar to TCP. There is also experimental support for SPX in
-	  Linux (see "SPX networking", below).
-
-	  To turn your Linux box into a fully featured NetWare file server and
-	  IPX router, say Y here and fetch either lwared from
-	  <ftp://ibiblio.org/pub/Linux/system/network/daemons/> or
-	  mars_nwe from <ftp://www.compu-art.de/mars_nwe/>. For more
-	  information, read the IPX-HOWTO available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  General information about how to connect Linux, Windows machines and
-	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
-
-	  The IPX driver would enlarge your kernel by about 16 KB. To compile
-	  this driver as a module, choose M here: the module will be called ipx.
-	  Unless you want to integrate your Linux box with a local Novell
-	  network, say N.
-
-source "net/ipx/Kconfig"
-
-config ATALK
-	tristate "Appletalk protocol support"
-	select LLC
-	---help---
-	  AppleTalk is the protocol that Apple computers can use to communicate
-	  on a network.  If your Linux box is connected to such a network and you
-	  wish to connect to it, say Y.  You will need to use the netatalk package
-	  so that your Linux box can act as a print and file server for Macs as
-	  well as access AppleTalk printers.  Check out
-	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
-	  EtherTalk is the name used for AppleTalk over Ethernet and the
-	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
-	  network using serial links.  EtherTalk and LocalTalk are fully
-	  supported by Linux.
-
-	  General information about how to connect Linux, Windows machines and
-	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
-	  NET-3-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, contains valuable
-	  information as well.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called appletalk. You almost certainly want to compile it as a
-	  module so you can restart your AppleTalk stack without rebooting
-	  your machine. I hear that the GNU boycott of Apple is over, so
-	  even politically correct people are allowed to say Y here.
-
-source "drivers/net/appletalk/Kconfig"
-
-config X25
-	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  X.25 is a set of standardized network protocols, similar in scope to
-	  frame relay; the one physical line from your box to the X.25 network
-	  entry point can carry several logical point-to-point connections
-	  (called "virtual circuits") to other computers connected to the X.25
-	  network. Governments, banks, and other organizations tend to use it
-	  to connect to each other or to form Wide Area Networks (WANs). Many
-	  countries have public X.25 networks. X.25 consists of two
-	  protocols: the higher level Packet Layer Protocol (PLP) (say Y here
-	  if you want that) and the lower level data link layer protocol LAPB
-	  (say Y to "LAPB Data Link Driver" below if you want that).
-
-	  You can read more about X.25 at <http://www.sangoma.com/x25.htm> and
-	  <http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm>.
-	  Information about X.25 for Linux is contained in the files
-	  <file:Documentation/networking/x25.txt> and
-	  <file:Documentation/networking/x25-iface.txt>.
-
-	  One connects to an X.25 network either with a dedicated network card
-	  using the X.21 protocol (not yet supported by Linux) or one can do
-	  X.25 over a standard telephone line using an ordinary modem (say Y
-	  to "X.25 async driver" below) or over Ethernet using an ordinary
-	  Ethernet card and the LAPB over Ethernet (say Y to "LAPB Data Link
-	  Driver" and "LAPB over Ethernet driver" below).
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called x25. If unsure, say N.
-
-config LAPB
-	tristate "LAPB Data Link Driver (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  Link Access Procedure, Balanced (LAPB) is the data link layer (i.e.
-	  the lower) part of the X.25 protocol. It offers a reliable
-	  connection service to exchange data frames with one other host, and
-	  it is used to transport higher level protocols (mostly X.25 Packet
-	  Layer, the higher part of X.25, but others are possible as well).
-	  Usually, LAPB is used with specialized X.21 network cards, but Linux
-	  currently supports LAPB only over Ethernet connections. If you want
-	  to use LAPB connections over Ethernet, say Y here and to "LAPB over
-	  Ethernet driver" below. Read
-	  <file:Documentation/networking/lapb-module.txt> for technical
-	  details.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called lapb.  If unsure, say N.
-
-config NET_DIVERT
-	bool "Frame Diverter (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  The Frame Diverter allows you to divert packets from the
-	  network, that are not aimed at the interface receiving it (in
-	  promisc. mode). Typically, a Linux box setup as an Ethernet bridge
-	  with the Frames Diverter on, can do some *really* transparent www
-	  caching using a Squid proxy for example.
-
-	  This is very useful when you don't want to change your router's
-	  config (or if you simply don't have access to it).
-
-	  The other possible usages of diverting Ethernet Frames are
-	  numberous:
-	  - reroute smtp traffic to another interface
-	  - traffic-shape certain network streams
-	  - transparently proxy smtp connections
-	  - etc...
-
-	  For more informations, please refer to:
-	  <http://diverter.sourceforge.net/>
-	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
-
-	  If unsure, say N.
-
-config ECONET
-	tristate "Acorn Econet/AUN protocols (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && INET
-	---help---
-	  Econet is a fairly old and slow networking protocol mainly used by
-	  Acorn computers to access file and print servers. It uses native
-	  Econet network cards. AUN is an implementation of the higher level
-	  parts of Econet that runs over ordinary Ethernet connections, on
-	  top of the UDP packet protocol, which in turn runs on top of the
-	  Internet protocol IP.
-
-	  If you say Y here, you can choose with the next two options whether
-	  to send Econet/AUN traffic over a UDP Ethernet connection or over
-	  a native Econet network card.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called econet.
-
-config ECONET_AUNUDP
-	bool "AUN over UDP"
-	depends on ECONET
-	help
-	  Say Y here if you want to send Econet/AUN traffic over a UDP
-	  connection (UDP is a packet based protocol that runs on top of the
-	  Internet protocol IP) using an ordinary Ethernet network card.
-
-config ECONET_NATIVE
-	bool "Native Econet"
-	depends on ECONET
-	help
-	  Say Y here if you have a native Econet network card installed in
-	  your computer.
-
-config WAN_ROUTER
-	tristate "WAN router"
-	depends on EXPERIMENTAL
-	---help---
-	  Wide Area Networks (WANs), such as X.25, frame relay and leased
-	  lines, are used to interconnect Local Area Networks (LANs) over vast
-	  distances with data transfer rates significantly higher than those
-	  achievable with commonly used asynchronous modem connections.
-	  Usually, a quite expensive external device called a `WAN router' is
-	  needed to connect to a WAN.
-
-	  As an alternative, WAN routing can be built into the Linux kernel.
-	  With relatively inexpensive WAN interface cards available on the
-	  market, a perfectly usable router can be built for less than half
-	  the price of an external router.  If you have one of those cards and
-	  wish to use your Linux box as a WAN router, say Y here and also to
-	  the WAN driver for your card, below.  You will then need the
-	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
-	  Read <file:Documentation/networking/wan-router.txt> for more
-	  information.
-
-	  To compile WAN routing support as a module, choose M here: the
-	  module will be called wanrouter.
-
-	  If unsure, say N.
-
-menu "QoS and/or fair queueing"
-
-config NET_SCHED
-	bool "QoS and/or fair queueing"
-	---help---
-	  When the kernel has several packets to send out over a network
-	  device, it has to decide which ones to send first, which ones to
-	  delay, and which ones to drop. This is the job of the packet
-	  scheduler, and several different algorithms for how to do this
-	  "fairly" have been proposed.
-
-	  If you say N here, you will get the standard packet scheduler, which
-	  is a FIFO (first come, first served). If you say Y here, you will be
-	  able to choose from among several alternative algorithms which can
-	  then be attached to different network devices. This is useful for
-	  example if some of your network devices are real time devices that
-	  need a certain minimum data flow rate, or if you need to limit the
-	  maximum data flow rate for traffic which matches specified criteria.
-	  This code is considered to be experimental.
-
-	  To administer these schedulers, you'll need the user-level utilities
-	  from the package iproute2+tc at <ftp://ftp.tux.org/pub/net/ip-routing/>.
-	  That package also contains some documentation; for more, check out
-	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
-
-	  This Quality of Service (QoS) support will enable you to use
-	  Differentiated Services (diffserv) and Resource Reservation Protocol
-	  (RSVP) on your Linux router if you also say Y to "QoS support",
-	  "Packet classifier API" and to some classifiers below. Documentation
-	  and software is at <http://diffserv.sourceforge.net/>.
-
-	  If you say Y here and to "/proc file system" below, you will be able
-	  to read status information about packet schedulers from the file
-	  /proc/net/psched.
-
-	  The available schedulers are listed in the following questions; you
-	  can say Y to as many as you like. If unsure, say N now.
+endif # if NETFILTER
+endmenu # "Network packet filtering"
 
 source "net/sched/Kconfig"
-
-endmenu
-
-menu "Network testing"
-
-config NET_PKTGEN
-	tristate "Packet Generator (USE WITH CAUTION)"
-	depends on PROC_FS
-	---help---
-	  This module will inject preconfigured packets, at a configurable
-	  rate, out of a given interface.  It is used for network interface
-	  stress testing and performance analysis.  If you don't understand
-	  what was just said, you don't need it: say N.
-
-	  Documentation on how to use the packet generator can be found
-	  at <file:Documentation/networking/pktgen.txt>.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called pktgen.
-
-endmenu
-
-endmenu
-
-config NETPOLL
-	def_bool NETCONSOLE
-
-config NETPOLL_RX
-	bool "Netpoll support for trapping incoming packets"
-	default n
-	depends on NETPOLL
-
-config NETPOLL_TRAP
-	bool "Netpoll traffic trapping"
-	default n
-	depends on NETPOLL
-
-config NET_POLL_CONTROLLER
-	def_bool NETPOLL
-
+source "net/xfrm/Kconfig"
+source "net/packet/Kconfig"
+source "net/unix/Kconfig"
+source "net/bridge/Kconfig"
+source "net/8021q/Kconfig"
+source "net/wanrouter/Kconfig"
 source "net/ax25/Kconfig"
-
 source "net/irda/Kconfig"
-
 source "net/bluetooth/Kconfig"
+source "net/atm/Kconfig"
+source "net/core/Kconfig"
 
-source "drivers/net/Kconfig"
-
-endmenu
+endif # if NET
+endmenu # "Networking"
 
diff -Nru a/net/appletalk/Kconfig b/net/appletalk/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/appletalk/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,33 @@
+#
+# Appletalk configuration
+#
+
+config ATALK
+	tristate "Appletalk protocol support"
+	depends on NET
+	select LLC
+	---help---
+	  AppleTalk is the protocol that Apple computers can use to communicate
+	  on a network.  If your Linux box is connected to such a network and you
+	  wish to connect to it, say Y.  You will need to use the netatalk package
+	  so that your Linux box can act as a print and file server for Macs as
+	  well as access AppleTalk printers.  Check out
+	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
+	  EtherTalk is the name used for AppleTalk over Ethernet and the
+	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
+	  network using serial links.  EtherTalk and LocalTalk are fully
+	  supported by Linux.
+
+	  General information about how to connect Linux, Windows machines and
+	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
+	  NET-3-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>, contains valuable
+	  information as well.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called appletalk. You almost certainly want to compile it as a
+	  module so you can restart your AppleTalk stack without rebooting
+	  your machine. I hear that the GNU boycott of Apple is over, so
+	  even politically correct people are allowed to say Y here.
+
+source "drivers/net/appletalk/Kconfig"
diff -Nru a/net/atm/Kconfig b/net/atm/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/atm/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,79 @@
+#
+# ATM Configarition
+#
+
+menu "Asynchronous Transfer Mode (ATM)"
+
+config ATM
+	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	---help---
+	  ATM is a high-speed networking technology for Local Area Networks
+	  and Wide Area Networks.  It uses a fixed packet size and is
+	  connection oriented, allowing for the negotiation of minimum
+	  bandwidth requirements.
+
+	  In order to participate in an ATM network, your Linux box needs an
+	  ATM networking card. If you have that, say Y here and to the driver
+	  of your ATM card below.
+
+	  Note that you need a set of user-space programs to actually make use
+	  of ATM.  See the file <file:Documentation/networking/atm.txt> for
+	  further details.
+
+config ATM_CLIP
+	tristate "Classical IP over ATM (EXPERIMENTAL)"
+	depends on ATM && INET
+	help
+	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
+	  ATMARP. If you want to communication with other IP hosts on your ATM
+	  network, you will typically either say Y here or to "LAN Emulation
+	  (LANE)" below.
+
+config ATM_CLIP_NO_ICMP
+	bool "Do NOT send ICMP if no neighbour (EXPERIMENTAL)"
+	depends on ATM_CLIP
+	help
+	  Normally, an "ICMP host unreachable" message is sent if a neighbour
+	  cannot be reached because there is no VC to it in the kernel's
+	  ATMARP table. This may cause problems when ATMARP table entries are
+	  briefly removed during revalidation. If you say Y here, packets to
+	  such neighbours are silently discarded instead.
+
+config ATM_LANE
+	tristate "LAN Emulation (LANE) support (EXPERIMENTAL)"
+	depends on ATM
+	help
+	  LAN Emulation emulates services of existing LANs across an ATM
+	  network. Besides operating as a normal ATM end station client, Linux
+	  LANE client can also act as an proxy client bridging packets between
+	  ELAN and Ethernet segments. You need LANE if you want to try MPOA.
+
+config ATM_MPOA
+	tristate "Multi-Protocol Over ATM (MPOA) support (EXPERIMENTAL)"
+	depends on ATM && INET && ATM_LANE!=n
+	help
+	  Multi-Protocol Over ATM allows ATM edge devices such as routers,
+	  bridges and ATM attached hosts establish direct ATM VCs across
+	  subnetwork boundaries. These shortcut connections bypass routers
+	  enhancing overall network performance.
+
+config ATM_BR2684
+	tristate "RFC1483/2684 Bridged protocols"
+	depends on ATM && INET
+	help
+	  ATM PVCs can carry ethernet PDUs according to rfc2684 (formerly 1483)
+	  This device will act like an ethernet from the kernels point of view,
+	  with the traffic being carried by ATM PVCs (currently 1 PVC/device).
+	  This is sometimes used over DSL lines.  If in doubt, say N.
+
+config ATM_BR2684_IPFILTER
+	bool "Per-VC IP filter kludge"
+	depends on ATM_BR2684
+	help
+	  This is an experimental mechanism for users who need to terminating a
+	  large number of IP-only vcc's.  Do not enable this unless you are sure
+	  you know what you are doing.
+
+endmenu # "Asynchronous Transfer Mode (ATM)"
+
diff -Nru a/net/ax25/Kconfig b/net/ax25/Kconfig
--- a/net/ax25/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/ax25/Kconfig	2005-04-05 23:02:06 +02:00
@@ -6,7 +6,9 @@
 #		Joerg Reuter DL1BKE <jreuter@yaina.de>
 # 19980129	Moved to net/ax25/Config.in, sourcing device drivers.
 
-menuconfig HAMRADIO
+menu "Amateur Radio support"
+
+config HAMRADIO
 	depends on NET
 	bool "Amateur Radio support"
 	help
@@ -107,4 +109,5 @@
 source "drivers/net/hamradio/Kconfig"
 
 endmenu
+endmenu # "Amateur Radio support"
 
diff -Nru a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
--- a/net/bluetooth/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/bluetooth/Kconfig	2005-04-05 23:02:06 +02:00
@@ -2,7 +2,9 @@
 # Bluetooth subsystem configuration
 #
 
-menuconfig BT
+menu "Bluetooth subsystem support"
+
+config BT
 	depends on NET
 	tristate "Bluetooth subsystem support"
 	help
@@ -60,4 +62,6 @@
 source "net/bluetooth/hidp/Kconfig"
 
 source "drivers/bluetooth/Kconfig"
+
+endmenu # "Bluetooth subsystem support"
 
diff -Nru a/net/bridge/Kconfig b/net/bridge/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/bridge/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,32 @@
+#
+# Configuration for Ethernet bridging
+#
+
+config BRIDGE
+	tristate "802.1d Ethernet Bridging"
+	---help---
+	  If you say Y here, then your Linux box will be able to act as an
+	  Ethernet bridge, which means that the different Ethernet segments it
+	  is connected to will appear as one Ethernet to the participants.
+	  Several such bridges can work together to create even larger
+	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
+	  As this is a standard, Linux bridges will cooperate properly with
+	  other third party bridge products.
+
+	  In order to use the Ethernet bridge, you'll need the bridge
+	  configuration tools; see <file:Documentation/networking/bridge.txt>
+	  for location. Please read the Bridge mini-HOWTO for more
+	  information.
+
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging IP firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
+	  Enabling arptables support when bridging will let arptables see
+	  bridged ARP traffic in the arptables FORWARD chain.
+
+	  To compile this code as a module, choose M here: the module
+	  will be called bridge.
+
+	  If unsure, say N.
+
diff -Nru a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
--- a/net/bridge/netfilter/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/bridge/netfilter/Kconfig	2005-04-05 23:02:06 +02:00
@@ -139,6 +139,7 @@
 config BRIDGE_EBT_ARPREPLY
 	tristate "ebt: arp reply target support"
 	depends on BRIDGE_NF_EBTABLES
+	depends on INET
 	help
 	  This option adds the arp reply target, which allows
 	  automatically sending arp replies to arp requests.
diff -Nru a/net/core/Kconfig b/net/core/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/core/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,67 @@
+#
+# Core configuration
+#
+
+menu "Network testing"
+
+config NET_DIVERT
+	bool "Frame Diverter (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	---help---
+	  The Frame Diverter allows you to divert packets from the
+	  network, that are not aimed at the interface receiving it (in
+	  promisc. mode). Typically, a Linux box setup as an Ethernet bridge
+	  with the Frames Diverter on, can do some *really* transparent www
+	  caching using a Squid proxy for example.
+
+	  This is very useful when you don't want to change your router's
+	  config (or if you simply don't have access to it).
+
+	  The other possible usages of diverting Ethernet Frames are
+	  numberous:
+	  - reroute smtp traffic to another interface
+	  - traffic-shape certain network streams
+	  - transparently proxy smtp connections
+	  - etc...
+
+	  For more informations, please refer to:
+	  <http://diverter.sourceforge.net/>
+	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
+
+	  If unsure, say N.
+
+config NET_PKTGEN
+	tristate "Packet Generator (USE WITH CAUTION)"
+	depends on PROC_FS
+	depends on INET
+	---help---
+	  This module will inject preconfigured packets, at a configurable
+	  rate, out of a given interface.  It is used for network interface
+	  stress testing and performance analysis.  If you don't understand
+	  what was just said, you don't need it: say N.
+
+	  Documentation on how to use the packet generator can be found
+	  at <file:Documentation/networking/pktgen.txt>.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called pktgen.
+
+endmenu
+
+config NETPOLL
+	def_bool NETCONSOLE
+
+config NETPOLL_RX
+	bool "Netpoll support for trapping incoming packets"
+	default n
+	depends on NETPOLL
+
+config NETPOLL_TRAP
+	bool "Netpoll traffic trapping"
+	default n
+	depends on NETPOLL
+
+config NET_POLL_CONTROLLER
+	def_bool NETPOLL
+
+
diff -Nru a/net/decnet/Kconfig b/net/decnet/Kconfig
--- a/net/decnet/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/decnet/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,6 +1,30 @@
 #
 # DECnet configuration
 #
+
+config DECNET
+	tristate "DECnet Support"
+	---help---
+	  The DECnet networking protocol was used in many products made by
+	  Digital (now Compaq).  It provides reliable stream and sequenced
+	  packet communications over which run a variety of services similar
+	  to those which run over TCP/IP.
+
+	  To find some tools to use with the kernel layer support, please
+	  look at Patrick Caulfield's web site:
+	  <http://linux-decnet.sourceforge.net/>.
+
+	  More detailed documentation is available in
+	  <file:Documentation/networking/decnet.txt>.
+
+	  Be sure to say Y to "/proc file system support" and "Sysctl support"
+	  below when using DECnet, since you will need sysctl support to aid
+	  in configuration at run time.
+
+	  The DECnet code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called decnet.
+
 config DECNET_ROUTER
 	bool "DECnet: router support (EXPERIMENTAL)"
 	depends on DECNET && EXPERIMENTAL
diff -Nru a/net/econet/Kconfig b/net/econet/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/econet/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,34 @@
+
+config ECONET
+	tristate "Acorn Econet/AUN protocols (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && INET
+	---help---
+	  Econet is a fairly old and slow networking protocol mainly used by
+	  Acorn computers to access file and print servers. It uses native
+	  Econet network cards. AUN is an implementation of the higher level
+	  parts of Econet that runs over ordinary Ethernet connections, on
+	  top of the UDP packet protocol, which in turn runs on top of the
+	  Internet protocol IP.
+
+	  If you say Y here, you can choose with the next two options whether
+	  to send Econet/AUN traffic over a UDP Ethernet connection or over
+	  a native Econet network card.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called econet.
+
+config ECONET_AUNUDP
+	bool "AUN over UDP"
+	depends on ECONET
+	help
+	  Say Y here if you want to send Econet/AUN traffic over a UDP
+	  connection (UDP is a packet based protocol that runs on top of the
+	  Internet protocol IP) using an ordinary Ethernet network card.
+
+config ECONET_NATIVE
+	bool "Native Econet"
+	depends on ECONET
+	help
+	  Say Y here if you have a native Econet network card installed in
+	  your computer.
+
diff -Nru a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
--- a/net/ipv4/netfilter/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/ipv4/netfilter/Kconfig	2005-04-05 23:02:06 +02:00
@@ -2,9 +2,6 @@
 # IP netfilter configuration
 #
 
-menu "IP: Netfilter Configuration"
-	depends on INET && NETFILTER
-
 # connection tracking, helpers and protocols
 config IP_NF_CONNTRACK
 	tristate "Connection tracking (required for masq/NAT)"
@@ -691,6 +688,4 @@
 	help
 	  Allows altering the ARP packet payload: source and destination
 	  hardware and network addresses.
-
-endmenu
 
diff -Nru a/net/ipv6/Kconfig b/net/ipv6/Kconfig
--- a/net/ipv6/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/ipv6/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,6 +1,26 @@
 #
 # IPv6 configuration
 # 
+
+#   IPv6 as module will cause a CRASH if you try to unload it
+config IPV6
+	tristate "The IPv6 protocol"
+	default m
+	select CRYPTO if IPV6_PRIVACY
+	select CRYPTO_MD5 if IPV6_PRIVACY
+	---help---
+	  This is complemental support for the IP version 6.
+	  You will still be able to do traditional IPv4 networking as well.
+
+	  For general information about IPv6, see
+	  <http://playground.sun.com/pub/ipng/html/ipng-main.html>.
+	  For Linux IPv6 development information, see <http://www.linux-ipv6.org>.
+	  For specific information about IPv6 under Linux, read the HOWTO at
+	  <http://www.bieringer.de/linux/IPv6/>.
+
+	  To compile this protocol support as a module, choose M here: the 
+	  module will be called ipv6.
+
 config IPV6_PRIVACY
 	bool "IPv6: Privacy Extensions (RFC 3041) support"
 	depends on IPV6
diff -Nru a/net/ipx/Kconfig b/net/ipx/Kconfig
--- a/net/ipx/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/ipx/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,6 +1,39 @@
 #
 # IPX configuration
 #
+config IPX
+	tristate "The IPX protocol"
+	select LLC
+	---help---
+	  This is support for the Novell networking protocol, IPX, commonly
+	  used for local networks of Windows machines.  You need it if you
+	  want to access Novell NetWare file or print servers using the Linux
+	  Novell client ncpfs (available from
+	  <ftp://platan.vc.cvut.cz/pub/linux/ncpfs/>) or from
+	  within the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO,
+	  available from <http://www.tldp.org/docs.html#howto>).  In order
+	  to do the former, you'll also have to say Y to "NCP file system
+	  support", below.
+
+	  IPX is similar in scope to IP, while SPX, which runs on top of IPX,
+	  is similar to TCP. There is also experimental support for SPX in
+	  Linux (see "SPX networking", below).
+
+	  To turn your Linux box into a fully featured NetWare file server and
+	  IPX router, say Y here and fetch either lwared from
+	  <ftp://ibiblio.org/pub/Linux/system/network/daemons/> or
+	  mars_nwe from <ftp://www.compu-art.de/mars_nwe/>. For more
+	  information, read the IPX-HOWTO available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  General information about how to connect Linux, Windows machines and
+	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
+
+	  The IPX driver would enlarge your kernel by about 16 KB. To compile
+	  this driver as a module, choose M here: the module will be called ipx.
+	  Unless you want to integrate your Linux box with a local Novell
+	  network, say N.
+
 config IPX_INTERN
 	bool "IPX: Full internal IPX network"
 	depends on IPX
diff -Nru a/net/irda/Kconfig b/net/irda/Kconfig
--- a/net/irda/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/irda/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,8 +1,9 @@
 #
 # IrDA protocol configuration
 #
+menu "IrDA (infrared) subsystem support"
 
-menuconfig IRDA
+config IRDA
 	depends on NET
 	tristate "IrDA (infrared) subsystem support"
 	select CRC_CCITT
@@ -93,4 +94,6 @@
 	  If unsure, say Y (since it makes it easier to find the bugs).
 
 source "drivers/net/irda/Kconfig"
+
+endmenu # "IrDA (infrared) subsystem support"
 
diff -Nru a/net/lapb/Kconfig b/net/lapb/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/lapb/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,24 @@
+#
+# LAPB Configuration
+#
+
+config LAPB
+	tristate "LAPB Data Link Driver (EXPERIMENTAL)"
+	depends on NET && EXPERIMENTAL
+	---help---
+	  Link Access Procedure, Balanced (LAPB) is the data link layer (i.e.
+	  the lower) part of the X.25 protocol. It offers a reliable
+	  connection service to exchange data frames with one other host, and
+	  it is used to transport higher level protocols (mostly X.25 Packet
+	  Layer, the higher part of X.25, but others are possible as well).
+	  Usually, LAPB is used with specialized X.21 network cards, but Linux
+	  currently supports LAPB only over Ethernet connections. If you want
+	  to use LAPB connections over Ethernet, say Y here and to "LAPB over
+	  Ethernet driver" below. Read
+	  <file:Documentation/networking/lapb-module.txt> for technical
+	  details.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lapb.  If unsure, say N.
+
+
diff -Nru a/net/packet/Kconfig b/net/packet/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/packet/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,26 @@
+#
+# Packet configuration
+#
+
+config PACKET
+	tristate "Packet socket"
+	---help---
+	  The Packet protocol is used by applications which communicate
+	  directly with network devices without an intermediate network
+	  protocol implemented in the kernel, e.g. tcpdump.  If you want them
+	  to work, choose Y.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called af_packet.
+
+	  If unsure, say Y.
+
+config PACKET_MMAP
+	bool "Packet socket: mmapped IO"
+	depends on PACKET
+	help
+	  If you say Y here, the Packet protocol driver will use an IO
+	  mechanism that results in faster communication.
+
+	  If unsure, say N.
+
diff -Nru a/net/sched/Kconfig b/net/sched/Kconfig
--- a/net/sched/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/sched/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,6 +1,45 @@
 #
 # Traffic control configuration.
 # 
+
+menu "QoS and/or fair queueing"
+
+config NET_SCHED
+	bool "QoS and/or fair queueing"
+	---help---
+	  When the kernel has several packets to send out over a network
+	  device, it has to decide which ones to send first, which ones to
+	  delay, and which ones to drop. This is the job of the packet
+	  scheduler, and several different algorithms for how to do this
+	  "fairly" have been proposed.
+
+	  If you say N here, you will get the standard packet scheduler, which
+	  is a FIFO (first come, first served). If you say Y here, you will be
+	  able to choose from among several alternative algorithms which can
+	  then be attached to different network devices. This is useful for
+	  example if some of your network devices are real time devices that
+	  need a certain minimum data flow rate, or if you need to limit the
+	  maximum data flow rate for traffic which matches specified criteria.
+	  This code is considered to be experimental.
+
+	  To administer these schedulers, you'll need the user-level utilities
+	  from the package iproute2+tc at <ftp://ftp.tux.org/pub/net/ip-routing/>.
+	  That package also contains some documentation; for more, check out
+	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
+
+	  This Quality of Service (QoS) support will enable you to use
+	  Differentiated Services (diffserv) and Resource Reservation Protocol
+	  (RSVP) on your Linux router if you also say Y to "QoS support",
+	  "Packet classifier API" and to some classifiers below. Documentation
+	  and software is at <http://diffserv.sourceforge.net/>.
+
+	  If you say Y here and to "/proc file system" below, you will be able
+	  to read status information about packet schedulers from the file
+	  /proc/net/psched.
+
+	  The available schedulers are listed in the following questions; you
+	  can say Y to as many as you like. If unsure, say N now.
+
 choice
 	prompt "Packet scheduler clock source"
 	depends on NET_SCHED
@@ -506,3 +545,4 @@
 	  Say Y to support traffic policing (bandwidth limits).  Needed for
 	  ingress and egress rate limiting.
 
+endmenu
diff -Nru a/net/sctp/Kconfig b/net/sctp/Kconfig
--- a/net/sctp/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/sctp/Kconfig	2005-04-05 23:02:06 +02:00
@@ -2,11 +2,15 @@
 # SCTP configuration
 #
 
-menu "SCTP Configuration (EXPERIMENTAL)"
-	depends on INET && EXPERIMENTAL
+# Dummy added to make idention correct in menuconfig
+# The depends on IPV6 || IPV6=n causes SCTP to be indented an extra level
+# if following line is omitted
+config IP_SCTP
 
 config IP_SCTP
 	tristate "The SCTP Protocol (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	# Avoid SCTP as built-in if IPV6 is a module
 	depends on IPV6 || IPV6=n
 	select CRYPTO if SCTP_HMAC_SHA1 || SCTP_HMAC_MD5
 	select CRYPTO_HMAC if SCTP_HMAC_SHA1 || SCTP_HMAC_MD5
@@ -86,4 +90,3 @@
 	  advised to use either HMAC-MD5 or HMAC-SHA1.
 
 endchoice
-endmenu
diff -Nru a/net/unix/Kconfig b/net/unix/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/unix/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,22 @@
+#
+# Configuration for Unix domain sockets
+#
+
+config UNIX
+	tristate "Unix domain sockets"
+	---help---
+	  If you say Y here, you will include support for Unix domain sockets;
+	  sockets are the standard Unix mechanism for establishing and
+	  accessing network connections.  Many commonly used programs such as
+	  the X Window system and syslog use these sockets even if your
+	  machine is not connected to any network.  Unless you are working on
+	  an embedded system or something similar, you therefore definitely
+	  want to say Y here.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called unix.  Note that several important services won't work
+	  correctly if you say M here and then neglect to load the module.
+
+	  Say Y unless you know what you are doing.
+
+
diff -Nru a/net/wanrouter/Kconfig b/net/wanrouter/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/wanrouter/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,31 @@
+#
+# Configuration for WAN Router
+#
+
+config WAN_ROUTER
+	tristate "WAN router"
+	depends on EXPERIMENTAL
+	---help---
+	  Wide Area Networks (WANs), such as X.25, frame relay and leased
+	  lines, are used to interconnect Local Area Networks (LANs) over vast
+	  distances with data transfer rates significantly higher than those
+	  achievable with commonly used asynchronous modem connections.
+	  Usually, a quite expensive external device called a `WAN router' is
+	  needed to connect to a WAN.
+
+	  As an alternative, WAN routing can be built into the Linux kernel.
+	  With relatively inexpensive WAN interface cards available on the
+	  market, a perfectly usable router can be built for less than half
+	  the price of an external router.  If you have one of those cards and
+	  wish to use your Linux box as a WAN router, say Y here and also to
+	  the WAN driver for your card, below.  You will then need the
+	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
+	  Read <file:Documentation/networking/wan-router.txt> for more
+	  information.
+
+	  To compile WAN routing support as a module, choose M here: the
+	  module will be called wanrouter.
+
+	  If unsure, say N.
+
+
diff -Nru a/net/x25/Kconfig b/net/x25/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/net/x25/Kconfig	2005-04-05 23:02:06 +02:00
@@ -0,0 +1,35 @@
+#
+# X25 Configuration
+#
+
+config X25
+	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
+	depends on NET && EXPERIMENTAL
+	---help---
+	  X.25 is a set of standardized network protocols, similar in scope to
+	  frame relay; the one physical line from your box to the X.25 network
+	  entry point can carry several logical point-to-point connections
+	  (called "virtual circuits") to other computers connected to the X.25
+	  network. Governments, banks, and other organizations tend to use it
+	  to connect to each other or to form Wide Area Networks (WANs). Many
+	  countries have public X.25 networks. X.25 consists of two
+	  protocols: the higher level Packet Layer Protocol (PLP) (say Y here
+	  if you want that) and the lower level data link layer protocol LAPB
+	  (say Y to "LAPB Data Link Driver" below if you want that).
+
+	  You can read more about X.25 at <http://www.sangoma.com/x25.htm> and
+	  <http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm>.
+	  Information about X.25 for Linux is contained in the files
+	  <file:Documentation/networking/x25.txt> and
+	  <file:Documentation/networking/x25-iface.txt>.
+
+	  One connects to an X.25 network either with a dedicated network card
+	  using the X.21 protocol (not yet supported by Linux) or one can do
+	  X.25 over a standard telephone line using an ordinary modem (say Y
+	  to "X.25 async driver" below) or over Ethernet using an ordinary
+	  Ethernet card and the LAPB over Ethernet (say Y to "LAPB Data Link
+	  Driver" and "LAPB over Ethernet driver" below).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called x25. If unsure, say N.
+
diff -Nru a/net/xfrm/Kconfig b/net/xfrm/Kconfig
--- a/net/xfrm/Kconfig	2005-04-05 23:02:06 +02:00
+++ b/net/xfrm/Kconfig	2005-04-05 23:02:06 +02:00
@@ -1,6 +1,10 @@
 #
 # XFRM configuration
 #
+
+config XFRM
+       bool
+
 config XFRM_USER
 	tristate "IPsec user configuration interface"
 	depends on INET && XFRM
@@ -9,4 +13,14 @@
 	  by native Linux tools.
 
 	  If unsure, say Y.
+
+config NET_KEY
+	tristate "PF_KEY sockets"
+	select XFRM
+	---help---
+	  PF_KEYv2 socket family, compatible to KAME ones.
+	  They are required if you are going to use IPsec tools ported
+	  from KAME.
+
+	  Say Y unless you know what you are doing.
 
