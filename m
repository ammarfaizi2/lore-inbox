Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTIZWn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTIZWnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:43:55 -0400
Received: from front3.chartermi.net ([24.213.60.109]:52464 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S261699AbTIZWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:43:29 -0400
Message-ID: <3F74C10B.4070606@quark.didntduck.org>
Date: Fri, 26 Sep 2003 18:43:23 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] select CRC32
Content-Type: multipart/mixed;
 boundary="------------040303020500010602090603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040303020500010602090603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Use "select CRC32" in Kconfig instead of makefile includes.

--------------040303020500010602090603
Content-Type: text/plain;
 name="crc32-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crc32-1"

diff -urN linux-2.6.0-test5-bk/drivers/media/dvb/dvb-core/Kconfig linux/drivers/media/dvb/dvb-core/Kconfig
--- linux-2.6.0-test5-bk/drivers/media/dvb/dvb-core/Kconfig	2003-07-27 13:09:34.000000000 -0400
+++ linux/drivers/media/dvb/dvb-core/Kconfig	2003-09-26 10:18:22.092564536 -0400
@@ -1,6 +1,7 @@
 config DVB_CORE
 	tristate "DVB Core Support"
 	depends on DVB
+	select CRC32
 	help
 	  DVB core utility functions for device handling, software fallbacks etc.
 
diff -urN linux-2.6.0-test5-bk/drivers/media/dvb/dvb-core/Makefile.lib linux/drivers/media/dvb/dvb-core/Makefile.lib
--- linux-2.6.0-test5-bk/drivers/media/dvb/dvb-core/Makefile.lib	2003-07-27 12:57:02.000000000 -0400
+++ linux/drivers/media/dvb/dvb-core/Makefile.lib	1969-12-31 19:00:00.000000000 -0500
@@ -1 +0,0 @@
-obj-$(CONFIG_DVB_CORE)		+= crc32.o
diff -urN linux-2.6.0-test5-bk/drivers/net/arm/Kconfig linux/drivers/net/arm/Kconfig
--- linux-2.6.0-test5-bk/drivers/net/arm/Kconfig	2003-07-27 13:09:19.000000000 -0400
+++ linux/drivers/net/arm/Kconfig	2003-09-26 10:05:13.144502872 -0400
@@ -5,6 +5,7 @@
 config ARM_AM79C961A
 	bool "ARM EBSA110 AM79C961A support"
 	depends on NET_ETHERNET && ARM && ARCH_EBSA110
+	select CRC32
 	help
 	  If you wish to compile a kernel for the EBSA-110, then you should
 	  always answer Y to this.
@@ -26,6 +27,7 @@
 config ARM_ETHERH
 	tristate "I-cubed EtherH/ANT EtherM support"
 	depends on NET_ETHERNET && ARM && ARCH_ACORN
+	select CRC32
 	help
 	  If you have an Acorn system with one of these network cards, you
 	  should say Y to this option if you wish to use it with Linux.
diff -urN linux-2.6.0-test5-bk/drivers/net/Kconfig linux/drivers/net/Kconfig
--- linux-2.6.0-test5-bk/drivers/net/Kconfig	2003-09-26 09:30:41.303470584 -0400
+++ linux/drivers/net/Kconfig	2003-09-26 10:04:21.413367200 -0400
@@ -215,6 +215,7 @@
 config MACE
 	tristate "MACE (Power Mac ethernet) support"
 	depends on NET_ETHERNET && PPC_PMAC
+	select CRC32
 	help
 	  Power Macintoshes and clones with Ethernet built-in on the
 	  motherboard will usually use a MACE (Medium Access Control for
@@ -237,6 +238,7 @@
 config BMAC
 	tristate "BMAC (G3 ethernet) support"
 	depends on NET_ETHERNET && PPC_PMAC
+	select CRC32
 	help
 	  Say Y for support of BMAC Ethernet interfaces. These are used on G3
 	  computers.
@@ -247,6 +249,7 @@
 config OAKNET
 	tristate "National DP83902AV (Oak ethernet) support"
 	depends on NET_ETHERNET && PPC
+	select CRC32
 	help
 	  Say Y if your machine has this type of Ethernet network card.
 
@@ -266,6 +269,7 @@
 config A2065
 	tristate "A2065 support"
 	depends on NET_ETHERNET && ZORRO
+	select CRC32
 	help
 	  If you have a Commodore A2065 Ethernet adapter, say Y. Otherwise,
 	  say N.
@@ -276,6 +280,7 @@
 config HYDRA
 	tristate "Hydra support"
 	depends on NET_ETHERNET && ZORRO
+	select CRC32
 	help
 	  If you have a Hydra Ethernet adapter, say Y. Otherwise, say N.
 
@@ -285,6 +290,7 @@
 config ZORRO8390
 	tristate "Zorro NS8390-based Ethernet support"
 	depends on NET_ETHERNET && ZORRO
+	select CRC32
 	help
 	  This driver is for Zorro Ethernet cards using an NS8390-compatible
 	  chipset, like the Village Tronic Ariadne II and the Individual
@@ -297,6 +303,7 @@
 config APNE
 	tristate "PCMCIA NE2000 support"
 	depends on NETDEVICES && AMIGA_PCMCIA
+	select CRC32
 	help
 	  If you have a PCMCIA NE2000 compatible adapter, say Y.  Otherwise,
 	  say N.
@@ -316,6 +323,7 @@
 config MAC8390
 	bool "Macintosh NS 8390 based ethernet cards"
 	depends on NETDEVICES && MAC
+	select CRC32
 	help
 	  If you want to include a driver to support Nubus or LC-PDS
 	  Ethernet cards using an NS8390 chipset or its equivalent, say Y
@@ -352,6 +360,7 @@
 config MACMACE
 	bool "Macintosh (AV) onboard MACE ethernet (EXPERIMENTAL)"
 	depends on NETDEVICES && MAC && EXPERIMENTAL
+	select CRC32
 	help
 	  Support for the onboard AMD 79C940 MACE Ethernet controller used in
 	  the 660AV and 840AV Macintosh.  If you have one of these Macintoshes
@@ -361,6 +370,7 @@
 config MVME147_NET
 	tristate "MVME147 (Lance) Ethernet support"
 	depends on NETDEVICES && MVME147
+	select CRC32
 	help
 	  Support for the on-board Ethernet interface on the Motorola MVME147
 	  single-board computer.  Say Y here to include the
@@ -434,6 +444,7 @@
 config HPLANCE
 	bool "HP on-board LANCE support"
 	depends on NETDEVICES && HP300
+	select CRC32
 	help
 	  If you want to use the builtin "LANCE" Ethernet controller on an
 	  HP300 machine, say Y here.
@@ -461,6 +472,7 @@
 config MIPS_AU1X00_ENET
 	bool "MIPS AU1000 Ethernet support"
 	depends on NET_ETHERNET && SOC_AU1X00
+	select CRC32
 	help
 	  If you have an Alchemy Semi AU1X00 based system
 	  say Y.  Otherwise, say N.
@@ -472,6 +484,7 @@
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
 	depends on NET_ETHERNET && SGI_IP27
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -484,6 +497,7 @@
 config STNIC
 	tristate "National DP83902AV  support"
 	depends on NET_ETHERNET && SUPERH
+	select CRC32
 	help
 	  Support for cards based on the National Semiconductor DP83902AV
 	  ST-NIC Serial Network Interface Controller for Twisted Pair.  This
@@ -495,6 +509,7 @@
 config SUNLANCE
 	tristate "Sun LANCE support"
 	depends on NET_ETHERNET && SBUS
+	select CRC32
 	help
 	  This driver supports the "le" interface present on all 32-bit Sparc
 	  systems, on some older Ultra systems and as an Sbus option.  These
@@ -507,6 +522,7 @@
 config HAPPYMEAL
 	tristate "Sun Happy Meal 10/100baseT support"
 	depends on NET_ETHERNET && (SBUS || PCI)
+	select CRC32
 	help
 	  This driver supports the "hme" interface present on most Ultra
 	  systems and as an option on older Sbus systems. This driver supports
@@ -519,6 +535,7 @@
 config SUNBMAC
 	tristate "Sun BigMAC 10/100baseT support (EXPERIMENTAL)"
 	depends on NET_ETHERNET && SBUS && EXPERIMENTAL
+	select CRC32
 	help
 	  This driver supports the "be" interface available as an Sbus option.
 	  This is Sun's older 100baseT Ethernet device.
@@ -529,6 +546,7 @@
 config SUNQE
 	tristate "Sun QuadEthernet support"
 	depends on NET_ETHERNET && SBUS
+	select CRC32
 	help
 	  This driver supports the "qe" 10baseT Ethernet device, available as
 	  an Sbus option. Note that this is not the same as Quad FastEthernet
@@ -540,6 +558,7 @@
 config SUNGEM
 	tristate "Sun GEM support"
 	depends on NET_ETHERNET && PCI
+	select CRC32
 	help
 	  Support for the Sun GEM chip, aka Sun GigabitEthernet/P 2.0.  See also
 	  <http://www.sun.com/products-n-solutions/hardware/docs/pdf/806-3985-10.pdf>.
@@ -575,6 +594,7 @@
 config EL2
 	tristate "3c503 \"EtherLink II\" support"
 	depends on NET_VENDOR_3COM && ISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -686,6 +706,7 @@
 config TYPHOON
 	tristate "3cr990 series \"Typhoon\" support"
 	depends on NET_VENDOR_3COM && PCI
+	select CRC32
 	---help---
 	  This option enables driver support for the 3cr990 series of cards:
 
@@ -729,6 +750,7 @@
 config WD80x3
 	tristate "WD80*3 support"
 	depends on NET_VENDOR_SMC && ISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -741,6 +763,7 @@
 config ULTRAMCA
 	tristate "SMC Ultra MCA support"
 	depends on NET_VENDOR_SMC && MCA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type and are running
 	  an MCA based system (PS/2), say Y and read the Ethernet-HOWTO,
@@ -753,6 +776,7 @@
 config ULTRA
 	tristate "SMC Ultra support"
 	depends on NET_VENDOR_SMC && ISA
+	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -772,6 +796,7 @@
 config ULTRA32
 	tristate "SMC Ultra32 EISA support"
 	depends on NET_VENDOR_SMC && EISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -784,6 +809,7 @@
 config SMC9194
 	tristate "SMC 9194 support"
 	depends on NET_VENDOR_SMC && (ISA || MAC)
+	select CRC32
 	---help---
 	  This is support for the SMC9xxx based Ethernet cards. Choose this
 	  option if you have a DELL laptop with the docking station, or
@@ -851,6 +877,7 @@
 config AT1700
 	tristate "AT1700/1720/RE1000Plus(C-Bus) support (EXPERIMENTAL)"
 	depends on NET_ETHERNET && (ISA || MCA) && EXPERIMENTAL
+	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -863,6 +890,7 @@
 config DEPCA
 	tristate "DEPCA, DE10x, DE200, DE201, DE202, DE422 support"
 	depends on NET_ETHERNET && (ISA || EISA || MCA)
+	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -905,6 +933,7 @@
 config E2100
 	tristate "Cabletron E21xx support"
 	depends on NET_ISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -917,6 +946,7 @@
 config EWRK3
 	tristate "EtherWORKS 3 (DE203, DE204, DE205) support"
 	depends on NET_ISA
+	select CRC32
 	---help---
 	  This driver supports the DE203, DE204 and DE205 network (Ethernet)
 	  cards. If this is for you, say Y and read
@@ -975,6 +1005,7 @@
 config HPLAN_PLUS
 	tristate "HP PCLAN+ (27247B and 27252A) support"
 	depends on NET_ISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -987,6 +1018,7 @@
 config HPLAN
 	tristate "HP PCLAN (27245 and other 27xxx series) support"
 	depends on NET_ISA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1019,6 +1051,7 @@
 config NE2000
 	tristate "NE2000/NE1000 support"
 	depends on NET_ISA || (Q40 && m)
+	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1076,6 +1109,7 @@
 config NE2K_CBUS
 	tristate "Most NE2000-based Ethernet support"
 	depends on NET_CBUS
+	select CRC32
 
 config NE2K_CBUS_EGY98
 	bool "Melco EGY-98 support"
@@ -1132,6 +1166,7 @@
 config NE2_MCA
 	tristate "NE/2 (ne2000 MCA version) support"
 	depends on NET_ETHERNET && MCA
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1174,6 +1209,7 @@
 config PCNET32
 	tristate "AMD PCnet32 PCI support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  If you have a PCnet32 or PCnetPCI based network (Ethernet) card,
 	  answer Y here and read the Ethernet-HOWTO, available from
@@ -1186,6 +1222,7 @@
 config AMD8111_ETH
 	tristate "AMD 8111 (new PCI lance) support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  If you have an AMD 8111-based PCI lance ethernet card,
 	  answer Y here and read the Ethernet-HOWTO, available from
@@ -1198,6 +1235,7 @@
 config ADAPTEC_STARFIRE
 	tristate "Adaptec Starfire/DuraLAN support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  Say Y here if you have an Adaptec Starfire (or DuraLAN) PCI network
 	  adapter. The DuraLAN chip is used on the 64 bit PCI boards from
@@ -1222,6 +1260,7 @@
 config AC3200
 	tristate "Ansel Communications EISA 3200 support (EXPERIMENTAL)"
 	depends on NET_PCI && (ISA || EISA) && EXPERIMENTAL
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1389,6 +1428,7 @@
 config LNE390
 	tristate "Mylex EISA LNE390A/B support (EXPERIMENTAL)"
 	depends on NET_PCI && EISA && EXPERIMENTAL
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1401,6 +1441,7 @@
 config FEALNX
 	tristate "Myson MTD-8xx PCI Ethernet support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  Say Y here to support the Mysom MTD-800 family of PCI-based Ethernet
 	  cards. Specifications and data at
@@ -1409,6 +1450,7 @@
 config NATSEMI
 	tristate "National Semiconductor DP8381x series PCI Ethernet support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  This driver is for the National Semiconductor DP83810 series,
 	  which is used in cards from PureData, NetGear, Linksys
@@ -1419,6 +1461,7 @@
 config NE2K_PCI
 	tristate "PCI NE2000 and clones support (see help)"
 	depends on NET_PCI && PCI
+	select CRC32
 	---help---
 	  This driver is for NE2000 compatible PCI cards. It will not work
 	  with ISA NE2000 cards (they have their own driver, "NE2000/NE1000
@@ -1438,6 +1481,7 @@
 config NE3210
 	tristate "Novell/Eagle/Microdyne NE3210 EISA support (EXPERIMENTAL)"
 	depends on NET_PCI && EISA && EXPERIMENTAL
+	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1451,6 +1495,7 @@
 config ES3210
 	tristate "Racal-Interlan EISA ES3210 support (EXPERIMENTAL)"
 	depends on NET_PCI && EISA && EXPERIMENTAL
+	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1463,6 +1508,7 @@
 config 8139CP
 	tristate "RealTek RTL-8139 C+ PCI Fast Ethernet Adapter support (EXPERIMENTAL)"
 	depends on NET_PCI && PCI && EXPERIMENTAL
+	select CRC32
 	help
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the RTL8139C+ chips. If you have one of those, say Y and read
@@ -1475,6 +1521,7 @@
 config 8139TOO
 	tristate "RealTek RTL-8139 PCI Fast Ethernet Adapter support"
 	depends on NET_PCI && PCI
+	select CRC32
 	---help---
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the RTL8139 chips. If you have one of those, say Y and read
@@ -1527,6 +1574,7 @@
 config SIS900
 	tristate "SiS 900/7016 PCI Fast Ethernet Adapter support"
 	depends on NET_PCI && PCI
+	select CRC32
 	---help---
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the SiS 900 and SiS 7016 chips. The SiS 900 core is also embedded in
@@ -1545,6 +1593,7 @@
 config EPIC100
 	tristate "SMC EtherPower II"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  This driver is for the SMC EtherPower II 9432 PCI Ethernet NIC,
 	  which is based on the SMC83c17x (EPIC/100).
@@ -1554,6 +1603,7 @@
 config SUNDANCE
 	tristate "Sundance Alta support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  This driver is for the Sundance "Alta" chip.
 	  More specific information and updates are available from
@@ -1591,6 +1641,7 @@
 config VIA_RHINE
 	tristate "VIA Rhine support"
 	depends on NET_PCI && PCI
+	select CRC32
 	help
 	  If you have a VIA "rhine" based network card (Rhine-I (3043) or
 	  Rhine-2 (VT86c100A)), say Y here.
@@ -1647,6 +1698,7 @@
 config ATP
 	tristate "AT-LAN-TEC/RealTek pocket adapter support"
 	depends on NET_POCKET && ISA && X86
+	select CRC32
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
 	  port. Read <file:drivers/net/atp.c> as well as the Ethernet-HOWTO,
@@ -1698,6 +1750,7 @@
 config DECLANCE
 	tristate "DEC LANCE ethernet controller support"
 	depends on NET_ETHERNET && DECSTATION
+	select CRC32
 	help
 	  This driver is for the series of Ethernet controllers produced by
 	  DEC (now Compaq) based on the AMD Lance chipset, including the
@@ -1764,6 +1817,7 @@
 config DL2K
 	tristate "D-Link DL2000-based Gigabit Ethernet support"
 	depends on PCI
+	select CRC32
 	help
 	  This driver supports D-Link 2000-based gigabit ethernet cards, which
 	  includes
@@ -1854,6 +1908,7 @@
 config YELLOWFIN
 	tristate "Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
+	select CRC32
 	---help---
 	  Say Y here if you have a Packet Engines G-NIC PCI Gigabit Ethernet
 	  adapter or the SYM53C885 Ethernet controller. The Gigabit adapter is
@@ -1867,6 +1922,7 @@
 config R8169
 	tristate "Realtek 8169 gigabit ethernet support"
 	depends on PCI
+	select CRC32
 	---help---
 	  Say Y here if you have a Realtek 8169 PCI Gigabit Ethernet adapter.
 
@@ -1876,6 +1932,7 @@
 config SIS190
 	tristate "SiS190 gigabit ethernet support (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
+	select CRC32
 	---help---
 	  Say Y here if you have a SiS 190 PCI Gigabit Ethernet adapter.
 
diff -urN linux-2.6.0-test5-bk/drivers/net/Makefile.lib linux/drivers/net/Makefile.lib
--- linux-2.6.0-test5-bk/drivers/net/Makefile.lib	2003-09-13 00:00:01.000000000 -0400
+++ linux/drivers/net/Makefile.lib	1969-12-31 19:00:00.000000000 -0500
@@ -1,76 +0,0 @@
-# These drivers all require crc32.o
-obj-$(CONFIG_8139CP)		+= crc32.o
-obj-$(CONFIG_8139TOO)		+= crc32.o
-obj-$(CONFIG_A2065)		+= crc32.o
-obj-$(CONFIG_ARM_AM79C961A)	+= crc32.o
-obj-$(CONFIG_AT1700)		+= crc32.o
-obj-$(CONFIG_ATP)		+= crc32.o
-obj-$(CONFIG_BMAC)		+= crc32.o
-obj-$(CONFIG_DE2104X)		+= crc32.o
-obj-$(CONFIG_DE4X5)		+= crc32.o
-obj-$(CONFIG_DECLANCE)		+= crc32.o
-obj-$(CONFIG_DEPCA)		+= crc32.o
-obj-$(CONFIG_DL2K)		+= crc32.o
-obj-$(CONFIG_DM9102)		+= crc32.o
-obj-$(CONFIG_EPIC100)		+= crc32.o
-obj-$(CONFIG_EWRK3)		+= crc32.o
-obj-$(CONFIG_FEALNX)		+= crc32.o
-obj-$(CONFIG_HAPPYMEAL)		+= crc32.o
-obj-$(CONFIG_MACE)		+= crc32.o	
-obj-$(CONFIG_MACMACE)		+= crc32.o
-obj-$(CONFIG_MIPS_AU1000_ENET)	+= crc32.o
-obj-$(CONFIG_NATSEMI)		+= crc32.o	
-obj-$(CONFIG_NE2K_CBUS)		+= crc32.o
-obj-$(CONFIG_PCMCIA_FMVJ18X)	+= crc32.o
-obj-$(CONFIG_PCMCIA_SMC91C92)	+= crc32.o
-obj-$(CONFIG_PCMCIA_XIRTULIP)	+= crc32.o
-obj-$(CONFIG_PCNET32)		+= crc32.o
-obj-$(CONFIG_SGI_IOC3_ETH)	+= crc32.o
-obj-$(CONFIG_SIS190)		+= crc32.o
-obj-$(CONFIG_SIS900)		+= crc32.o
-obj-$(CONFIG_SMC9194)		+= crc32.o
-obj-$(CONFIG_ADAPTEC_STARFIRE)	+= crc32.o
-obj-$(CONFIG_SUNBMAC)		+= crc32.o
-obj-$(CONFIG_SUNDANCE)		+= crc32.o
-obj-$(CONFIG_SUNGEM)		+= crc32.o
-obj-$(CONFIG_SUNGEM)		+= crc32.o
-obj-$(CONFIG_SUNLANCE)		+= crc32.o
-obj-$(CONFIG_SUNQE)		+= crc32.o
-obj-$(CONFIG_TULIP)		+= crc32.o
-obj-$(CONFIG_TYPHOON)		+= crc32.o
-obj-$(CONFIG_VIA_RHINE)		+= crc32.o
-obj-$(CONFIG_YELLOWFIN)		+= crc32.o
-obj-$(CONFIG_WINBOND_840)	+= crc32.o
-obj-$(CONFIG_R8169)		+= crc32.o
-obj-$(CONFIG_AMD8111_ETH)	+= crc32.o
-
-
-# These rely on drivers/net/7990.o which requires crc32.o
-obj-$(CONFIG_HPLANCE)		+= crc32.o	
-obj-$(CONFIG_MVME147_NET)	+= crc32.o	
-
-
-# These rely on drivers/net/8390.o which requires crc32.o
-obj-$(CONFIG_OAKNET)		+= crc32.o
-obj-$(CONFIG_NE2K_PCI)		+= crc32.o
-obj-$(CONFIG_STNIC)		+= crc32.o
-obj-$(CONFIG_MAC8390)		+= crc32.o
-obj-$(CONFIG_APNE)		+= crc32.o
-obj-$(CONFIG_PCMCIA_PCNET)	+= crc32.o
-obj-$(CONFIG_ARM_ETHERH)	+= crc32.o
-obj-$(CONFIG_WD80x3)		+= crc32.o
-obj-$(CONFIG_EL2)		+= crc32.o
-obj-$(CONFIG_NE2000)		+= crc32.o
-obj-$(CONFIG_NE2_MCA)		+= crc32.o
-obj-$(CONFIG_HPLAN)		+= crc32.o
-obj-$(CONFIG_HPLAN_PLUS)	+= crc32.o
-obj-$(CONFIG_ULTRA)		+= crc32.o
-obj-$(CONFIG_ULTRAMCA)		+= crc32.o
-obj-$(CONFIG_ULTRA32)		+= crc32.o
-obj-$(CONFIG_E2100)		+= crc32.o
-obj-$(CONFIG_ES3210)		+= crc32.o
-obj-$(CONFIG_LNE390)		+= crc32.o
-obj-$(CONFIG_NE3210)		+= crc32.o
-obj-$(CONFIG_AC3200)		+= crc32.o
-obj-$(CONFIG_ZORRO8390)		+= crc32.o
-obj-$(CONFIG_HYDRA)		+= crc32.o
diff -urN linux-2.6.0-test5-bk/drivers/net/pcmcia/Kconfig linux/drivers/net/pcmcia/Kconfig
--- linux-2.6.0-test5-bk/drivers/net/pcmcia/Kconfig	2003-09-26 09:30:41.847387896 -0400
+++ linux/drivers/net/pcmcia/Kconfig	2003-09-26 10:06:10.701752840 -0400
@@ -44,6 +44,7 @@
 config PCMCIA_FMVJ18X
 	tristate "Fujitsu FMV-J18x PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
+	select CRC32
 	help
 	  Say Y here if you intend to attach a Fujitsu FMV-J18x or compatible
 	  PCMCIA (PC-card) Ethernet card to your computer.
@@ -54,6 +55,7 @@
 config PCMCIA_PCNET
 	tristate "NE2000 compatible PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
+	select CRC32
 	help
 	  Say Y here if you intend to attach an NE2000 compatible PCMCIA
 	  (PC-card) Ethernet or Fast Ethernet card to your computer.
@@ -74,6 +76,7 @@
 config PCMCIA_SMC91C92
 	tristate "SMC 91Cxx PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
+	select CRC32
 	help
 	  Say Y here if you intend to attach an SMC 91Cxx compatible PCMCIA
 	  (PC-card) Ethernet or Fast Ethernet card to your computer.
diff -urN linux-2.6.0-test5-bk/drivers/net/tulip/Kconfig linux/drivers/net/tulip/Kconfig
--- linux-2.6.0-test5-bk/drivers/net/tulip/Kconfig	2003-09-26 09:30:42.218331504 -0400
+++ linux/drivers/net/tulip/Kconfig	2003-09-26 10:07:49.673706816 -0400
@@ -13,6 +13,7 @@
 config DE2104X
 	tristate "Early DECchip Tulip (dc2104x) PCI support (EXPERIMENTAL)"
 	depends on NET_TULIP && PCI && EXPERIMENTAL
+	select CRC32
 	---help---
 	  This driver is developed for the SMC EtherPower series Ethernet
 	  cards and also works with cards based on the DECchip
@@ -30,6 +31,7 @@
 config TULIP
 	tristate "DECchip Tulip (dc2114x) PCI support"
 	depends on NET_TULIP && PCI
+	select CRC32
 	---help---
 	  This driver is developed for the SMC EtherPower series Ethernet
 	  cards and also works with cards based on the DECchip 
@@ -69,6 +71,7 @@
 config DE4X5
 	tristate "Generic DECchip & DIGITAL EtherWORKS PCI/EISA"
 	depends on NET_TULIP && (PCI || EISA)
+	select CRC32
 	---help---
 	  This is support for the DIGITAL series of PCI/EISA Ethernet cards.
 	  These include the DE425, DE434, DE435, DE450 and DE500 models.  If
@@ -85,6 +88,7 @@
 config WINBOND_840
 	tristate "Winbond W89c840 Ethernet support"
 	depends on NET_TULIP && PCI
+	select CRC32
 	help
 	  This driver is for the Winbond W89c840 chip.  It also works with 
 	  the TX9882 chip on the Compex RL100-ATX board.
@@ -94,6 +98,7 @@
 config DM9102
 	tristate "Davicom DM910x/DM980x support"
 	depends on NET_TULIP && PCI
+	select CRC32
 	---help---
 	  This driver is for DM9102(A)/DM9132/DM9801 compatible PCI cards from
 	  Davicom (<http://www.davicom.com.tw/>).  If you have such a network
@@ -120,6 +125,7 @@
 config PCMCIA_XIRTULIP
 	tristate "Xircom Tulip-like CardBus support (old driver)"
 	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP
+	select CRC32
 	---help---
 	  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
 	  It should work with most DEC 21*4*-based chips/ethercards, as well
diff -urN linux-2.6.0-test5-bk/drivers/usb/Makefile.lib linux/drivers/usb/Makefile.lib
--- linux-2.6.0-test5-bk/drivers/usb/Makefile.lib	2003-09-26 09:30:43.216179808 -0400
+++ linux/drivers/usb/Makefile.lib	1969-12-31 19:00:00.000000000 -0500
@@ -1,3 +0,0 @@
-obj-$(CONFIG_USB_CATC)		+= crc32.o
-obj-$(CONFIG_USB_SPEEDTOUCH)	+= crc32.o
-obj-$(CONFIG_USB_USBNET)	+= crc32.o
diff -urN linux-2.6.0-test5-bk/drivers/usb/misc/Kconfig linux/drivers/usb/misc/Kconfig
--- linux-2.6.0-test5-bk/drivers/usb/misc/Kconfig	2003-09-26 09:30:43.419148952 -0400
+++ linux/drivers/usb/misc/Kconfig	2003-09-26 10:13:32.297620064 -0400
@@ -84,6 +84,7 @@
 config USB_SPEEDTOUCH
 	tristate "Alcatel Speedtouch USB support"
 	depends on USB && ATM
+	select CRC32
 	help
 	  Say Y here if you have an Alcatel SpeedTouch USB or SpeedTouch 330
 	  modem.  In order to use your modem you will need to install some user
diff -urN linux-2.6.0-test5-bk/drivers/usb/net/Kconfig linux/drivers/usb/net/Kconfig
--- linux-2.6.0-test5-bk/drivers/usb/net/Kconfig	2003-09-26 09:30:43.514134512 -0400
+++ linux/drivers/usb/net/Kconfig	2003-09-26 10:13:41.251258904 -0400
@@ -10,6 +10,7 @@
 config USB_CATC
 	tristate "USB CATC NetMate-based Ethernet device support (EXPERIMENTAL)"
 	depends on USB && NET && EXPERIMENTAL
+	select CRC32
 	---help---
 	  Say Y if you want to use one of the following 10Mbps USB Ethernet
 	  device based on the EL1210A chip. Supported devices are:
@@ -94,6 +95,7 @@
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
 	depends on USB && NET
+	select CRC32
 	---help---
 	  This driver supports several kinds of network links over USB,
 	  with "minidrivers" built around a common network driver core
diff -urN linux-2.6.0-test5-bk/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.0-test5-bk/fs/Kconfig	2003-09-26 09:30:44.235024920 -0400
+++ linux/fs/Kconfig	2003-09-26 10:15:11.029610520 -0400
@@ -1046,6 +1046,7 @@
 config JFFS2_FS
 	tristate "Journalling Flash File System v2 (JFFS2) support"
 	depends on MTD
+	select CRC32
 	help
 	  JFFS2 is the second generation of the Journalling Flash File System
 	  for use on diskless embedded devices. It provides improved wear
diff -urN linux-2.6.0-test5-bk/fs/Makefile.lib linux/fs/Makefile.lib
--- linux-2.6.0-test5-bk/fs/Makefile.lib	2003-07-27 12:57:15.000000000 -0400
+++ linux/fs/Makefile.lib	1969-12-31 19:00:00.000000000 -0500
@@ -1,2 +0,0 @@
-obj-$(CONFIG_JFFS2_FS)		+= crc32.o
-obj-$(CONFIG_EFI_PARTITION)	+= crc32.o
diff -urN linux-2.6.0-test5-bk/fs/partitions/Kconfig linux/fs/partitions/Kconfig
--- linux-2.6.0-test5-bk/fs/partitions/Kconfig	2003-07-27 13:08:29.000000000 -0400
+++ linux/fs/partitions/Kconfig	2003-09-26 10:15:42.318853832 -0400
@@ -227,6 +227,7 @@
 config EFI_PARTITION
 	bool "EFI GUID Partition support"
 	depends on PARTITION_ADVANCED
+	select CRC32
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using EFI GPT.  Presently only useful on the
diff -urN linux-2.6.0-test5-bk/lib/Makefile linux/lib/Makefile
--- linux-2.6.0-test5-bk/lib/Makefile	2003-07-27 12:57:00.000000000 -0400
+++ linux/lib/Makefile	2003-09-26 10:17:10.076512640 -0400
@@ -20,12 +20,6 @@
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
-include drivers/net/Makefile.lib
-include drivers/usb/Makefile.lib
-include fs/Makefile.lib
-include net/bluetooth/bnep/Makefile.lib
-include drivers/media/dvb/dvb-core/Makefile.lib
-
 host-progs	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff -urN linux-2.6.0-test5-bk/net/bluetooth/bnep/Kconfig linux/net/bluetooth/bnep/Kconfig
--- linux-2.6.0-test5-bk/net/bluetooth/bnep/Kconfig	2003-07-27 13:11:40.000000000 -0400
+++ linux/net/bluetooth/bnep/Kconfig	2003-09-26 10:16:49.961570576 -0400
@@ -1,6 +1,7 @@
 config BT_BNEP
 	tristate "BNEP protocol support"
 	depends on BT && BT_L2CAP
+	select CRC32
 	help
 	  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
 	  emulation layer on top of Bluetooth. BNEP is required for Bluetooth
diff -urN linux-2.6.0-test5-bk/net/bluetooth/bnep/Makefile.lib linux/net/bluetooth/bnep/Makefile.lib
--- linux-2.6.0-test5-bk/net/bluetooth/bnep/Makefile.lib	2003-07-27 13:12:05.000000000 -0400
+++ linux/net/bluetooth/bnep/Makefile.lib	1969-12-31 19:00:00.000000000 -0500
@@ -1 +0,0 @@
-obj-$(CONFIG_BT_BNEP) += crc32.o

--------------040303020500010602090603--

