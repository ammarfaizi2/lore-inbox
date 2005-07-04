Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVGDNYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVGDNYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGDNYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:24:20 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:18134 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261712AbVGDNNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:13:50 -0400
Date: Mon, 4 Jul 2005 15:13:19 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][Update 2] Kconfig changes: s/menu/menuconfig/
In-Reply-To: <Pine.LNX.4.58.0507011041480.3566@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041511530.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507011041480.3566@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Bodo Eggert wrote:

> Part 1b: The easy stuff for 2.6.13-rc1.

This is the same patch without the changes in /net, as requested by Sam
Ravnborg. It does include the first update.

--- rc1-a/drivers/md/Kconfig	2005-06-30 11:21:40.000000000 +0200
+++ rc1-b/drivers/md/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "Multi-device support (RAID and LVM)"
-
-config MD
+menuconfig MD
 	bool "Multiple devices driver support (RAID and LVM)"
 	help
@@ -236,5 +234,2 @@ config DM_MULTIPATH_EMC
 	---help---
 	  Multipath support for EMC CX/AX series hardware.
-
-endmenu
-
--- rc1-a/drivers/w1/Kconfig	2005-06-30 11:22:41.000000000 +0200
+++ rc1-b/drivers/w1/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,6 +1,4 @@
-menu "Dallas's 1-wire bus"
-
-config W1
-	tristate "Dallas's 1-wire support"
+menuconfig W1
+	tristate "Dallas's 1-wire bus support"
 	---help---
 	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
@@ -54,4 +52,2 @@ config W1_SMEM
 	  Say Y here if you want to connect 1-wire
 	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
-
-endmenu
--- rc1-a/drivers/i2c/Kconfig	2004-08-14 07:36:32.000000000 +0200
+++ rc1-b/drivers/i2c/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "I2C support"
-
-config I2C
+menuconfig I2C
 	tristate "I2C support"
 	---help---
@@ -73,5 +71,2 @@ config I2C_DEBUG_CHIP
 	  a problem with I2C support and want to see more of what is going
 	  on.
-
-endmenu
-
--- rc1-a/drivers/fc4/Kconfig	2004-08-14 07:36:56.000000000 +0200
+++ rc1-b/drivers/fc4/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "Fibre Channel support"
-
-config FC4
+menuconfig FC4
 	tristate "Fibre Channel and FC4 SCSI support"
 	---help---
@@ -77,5 +75,2 @@ config SCSI_FCAL
 	prompt "Generic FC-AL disk driver"
 	depends on FC4!=n && SCSI && !SPARC32 && !SPARC64
-
-endmenu
-
--- rc1-a/drivers/ide/Kconfig	2005-06-30 11:22:23.000000000 +0200
+++ rc1-b/drivers/ide/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -5,7 +5,5 @@
 #
 
-menu "ATA/ATAPI/MFM/RLL support"
-
-config IDE
+menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
 	---help---
@@ -1059,4 +1057,2 @@ config BLK_DEV_HD
 
 endif
-
-endmenu
--- rc1-a/drivers/mmc/Kconfig	2005-06-30 11:21:42.000000000 +0200
+++ rc1-b/drivers/mmc/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "MMC/SD Card support"
-
-config MMC
-	tristate "MMC support"
+menuconfig MMC
+	tristate "MMC/SD Card support"
 	help
 	  MMC is the "multi-media card" bus protocol.
@@ -60,4 +58,2 @@ config MMC_WBSD
 
 	  If unsure, say N.
-
-endmenu
--- rc1-a/drivers/net/wan/Kconfig	2005-06-30 11:22:37.000000000 +0200
+++ rc1-b/drivers/net/wan/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Wan interfaces"
-	depends on NETDEVICES
-
-config WAN
+menuconfig WAN
 	bool "Wan interfaces support"
+	depends on NETDEVICES
 	---help---
 	  Wide Area Networks (WANs), such as X.25, Frame Relay and leased
@@ -603,5 +601,2 @@ config SBNI_MULTILINE
 
 	  If unsure, say N.
-
-endmenu
-
--- rc1-a/drivers/net/irda/Kconfig	2005-06-30 11:21:44.000000000 +0200
+++ rc1-b/drivers/net/irda/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,6 +1,9 @@
 
-menu "Infrared-port device drivers"
+menuconfig IRDA_DEVICES
+	bool "Infrared-port device drivers"
 	depends on IRDA!=n
 
+if IRDA_DEVICES
+
 comment "SIR device drivers"
 
@@ -401,4 +404,3 @@ config VIA_FIR
 	  via-ircc.
 
-endmenu
-
+endif
--- rc1-a/drivers/net/tulip/Kconfig	2005-06-30 11:18:11.000000000 +0200
+++ rc1-b/drivers/net/tulip/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Tulip family network device support"
-	depends on NET_ETHERNET && (PCI || EISA || CARDBUS)
-
-config NET_TULIP
+menuconfig NET_TULIP
 	bool "\"Tulip\" family network device support"
+	depends on NET_ETHERNET && (PCI || EISA || CARDBUS)
 	help
 	  This selects the "Tulip" family of EISA/PCI network cards.
@@ -162,5 +160,2 @@ config PCMCIA_XIRTULIP
 	  <file:Documentation/networking/net-modules.txt>.  The module will
 	  be called xircom_tulip_cb.  If unsure, say N.
-
-endmenu
-
--- rc1-a/drivers/net/Kconfig	2005-06-30 11:22:26.000000000 +0200
+++ rc1-b/drivers/net/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -136,8 +136,6 @@ endif
 #
 
-menu "Ethernet (10 or 100Mbit)"
+menuconfig NET_ETHERNET
 	depends on NETDEVICES && !UML
-
-config NET_ETHERNET
 	bool "Ethernet (10 or 100Mbit)"
 	---help---
@@ -165,4 +163,6 @@ config NET_ETHERNET
 	  the questions about Ethernet network cards. If unsure, say N.
 
+if NET_ETHERNET
+
 config MII
 	tristate "Generic Media Independent Interface device support"
@@ -1752,5 +1752,5 @@ config NE_H8300
 source "drivers/net/fec_8xx/Kconfig"
 
-endmenu
+endif
 
 #
@@ -1758,7 +1758,10 @@ endmenu
 #
 
-menu "Ethernet (1000 Mbit)"
+menuconfig NET_ETHERNET1000
+	bool "Ethernet (1 Gbit)"
 	depends on NETDEVICES && !UML
 
+if NET_ETHERNET1000
+
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
@@ -2083,5 +2086,5 @@ config MV643XX_ETH_2
 	  Ethernet.
 
-endmenu
+endif
 
 #
@@ -2089,7 +2092,10 @@ endmenu
 #
 
-menu "Ethernet (10000 Mbit)"
+menuconfig NET_ETHERNET10_000
+	bool "Ethernet (10 Gbit)"
 	depends on NETDEVICES && !UML
 
+if NET_ETHERNET10_000
+
 config IXGB
 	tristate "Intel(R) PRO/10GbE support"
@@ -2167,5 +2173,5 @@ config 2BUFF_MODE
 	If not sure please say N.
 
-endmenu
+endif
 
 if !UML
--- rc1-a/drivers/net/arcnet/Kconfig	2005-06-30 11:20:35.000000000 +0200
+++ rc1-b/drivers/net/arcnet/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "ARCnet devices"
+menuconfig ARCNET
+	tristate "ARCnet device support"
 	depends on NETDEVICES && (ISA || PCI)
-
-config ARCNET
-	tristate "ARCnet support"
 	---help---
 	  If you have a network card of this type, say Y and check out the
@@ -136,5 +134,2 @@ config ARCNET_COM20020_PCI
 	tristate "Support for COM20020 on PCI"
 	depends on ARCNET_COM20020 && PCI
-
-endmenu
-
--- rc1-a/drivers/net/tokenring/Kconfig	2005-06-30 11:20:36.000000000 +0200
+++ rc1-b/drivers/net/tokenring/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,10 +3,8 @@
 #
 
-menu "Token Ring devices"
+menuconfig TR
 	depends on NETDEVICES
-
-# So far, we only have PCI, ISA, and MCA token ring devices
-config TR
 	bool "Token Ring driver support"
+# So far, we only have PCI, ISA, and MCA token ring devices
 	depends on (PCI || ISA || MCA || CCW)
 	select LLC
@@ -182,5 +180,2 @@ config SMCTR
 	  To compile this driver as a module, choose M here: the module will be
 	  called smctr.
-
-endmenu
-
--- rc1-a/drivers/net/pcmcia/Kconfig	2005-06-30 11:20:36.000000000 +0200
+++ rc1-b/drivers/net/pcmcia/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "PCMCIA network device support"
-	depends on NETDEVICES && PCMCIA!=n
-
-config NET_PCMCIA
+menuconfig NET_PCMCIA
 	bool "PCMCIA network device support"
+	depends on NETDEVICES && PCMCIA!=n
 	---help---
 	  Say Y if you would like to include support for any PCMCIA or CardBus
@@ -128,5 +126,2 @@ config PCMCIA_IBMTR
 	  To compile this driver as a module, choose M here: the module will be
 	  called ibmtr_cs.
-
-endmenu
-
--- rc1-a/drivers/net/wireless/Kconfig	2005-06-30 11:21:45.000000000 +0200
+++ rc1-b/drivers/net/wireless/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Wireless LAN (non-hamradio)"
-	depends on NETDEVICES
-
-config NET_RADIO
+menuconfig NET_RADIO
 	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
+	depends on NETDEVICES
 	---help---
 	  Support for wireless LANs and everything having to do with radio,
@@ -361,5 +359,2 @@ config NET_WIRELESS
 	depends on NET_RADIO && (ISA || PCI || PPC_PMAC || PCMCIA)
 	default y
-
-endmenu
-
--- rc1-a/drivers/mtd/nand/Kconfig	2005-06-30 11:20:35.000000000 +0200
+++ rc1-b/drivers/mtd/nand/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -2,9 +2,10 @@
 # $Id: Kconfig,v 1.26 2005/01/05 12:42:24 dwmw2 Exp $
 
-menu "NAND Flash Device Drivers"
-	depends on MTD!=n
+config MTD_NAND_IDS
+	depends on MTD
+	tristate
 
-config MTD_NAND
-	tristate "NAND Device Support"
+menuconfig MTD_NAND
+	tristate "NAND Flash Device Support"
 	depends on MTD
 	select MTD_NAND_IDS
@@ -56,7 +57,4 @@ config MTD_NAND_TOTO
 	  Support for NAND flash on Texas Instruments Toto platform.
 
-config MTD_NAND_IDS
-	tristate
-
 config MTD_NAND_TX4925NDFMC
 	tristate "SmartMedia Card on Toshiba RBTX4925 reference board"
@@ -204,4 +202,2 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
-endmenu
--- rc1-a/drivers/mtd/Kconfig	2005-06-30 11:21:42.000000000 +0200
+++ rc1-b/drivers/mtd/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,7 +1,5 @@
 # $Id: Kconfig,v 1.7 2004/11/22 11:33:56 ijc Exp $
 
-menu "Memory Technology Devices (MTD)"
-
-config MTD
+menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
@@ -261,5 +259,2 @@ source "drivers/mtd/devices/Kconfig"
 
 source "drivers/mtd/nand/Kconfig"
-
-endmenu
-
--- rc1-a/drivers/pci/hotplug/Kconfig	2005-06-30 11:20:37.000000000 +0200
+++ rc1-b/drivers/pci/hotplug/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "PCI Hotplug Support"
-
-config HOTPLUG_PCI
+menuconfig HOTPLUG_PCI
 	tristate "Support for PCI Hotplug (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
@@ -193,5 +191,2 @@ config HOTPLUG_PCI_SGI
 
 	  When in doubt, say N.
-
-endmenu
-
--- rc1-a/drivers/pnp/Kconfig	2005-06-30 11:19:30.000000000 +0200
+++ rc1-b/drivers/pnp/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "Plug and Play support"
-
-config PNP
+menuconfig PNP
 	bool "Plug and Play support"
 	depends on ISA || ACPI_BUS
@@ -37,5 +35,2 @@ source "drivers/pnp/pnpbios/Kconfig"
 
 source "drivers/pnp/pnpacpi/Kconfig"
-
-endmenu
-
--- rc1-a/drivers/usb/serial/Kconfig	2005-06-30 11:21:50.000000000 +0200
+++ rc1-b/drivers/usb/serial/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,5 @@
 #
 
-menu "USB Serial Converter support"
-	depends on USB!=n
-
-config USB_SERIAL
+menuconfig USB_SERIAL
 	tristate "USB Serial Converter support"
 	depends on USB
@@ -481,4 +478,2 @@ config USB_EZUSB
 	default y
 
-endmenu
-
--- rc1-a/drivers/acpi/Kconfig	2005-06-30 11:22:22.000000000 +0200
+++ rc1-b/drivers/acpi/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,13 +3,10 @@
 #
 
-menu "ACPI (Advanced Configuration and Power Interface) Support"
+menuconfig ACPI
+	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
 
-config ACPI
-	bool "ACPI Support"
-	depends on IA64 || X86
-
 	default y
 	---help---
@@ -352,4 +349,2 @@ config ACPI_HOTPLUG_MEMORY
 		$>modprobe acpi_memhotplug 
 endif	# ACPI
-
-endmenu
--- rc1-a/drivers/char/tpm/Kconfig	2005-06-30 11:21:32.000000000 +0200
+++ rc1-b/drivers/char/tpm/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "TPM devices"
-
-config TCG_TPM
+menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on EXPERIMENTAL && PCI
@@ -35,5 +33,2 @@ config TCG_ATMEL
 	  will be accessible from within Linux.  To compile this driver 
 	  as a module, choose M here; the module will be called tpm_atmel.
-
-endmenu
-
--- rc1-a/drivers/char/ipmi/Kconfig	2005-06-30 11:20:27.000000000 +0200
+++ rc1-b/drivers/char/ipmi/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,6 +3,5 @@
 #
 
-menu "IPMI"
-config IPMI_HANDLER
+menuconfig IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
@@ -64,4 +63,2 @@ config IPMI_POWEROFF
          This enables a function to power off the system with IPMI if
 	 the IPMI management controller is capable of this.
-
-endmenu
--- rc1-a/drivers/char/watchdog/Kconfig	2005-06-30 11:22:23.000000000 +0200
+++ rc1-b/drivers/char/watchdog/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,5 @@
 #
 
-menu "Watchdog Cards"
-
-config WATCHDOG
+menuconfig WATCHDOG
 	bool "Watchdog Timer Support"
 	---help---
@@ -556,4 +554,2 @@ config USBPCWATCHDOG
 
 	  Most people will say N.
-
-endmenu
--- rc1-a/drivers/isdn/hisax/Kconfig	2005-06-30 11:21:40.000000000 +0200
+++ rc1-b/drivers/isdn/hisax/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,8 +1,6 @@
 
-menu "Passive cards"
+menuconfig ISDN_DRV_HISAX
+	tristate "Passive cards (HiSax, HFC)"
 	depends on ISDN_I4L
-
-config ISDN_DRV_HISAX
-	tristate "HiSax SiemensChipSet driver support"
 	select CRC_CCITT
 	---help---
@@ -438,5 +436,2 @@ config HISAX_AVM_A1_PCMCIA
 
 endif
-
-endmenu
-
--- rc1-a/drivers/isdn/Kconfig	2004-08-14 07:38:04.000000000 +0200
+++ rc1-b/drivers/isdn/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "ISDN subsystem"
-
-config ISDN
-	tristate "ISDN support"
+menuconfig ISDN
+	tristate "ISDN subsystem"
 	depends on NET
 	---help---
@@ -63,5 +61,2 @@ source "drivers/isdn/capi/Kconfig"
 
 source "drivers/isdn/hardware/Kconfig"
-
-endmenu
-
--- rc1-a/drivers/isdn/hardware/avm/Kconfig	2005-06-30 11:19:17.000000000 +0200
+++ rc1-b/drivers/isdn/hardware/avm/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Active AVM cards"
+menuconfig CAPI_AVM
+	bool "Active AVM cards"
 	depends on NET && ISDN && ISDN_CAPI!=n
-
-config CAPI_AVM
-	bool "Support AVM cards"
 	help
 	  Enable support for AVM active ISDN cards.
@@ -62,5 +60,2 @@ config ISDN_DRV_AVMB1_C4
 	  Enable support for the AVM C4/C2 PCI cards.
 	  These cards handle 4/2 BRI ISDN lines (8/4 channels).
-
-endmenu
-
--- rc1-a/drivers/isdn/hardware/eicon/Kconfig	2004-08-14 07:36:59.000000000 +0200
+++ rc1-b/drivers/isdn/hardware/eicon/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Active Eicon DIVA Server cards"
-	depends on NET && ISDN && ISDN_CAPI!=n
-
-config CAPI_EICON
+menuconfig CAPI_EICON
 	bool "Support Eicon cards"
+	depends on NET && ISDN && ISDN_CAPI!=n
 	help
 	  Enable support for Eicon Networks active ISDN cards.
@@ -49,5 +47,2 @@ config ISDN_DIVAS_MAINT
 	help
 	  Enable Divas Maintainance driver.
-
-endmenu
-
--- rc1-a/drivers/scsi/Kconfig	2005-06-30 11:22:39.000000000 +0200
+++ rc1-b/drivers/scsi/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,5 +1,3 @@
-menu "SCSI device support"
-
-config SCSI
+menuconfig SCSI
 	tristate "SCSI device support"
 	---help---
@@ -1793,4 +1791,2 @@ endmenu
 
 source "drivers/scsi/pcmcia/Kconfig"
-
-endmenu
--- rc1-a/drivers/scsi/pcmcia/Kconfig	2004-08-14 07:37:25.000000000 +0200
+++ rc1-b/drivers/scsi/pcmcia/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,7 +3,10 @@
 #
 
-menu "PCMCIA SCSI adapter support"
+menuconfig SCSI_PCMCIA
+	bool "PCMCIA SCSI adapter support"
 	depends on SCSI!=n && PCMCIA!=n && MODULES
 
+if SCSI_PCMCIA
+
 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
@@ -80,3 +83,3 @@ config PCMCIA_SYM53C500
 	  module will be called sym53c500_cs.
 
-endmenu
+endif
--- rc1-a/drivers/infiniband/Kconfig	2005-06-30 11:20:30.000000000 +0200
+++ rc1-b/drivers/infiniband/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,5 +1,3 @@
-menu "InfiniBand support"
-
-config INFINIBAND
+menuconfig INFINIBAND
 	tristate "InfiniBand support"
 	---help---
@@ -11,4 +9,2 @@ source "drivers/infiniband/hw/mthca/Kcon
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
-
-endmenu
--- rc1-a/drivers/cdrom/Kconfig	2005-06-30 11:21:32.000000000 +0200
+++ rc1-b/drivers/cdrom/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,9 +3,7 @@
 #
 
-menu "Old CD-ROM drivers (not SCSI, not IDE)"
+menuconfig CD_NO_IDESCSI
+	bool "Old CD-ROM drivers (not SCSI, IDE or ATAPI)"
 	depends on ISA
-
-config CD_NO_IDESCSI
-	bool "Support non-SCSI/IDE/ATAPI CDROM drives"
 	---help---
 	  If you have a CD-ROM drive that is neither SCSI nor IDE/ATAPI, say Y
@@ -210,4 +208,2 @@ config CDU535
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonycd535.
-
-endmenu
--- rc1-a/drivers/media/dvb/Kconfig	2005-06-30 11:22:25.000000000 +0200
+++ rc1-b/drivers/media/dvb/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "Digital Video Broadcasting Devices"
-
-config DVB
-	bool "DVB For Linux"
+menuconfig DVB
+	bool "Digital Video Broadcasting Devices"
 	depends on NET && INET
 	---help---
@@ -44,4 +42,2 @@ comment "Supported DVB Frontends"
 	depends on DVB_CORE
 source "drivers/media/dvb/frontends/Kconfig"
-
-endmenu
--- rc1-a/drivers/video/logo/Kconfig	2005-06-30 11:21:52.000000000 +0200
+++ rc1-b/drivers/video/logo/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "Logo configuration"
-
-config LOGO
-	bool "Bootup logo"
+menuconfig LOGO
+	bool "Bootup logo configuration"
 	depends on FB || SGI_NEWPORT_CONSOLE
 
@@ -63,5 +61,2 @@ config LOGO_SUPERH_CLUT224
 	depends on LOGO && SUPERH
 	default y
-
-endmenu
-
--- rc1-a/drivers/message/i2o/Kconfig	2005-06-30 11:22:26.000000000 +0200
+++ rc1-b/drivers/message/i2o/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,6 +1,3 @@
-
-menu "I2O device support"
-
-config I2O
+menuconfig I2O
 	tristate "I2O support"
 	depends on PCI
@@ -107,5 +104,2 @@ config I2O_PROC
 	  To compile this support as a module, choose M here: the
 	  module will be called i2o_proc.
-
-endmenu
-
--- rc1-a/drivers/message/fusion/Kconfig	2005-06-30 11:22:25.000000000 +0200
+++ rc1-b/drivers/message/fusion/Kconfig	2005-06-30 11:13:57.000000000 +0200
@@ -1,4 +1,7 @@
 
-menu "Fusion MPT device support"
+menuconfig FUSION_DEVICES
+	bool "Fusion MPT device support"
+
+if FUSION_DEVICES
 
 config FUSION
@@ -84,3 +87,3 @@ config FUSION_LAN
 	  If unsure whether you really want or need this, say N.
 
-endmenu
+endif
--- rc1-a/drivers/ieee1394/Kconfig	2005-06-30 11:21:33.000000000 +0200
+++ rc1-b/drivers/ieee1394/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,7 +1,5 @@
 # -*- shell-script -*-
 
-menu "IEEE 1394 (FireWire) support"
-
-config IEEE1394
+menuconfig IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
 	depends on PCI || BROKEN
@@ -180,4 +178,2 @@ config IEEE1394_AMDTP
 	  To compile this driver as a module, say M here: the
 	  module will be called amdtp.
-
-endmenu
--- rc1-a/drivers/pcmcia/Kconfig	2005-06-30 11:22:38.000000000 +0200
+++ rc1-b/drivers/pcmcia/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -6,7 +6,5 @@
 #
 
-menu "PCCARD (PCMCIA/CardBus) support"
-
-config PCCARD
+menuconfig PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
 	select HOTPLUG
@@ -229,4 +227,2 @@ config PCCARD_NONSTATIC
 
 endif	# PCCARD
-
-endmenu
--- rc1-a/drivers/telephony/Kconfig	2004-08-14 07:36:32.000000000 +0200
+++ rc1-b/drivers/telephony/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "Telephony Support"
-
-config PHONE
-	tristate "Linux telephony support"
+menuconfig PHONE
+	tristate "Telephony support"
 	---help---
 	  Say Y here if you have a telephony card, which for example allows
@@ -43,5 +41,2 @@ config PHONE_IXJ_PCMCIA
 	  cards manufactured by Quicknet Technologies, Inc.  This changes the
 	  card initialization code to work with the card manager daemon.
-
-endmenu
-
--- rc1-a/drivers/parport/Kconfig	2005-06-30 11:21:45.000000000 +0200
+++ rc1-b/drivers/parport/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -6,7 +6,5 @@
 #
 
-menu "Parallel port support"
-
-config PARPORT
+menuconfig PARPORT
 	tristate "Parallel port support"
 	---help---
@@ -84,4 +82,5 @@ config PARPORT_PC_PCMCIA
 
 config PARPORT_NOT_PC
+	depends on PARPORT
 	bool
 
@@ -141,5 +140,2 @@ config PARPORT_1284
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.
-
-endmenu
-
--- rc1-a/fs/nls/Kconfig	2004-08-14 07:36:10.000000000 +0200
+++ rc1-b/fs/nls/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -3,8 +3,6 @@
 #
 
-menu "Native Language Support"
-
-config NLS
-	tristate "Base native language support"
+menuconfig NLS
+	tristate "Native language support"
 	---help---
 	  The base Native Language Support. A number of filesystems
@@ -501,4 +499,2 @@ config NLS_UTF8
 	  the Unicode/ISO9646 universal character set.
 
-endmenu
-
--- rc1-a/fs/xfs/Kconfig	2005-06-30 11:20:52.000000000 +0200
+++ rc1-b/fs/xfs/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1,6 +1,4 @@
-menu "XFS support"
-
-config XFS_FS
-	tristate "XFS filesystem support"
+menuconfig XFS_FS
+	tristate "XFS support"
 	select EXPORTFS if NFSD!=n
 	help
@@ -21,11 +19,13 @@ config XFS_FS
 	  to use an initial ramdisk (initrd) to boot.
 
+if XFS_FS
+
 config XFS_EXPORT
 	bool
-	default y if XFS_FS && EXPORTFS
+	default y if EXPORTFS
 
 config XFS_RT
 	bool "Realtime support (EXPERIMENTAL)"
-	depends on XFS_FS && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  If you say Y here you will be able to mount and use XFS filesystems
@@ -44,5 +44,4 @@ config XFS_RT
 config XFS_QUOTA
 	bool "Quota support"
-	depends on XFS_FS
 	help
 	  If you say Y here, you will be able to set limits for disk usage on
@@ -61,5 +60,4 @@ config XFS_QUOTA
 config XFS_SECURITY
 	bool "Security Label support"
-	depends on XFS_FS
 	help
 	  Security labels support alternative access control models
@@ -73,5 +71,4 @@ config XFS_SECURITY
 config XFS_POSIX_ACL
 	bool "POSIX ACL support"
-	depends on XFS_FS
 	help
 	  POSIX Access Control Lists (ACLs) support permissions for users and
@@ -83,3 +80,3 @@ config XFS_POSIX_ACL
 	  If you don't know what Access Control Lists are, say N.
 
-endmenu
+endif
--- rc1-a/fs/Kconfig	2005-06-30 11:22:41.000000000 +0200
+++ rc1-b/fs/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -1728,10 +1728,6 @@ config RXRPC
 endmenu
 
-menu "Partition Types"
-
 source "fs/partitions/Kconfig"
 
-endmenu
-
 source "fs/nls/Kconfig"
 
--- rc1-a/init/Kconfig	2005-06-30 11:22:50.000000000 +0200
+++ rc1-b/init/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -392,8 +392,6 @@ config BASE_SMALL
 	default 1 if !BASE_FULL
 
-menu "Loadable module support"
-
-config MODULES
-	bool "Enable loadable module support"
+menuconfig MODULES
+	bool "Loadable module support"
 	help
 	  Kernel modules are small pieces of compiled code which can
@@ -414,7 +412,8 @@ config MODULES
 	  If unsure, say Y.
 
+if MODULES
+
 config MODULE_UNLOAD
 	bool "Module unloading"
-	depends on MODULES
 	help
 	  Without this option you will not be able to unload any
@@ -436,5 +435,4 @@ config OBSOLETE_MODPARM
 	bool
 	default y
-	depends on MODULES
 	help
 	  You need this option to use module parameters on modules which
@@ -444,5 +442,5 @@ config OBSOLETE_MODPARM
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Usually, you have to use modules compiled with your kernel.
@@ -455,5 +453,4 @@ config MODVERSIONS
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
-	depends on MODULES
 	help
 	  Modules which contain a MODULE_VERSION get an extra "srcversion"
@@ -467,5 +464,4 @@ config MODULE_SRCVERSION_ALL
 config KMOD
 	bool "Automatic kernel module loading"
-	depends on MODULES
 	help
 	  Normally when you have selected some parts of the kernel to
@@ -483,3 +479,4 @@ config STOP_MACHINE
 	help
 	  Need stop_machine() primitive.
-endmenu
+
+endif
--- rc1-a/sound/Kconfig	2005-06-30 11:22:53.000000000 +0200
+++ rc1-b/sound/Kconfig	2005-06-30 11:06:30.000000000 +0200
@@ -2,7 +2,5 @@
 #
 
-menu "Sound"
-
-config SOUND
+menuconfig SOUND
 	tristate "Sound card support"
 	help
@@ -33,12 +31,11 @@ config SOUND
 	  package, available at <ftp://ftp.infradead.org/pub/pcsp/>.
 
+if SOUND
+
 source "sound/oss/dmasound/Kconfig"
 
 if !M68K
 
-menu "Advanced Linux Sound Architecture"
-	depends on SOUND!=n
-
-config SND
+menuconfig SND
 	tristate "Advanced Linux Sound Architecture"
 	depends on SOUND
@@ -75,12 +72,7 @@ source "sound/sparc/Kconfig"
 source "sound/parisc/Kconfig"
 
-endmenu
-
-menu "Open Sound System"
-	depends on SOUND!=n && (BROKEN || (!SPARC32 && !SPARC64))
-
-config SOUND_PRIME
+menuconfig SOUND_PRIME
 	tristate "Open Sound System (DEPRECATED)"
-	depends on SOUND
+	depends on SOUND && (BROKEN || (!SPARC32 && !SPARC64))
 	help
 	  Say 'Y' or 'M' to enable Open Sound System drivers.
@@ -88,7 +80,5 @@ config SOUND_PRIME
 source "sound/oss/Kconfig"
 
-endmenu
-
 endif
 
-endmenu
+endif
--- x/fs/partitions/Kconfig	2005-07-04 13:50:38.000000000 +0200
+++ b/fs/partitions/Kconfig	2005-06-30 09:39:18.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Partition configuration
 #
-config PARTITION_ADVANCED
+menuconfig PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
 	  Say Y here if you would like to use hard disks under Linux which
--- x/sound/oss/Kconfig	2005-07-04 13:50:55.000000000 +0200
+++ b/sound/oss/Kconfig	2005-06-29 16:49:05.000000000 +0200
@@ -1084,7 +1084,7 @@ config SOUND_TVMIXER
 
 config SOUND_KAHLUA
 	tristate "XpressAudio Sound Blaster emulation"
-	depends on SOUND_SB
+	depends on SOUND_SB && SOUND_PRIME
 
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"
--- x/sound/oss/dmasound/Kconfig	2005-07-04 13:47:08.000000000 +0200
+++ b/sound/oss/dmasound/Kconfig	2005-06-29 16:45:48.000000000 +0200
@@ -56,3 +56,4 @@ config DMASOUND_Q40
 
 config DMASOUND
 	tristate
+	depends on SOUND
-- 
Top 100 things you don't want the sysadmin to say:
44. System coming down in 0 min....
