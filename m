Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGQL2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGQL2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGQL2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:28:51 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:42456 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261256AbVGQL2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:28:46 -0400
Date: Sun, 17 Jul 2005 13:29:03 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507171326470.6041@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Bodo Eggert wrote:

> These patches change some menus into menuconfig options.
> 
> Reworked to apply to linux-2.6.13-rc3-git3

Mostly robotic works.

 drivers/acpi/Kconfig                |   10 ++--------
 drivers/cdrom/Kconfig               |    8 ++------
 drivers/char/ipmi/Kconfig           |    5 +----
 drivers/char/tpm/Kconfig            |    7 +------
 drivers/char/watchdog/Kconfig       |    6 +-----
 drivers/fc4/Kconfig                 |    7 +------
 drivers/i2c/Kconfig                 |    7 +------
 drivers/ide/Kconfig                 |    6 +-----
 drivers/ieee1394/Kconfig            |    6 +-----
 drivers/infiniband/Kconfig          |    6 +-----
 drivers/isdn/Kconfig                |    9 ++-------
 drivers/isdn/hardware/avm/Kconfig   |    9 ++-------
 drivers/isdn/hardware/eicon/Kconfig |    9 ++-------
 drivers/isdn/hisax/Kconfig          |    9 ++-------
 drivers/md/Kconfig                  |    7 +------
 drivers/media/dvb/Kconfig           |    8 ++------
 drivers/message/fusion/Kconfig      |   16 ++++++----------
 drivers/message/i2o/Kconfig         |    8 +-------
 drivers/mmc/Kconfig                 |    8 ++------
 drivers/mtd/Kconfig                 |    7 +------
 drivers/mtd/nand/Kconfig            |   14 +++++---------
 drivers/net/Kconfig                 |   22 ++++++++++++++--------
 drivers/net/arcnet/Kconfig          |    9 ++-------
 drivers/net/irda/Kconfig            |    8 +++++---
 drivers/net/pcmcia/Kconfig          |    9 ++-------
 drivers/net/tokenring/Kconfig       |    9 ++-------
 drivers/net/tulip/Kconfig           |    9 ++-------
 drivers/net/wan/Kconfig             |    9 ++-------
 drivers/net/wireless/Kconfig        |    9 ++-------
 drivers/parport/Kconfig             |    8 ++------
 drivers/pci/hotplug/Kconfig         |    7 +------
 drivers/pcmcia/Kconfig              |    6 +-----
 drivers/pnp/Kconfig                 |    7 +------
 drivers/scsi/Kconfig                |    6 +-----
 drivers/scsi/pcmcia/Kconfig         |    7 +++++--
 drivers/telephony/Kconfig           |    9 ++-------
 drivers/usb/serial/Kconfig          |    7 +------
 drivers/video/logo/Kconfig          |    9 ++-------
 drivers/w1/Kconfig                  |    8 ++------
 fs/Kconfig                          |    4 ----
 fs/nls/Kconfig                      |    8 ++------
 fs/partitions/Kconfig               |    2 +-
 fs/xfs/Kconfig                      |   17 +++++++----------
 init/Kconfig                        |   17 +++++++----------
 sound/Kconfig                       |   25 +++++++------------------
 sound/oss/Kconfig                   |    2 +-
 46 files changed, 112 insertions(+), 293 deletions(-)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -rNup a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/acpi/Kconfig	2005-07-17 08:26:09.000000000 +0200
@@ -2,16 +2,12 @@
 # ACPI Configuration
 #
 
-menu "ACPI (Advanced Configuration and Power Interface) Support"
+menuconfig ACPI
+	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on PM
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
-
-config ACPI
-	bool "ACPI Support"
-	depends on IA64 || X86
-
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
@@ -363,5 +359,3 @@ config ACPI_HOTPLUG_MEMORY
 	  command: 
 		$>modprobe acpi_memhotplug 
 endif	# ACPI
-
-endmenu
diff -rNup a/drivers/cdrom/Kconfig b/drivers/cdrom/Kconfig
--- a/drivers/cdrom/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/cdrom/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # CDROM driver configuration
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
 	  here, otherwise N. Read the CD-ROM-HOWTO, available from
@@ -209,5 +207,3 @@ config CDU535
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonycd535.
-
-endmenu
diff -rNup a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
--- a/drivers/char/ipmi/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/char/ipmi/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,8 +2,7 @@
 # IPMI device configuration
 #
 
-menu "IPMI"
-config IPMI_HANDLER
+menuconfig IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
          This enables the central IPMI message handler, required for IPMI
@@ -63,5 +62,3 @@ config IPMI_POWEROFF
        help
          This enables a function to power off the system with IPMI if
 	 the IPMI management controller is capable of this.
-
-endmenu
diff -rNup a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
--- a/drivers/char/tpm/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/char/tpm/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # TPM device configuration
 #
 
-menu "TPM devices"
-
-config TCG_TPM
+menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on EXPERIMENTAL && PCI
 	---help---
@@ -34,6 +32,3 @@ config TCG_ATMEL
 	  If you have a TPM security chip from Atmel say Yes and it 
 	  will be accessible from within Linux.  To compile this driver 
 	  as a module, choose M here; the module will be called tpm_atmel.
-
-endmenu
-
diff -rNup a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/char/watchdog/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # Watchdog device configuration
 #
 
-menu "Watchdog Cards"
-
-config WATCHDOG
+menuconfig WATCHDOG
 	bool "Watchdog Timer Support"
 	---help---
 	  If you say Y here (and to one of the following options) and create a
@@ -555,5 +553,3 @@ config USBPCWATCHDOG
 	  module will be called pcwd_usb.
 
 	  Most people will say N.
-
-endmenu
diff -rNup a/drivers/fc4/Kconfig b/drivers/fc4/Kconfig
--- a/drivers/fc4/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/fc4/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # FC4 device configuration
 #
 
-menu "Fibre Channel support"
-
-config FC4
+menuconfig FC4
 	tristate "Fibre Channel and FC4 SCSI support"
 	---help---
 	  Fibre Channel is a high speed serial protocol mainly used to
@@ -76,6 +74,3 @@ config SCSI_FCAL
 config SCSI_FCAL
 	prompt "Generic FC-AL disk driver"
 	depends on FC4!=n && SCSI && !SPARC32 && !SPARC64
-
-endmenu
-
diff -rNup a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/i2c/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # Character device configuration
 #
 
-menu "I2C support"
-
-config I2C
+menuconfig I2C
 	tristate "I2C support"
 	---help---
 	  I2C (pronounce: I-square-C) is a slow serial bus protocol used in
@@ -72,6 +70,3 @@ config I2C_DEBUG_CHIP
 	  debug messages to the system log.  Select this if you are having
 	  a problem with I2C support and want to see more of what is going
 	  on.
-
-endmenu
-
diff -rNup a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/ide/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -4,9 +4,7 @@
 # Andre Hedrick <andre@linux-ide.org>
 #
 
-menu "ATA/ATAPI/MFM/RLL support"
-
-config IDE
+menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
 	---help---
 	  If you say Y here, your kernel will be able to manage low cost mass
@@ -1058,5 +1056,3 @@ config BLK_DEV_HD
 	def_bool BLK_DEV_HD_IDE || BLK_DEV_HD_ONLY
 
 endif
-
-endmenu
diff -rNup a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
--- a/drivers/ieee1394/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/ieee1394/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,8 +1,6 @@
 # -*- shell-script -*-
 
-menu "IEEE 1394 (FireWire) support"
-
-config IEEE1394
+menuconfig IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
 	depends on PCI || BROKEN
 	select NET
@@ -191,5 +189,3 @@ config IEEE1394_AMDTP
 
 	  To compile this driver as a module, say M here: the
 	  module will be called amdtp.
-
-endmenu
diff -rNup a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/infiniband/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,6 +1,4 @@
-menu "InfiniBand support"
-
-config INFINIBAND
+menuconfig INFINIBAND
 	tristate "InfiniBand support"
 	---help---
 	  Core support for InfiniBand (IB).  Make sure to also select
@@ -20,5 +18,3 @@ config INFINIBAND_USER_VERBS
 source "drivers/infiniband/hw/mthca/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
-
-endmenu
diff -rNup a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
--- a/drivers/isdn/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/isdn/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,8 @@
 # ISDN device configuration
 #
 
-menu "ISDN subsystem"
-
-config ISDN
-	tristate "ISDN support"
+menuconfig ISDN
+	tristate "ISDN subsystem"
 	depends on NET
 	---help---
 	  ISDN ("Integrated Services Digital Networks", called RNIS in France)
@@ -62,6 +60,3 @@ config ISDN_CAPI
 source "drivers/isdn/capi/Kconfig"
 
 source "drivers/isdn/hardware/Kconfig"
-
-endmenu
-
diff -rNup a/drivers/isdn/hardware/avm/Kconfig b/drivers/isdn/hardware/avm/Kconfig
--- a/drivers/isdn/hardware/avm/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/isdn/hardware/avm/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # ISDN AVM drivers
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
 
@@ -61,6 +59,3 @@ config ISDN_DRV_AVMB1_C4
 	help
 	  Enable support for the AVM C4/C2 PCI cards.
 	  These cards handle 4/2 BRI ISDN lines (8/4 channels).
-
-endmenu
-
diff -rNup a/drivers/isdn/hardware/eicon/Kconfig b/drivers/isdn/hardware/eicon/Kconfig
--- a/drivers/isdn/hardware/eicon/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/isdn/hardware/eicon/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # ISDN DIVAS Eicon driver
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
 
@@ -48,6 +46,3 @@ config ISDN_DIVAS_MAINT
 	depends on ISDN_DIVAS && m
 	help
 	  Enable Divas Maintainance driver.
-
-endmenu
-
diff -rNup a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
--- a/drivers/isdn/hisax/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/isdn/hisax/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,9 +1,7 @@
 
-menu "Passive cards"
+menuconfig ISDN_DRV_HISAX
+	tristate "Passive cards (HiSax, HFC)"
 	depends on ISDN_I4L
-
-config ISDN_DRV_HISAX
-	tristate "HiSax SiemensChipSet driver support"
 	select CRC_CCITT
 	---help---
 	  This is a driver supporting the Siemens chipset on various
@@ -437,6 +435,3 @@ config HISAX_AVM_A1_PCMCIA
 	default y
 
 endif
-
-endmenu
-
diff -rNup a/drivers/md/Kconfig b/drivers/md/Kconfig
--- a/drivers/md/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/md/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # Block device driver configuration
 #
 
-menu "Multi-device support (RAID and LVM)"
-
-config MD
+menuconfig MD
 	bool "Multiple devices driver support (RAID and LVM)"
 	help
 	  Support multiple physical spindles through a single logical device.
@@ -235,6 +233,3 @@ config DM_MULTIPATH_EMC
 	depends on DM_MULTIPATH && BLK_DEV_DM && EXPERIMENTAL
 	---help---
 	  Multipath support for EMC CX/AX series hardware.
-
-endmenu
-
diff -rNup a/drivers/media/dvb/Kconfig b/drivers/media/dvb/Kconfig
--- a/drivers/media/dvb/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/media/dvb/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,8 @@
 # Multimedia device configuration
 #
 
-menu "Digital Video Broadcasting Devices"
-
-config DVB
-	bool "DVB For Linux"
+menuconfig DVB
+	bool "Digital Video Broadcasting Devices"
 	depends on NET && INET
 	---help---
 	  Support Digital Video Broadcasting hardware.  Enable this if you
@@ -47,5 +45,3 @@ source "drivers/media/dvb/pluto2/Kconfig
 comment "Supported DVB Frontends"
 	depends on DVB_CORE
 source "drivers/media/dvb/frontends/Kconfig"
-
-endmenu
diff -rNup a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
--- a/drivers/message/fusion/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/message/fusion/Kconfig	2005-07-17 09:21:13.000000000 +0200
@@ -1,14 +1,13 @@
 
-menu "Fusion MPT device support"
-
-config FUSION
-	bool
+menuconfig FUSION
+	bool "Fusion MPT device support"
+	depends on PCI && SCSI
 	default n
 
+if FUSION
+
 config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
-	depends on PCI && SCSI
-	select FUSION
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
 
@@ -21,8 +20,6 @@ config FUSION_SPI
 
 config FUSION_FC
 	tristate "Fusion MPT ScsiHost drivers for FC"
-	depends on PCI && SCSI
-	select FUSION
 	---help---
 	  SCSI HOST support for a Fiber Channel host adapters.
 
@@ -37,7 +34,6 @@ config FUSION_FC
 
 config FUSION_MAX_SGE
 	int "Maximum number of scatter gather entries (16 - 128)"
-	depends on FUSION
 	default "128"
 	range 16 128
 	help
@@ -83,4 +79,4 @@ config FUSION_LAN
 
 	  If unsure whether you really want or need this, say N.
 
-endmenu
+endif
diff -rNup a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
--- a/drivers/message/i2o/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/message/i2o/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,7 +1,4 @@
-
-menu "I2O device support"
-
-config I2O
+menuconfig I2O
 	tristate "I2O support"
 	depends on PCI
 	---help---
@@ -106,6 +103,3 @@ config I2O_PROC
 
 	  To compile this support as a module, choose M here: the
 	  module will be called i2o_proc.
-
-endmenu
-
diff -rNup a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
--- a/drivers/mmc/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/mmc/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,8 @@
 # MMC subsystem configuration
 #
 
-menu "MMC/SD Card support"
-
-config MMC
-	tristate "MMC support"
+menuconfig MMC
+	tristate "MMC/SD Card support"
 	help
 	  MMC is the "multi-media card" bus protocol.
 
@@ -59,5 +57,3 @@ config MMC_WBSD
 	  SD/MMC card reader, say Y or M here.
 
 	  If unsure, say N.
-
-endmenu
diff -rNup a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
--- a/drivers/mtd/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/mtd/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,8 +1,6 @@
 # $Id: Kconfig,v 1.7 2004/11/22 11:33:56 ijc Exp $
 
-menu "Memory Technology Devices (MTD)"
-
-config MTD
+menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
@@ -260,6 +258,3 @@ source "drivers/mtd/maps/Kconfig"
 source "drivers/mtd/devices/Kconfig"
 
 source "drivers/mtd/nand/Kconfig"
-
-endmenu
-
diff -rNup a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
--- a/drivers/mtd/nand/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/mtd/nand/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,11 +1,12 @@
 # drivers/mtd/nand/Kconfig
 # $Id: Kconfig,v 1.31 2005/06/20 12:03:21 bjd Exp $
 
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
 	help
@@ -55,9 +56,6 @@ config MTD_NAND_TOTO
 	help
 	  Support for NAND flash on Texas Instruments Toto platform.
 
-config MTD_NAND_IDS
-	tristate
-
 config MTD_NAND_AU1550
 	tristate "Au1550 NAND support"
 	depends on SOC_AU1550 && MTD_NAND
@@ -190,5 +188,3 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
-endmenu
diff -rNup a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -137,10 +137,8 @@ endif
 #	Ethernet
 #
 
-menu "Ethernet (10 or 100Mbit)"
+menuconfig NET_ETHERNET
 	depends on NETDEVICES && !UML
-
-config NET_ETHERNET
 	bool "Ethernet (10 or 100Mbit)"
 	---help---
 	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
@@ -166,6 +164,8 @@ config NET_ETHERNET
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
 
+if NET_ETHERNET
+
 config MII
 	tristate "Generic Media Independent Interface device support"
 	depends on NET_ETHERNET
@@ -1753,15 +1753,18 @@ config NE_H8300
 
 source "drivers/net/fec_8xx/Kconfig"
 
-endmenu
+endif
 
 #
 #	Gigabit Ethernet
 #
 
-menu "Ethernet (1000 Mbit)"
+menuconfig NET_ETHERNET1000
+	bool "Ethernet (1 Gbit)"
 	depends on NETDEVICES && !UML
 
+if NET_ETHERNET1000
+
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
 	depends on PCI
@@ -2084,15 +2087,18 @@ config MV643XX_ETH_2
 	  This enables support for Port 2 of the Marvell MV643XX Gigabit
 	  Ethernet.
 
-endmenu
+endif
 
 #
 #	10 Gigabit Ethernet
 #
 
-menu "Ethernet (10000 Mbit)"
+menuconfig NET_ETHERNET10_000
+	bool "Ethernet (10 Gbit)"
 	depends on NETDEVICES && !UML
 
+if NET_ETHERNET10_000
+
 config IXGB
 	tristate "Intel(R) PRO/10GbE support"
 	depends on PCI
@@ -2168,7 +2174,7 @@ config 2BUFF_MODE
 	physical memory loactions comes with a heavy price.
 	If not sure please say N.
 
-endmenu
+endif
 
 if !UML
 source "drivers/net/tokenring/Kconfig"
diff -rNup a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
--- a/drivers/net/arcnet/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/arcnet/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # Arcnet configuration
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
 	  (arguably) beautiful poetry in
@@ -135,6 +133,3 @@ config ARCNET_COM20020_ISA
 config ARCNET_COM20020_PCI
 	tristate "Support for COM20020 on PCI"
 	depends on ARCNET_COM20020 && PCI
-
-endmenu
-
diff -rNup a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
--- a/drivers/net/irda/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/irda/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,7 +1,10 @@
 
-menu "Infrared-port device drivers"
+menuconfig IRDA_DEVICES
+	bool "Infrared-port device drivers"
 	depends on IRDA!=n
 
+if IRDA_DEVICES
+
 comment "SIR device drivers"
 
 config IRTTY_SIR
@@ -400,5 +403,4 @@ config VIA_FIR
 	  To compile it as a module, choose M here: the module will be called
 	  via-ircc.
 
-endmenu
-
+endif
diff -rNup a/drivers/net/pcmcia/Kconfig b/drivers/net/pcmcia/Kconfig
--- a/drivers/net/pcmcia/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/pcmcia/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # PCMCIA Network device configuration
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
 	  network adapters, then say Y to the driver for your particular card
@@ -127,6 +125,3 @@ config PCMCIA_IBMTR
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ibmtr_cs.
-
-endmenu
-
diff -rNup a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/tokenring/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,12 +2,10 @@
 # Token Ring driver configuration
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
 	help
@@ -181,6 +179,3 @@ config SMCTR
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called smctr.
-
-endmenu
-
diff -rNup a/drivers/net/tulip/Kconfig b/drivers/net/tulip/Kconfig
--- a/drivers/net/tulip/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/tulip/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # Tulip family network device configuration
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
 
@@ -161,6 +159,3 @@ config PCMCIA_XIRTULIP
 	  To compile this driver as a module, choose M here and read
 	  <file:Documentation/networking/net-modules.txt>.  The module will
 	  be called xircom_tulip_cb.  If unsure, say N.
-
-endmenu
-
diff -rNup a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
--- a/drivers/net/wan/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/wan/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # wan devices configuration
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
 	  lines, are used to interconnect Local Area Networks (LANs) over vast
@@ -602,6 +600,3 @@ config SBNI_MULTILINE
 	  a program named 'sbniconfig' to configure adapters.
 
 	  If unsure, say N.
-
-endmenu
-
diff -rNup a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/net/wireless/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,11 +2,9 @@
 # Wireless LAN device configuration
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
 	  but not with amateur radio or FM broadcasting.
@@ -360,6 +358,3 @@ config NET_WIRELESS
 	bool
 	depends on NET_RADIO && (ISA || PCI || PPC_PMAC || PCMCIA)
 	default y
-
-endmenu
-
diff -rNup a/drivers/parport/Kconfig b/drivers/parport/Kconfig
--- a/drivers/parport/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/parport/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -5,9 +5,7 @@
 # Parport configuration.
 #
 
-menu "Parallel port support"
-
-config PARPORT
+menuconfig PARPORT
 	tristate "Parallel port support"
 	---help---
 	  If you want to use devices connected to your machine's parallel port
@@ -83,6 +81,7 @@ config PARPORT_PC_PCMCIA
 	  ports. If unsure, say N.
 
 config PARPORT_NOT_PC
+	depends on PARPORT
 	bool
 
 config PARPORT_ARC
@@ -140,6 +139,3 @@ config PARPORT_1284
 	  such as EPP and ECP, say Y here to enable advanced IEEE 1284
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.
-
-endmenu
-
diff -rNup a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/pci/hotplug/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # PCI Hotplug support
 #
 
-menu "PCI Hotplug Support"
-
-config HOTPLUG_PCI
+menuconfig HOTPLUG_PCI
 	tristate "Support for PCI Hotplug (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
 	select HOTPLUG
@@ -193,6 +191,3 @@ config HOTPLUG_PCI_SGI
 	  Driver for PCI devices.
 
 	  When in doubt, say N.
-
-endmenu
-
diff -rNup a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/pcmcia/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # PCCARD (PCMCIA/CardBus) bus subsystem configuration
 #
 
-menu "PCCARD (PCMCIA/CardBus) support"
-
-config PCCARD
+menuconfig PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
 	select HOTPLUG
 	---help---
@@ -225,5 +223,3 @@ config PCCARD_NONSTATIC
 	tristate
 
 endif	# PCCARD
-
-endmenu
diff -rNup a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
--- a/drivers/pnp/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/pnp/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,7 @@
 # Plug and Play configuration
 #
 
-menu "Plug and Play support"
-
-config PNP
+menuconfig PNP
 	bool "Plug and Play support"
 	depends on ISA || ACPI_BUS
 	---help---
@@ -36,6 +34,3 @@ source "drivers/pnp/isapnp/Kconfig"
 source "drivers/pnp/pnpbios/Kconfig"
 
 source "drivers/pnp/pnpacpi/Kconfig"
-
-endmenu
-
diff -rNup a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/scsi/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,6 +1,4 @@
-menu "SCSI device support"
-
-config SCSI
+menuconfig SCSI
 	tristate "SCSI device support"
 	---help---
 	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
@@ -1792,5 +1790,3 @@ config ZFCP
 endmenu
 
 source "drivers/scsi/pcmcia/Kconfig"
-
-endmenu
diff -rNup a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
--- a/drivers/scsi/pcmcia/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/scsi/pcmcia/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,9 +2,12 @@
 # PCMCIA SCSI adapter configuration
 #
 
-menu "PCMCIA SCSI adapter support"
+menuconfig SCSI_PCMCIA
+	bool "PCMCIA SCSI adapter support"
 	depends on SCSI!=n && PCMCIA!=n && MODULES
 
+if SCSI_PCMCIA
+
 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
 	depends on m && !64BIT
@@ -79,4 +82,4 @@ config PCMCIA_SYM53C500
 	  To compile this driver as a module, choose M here: the
 	  module will be called sym53c500_cs.
 
-endmenu
+endif
diff -rNup a/drivers/telephony/Kconfig b/drivers/telephony/Kconfig
--- a/drivers/telephony/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/telephony/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,8 @@
 # Telephony device configuration
 #
 
-menu "Telephony Support"
-
-config PHONE
-	tristate "Linux telephony support"
+menuconfig PHONE
+	tristate "Telephony support"
 	---help---
 	  Say Y here if you have a telephony card, which for example allows
 	  you to use a regular phone for voice-over-IP applications.
@@ -42,6 +40,3 @@ config PHONE_IXJ_PCMCIA
 	  Say Y here to configure in PCMCIA service support for the Quicknet
 	  cards manufactured by Quicknet Technologies, Inc.  This changes the
 	  card initialization code to work with the card manager daemon.
-
-endmenu
-
diff -rNup a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
--- a/drivers/usb/serial/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/usb/serial/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,7 @@
 # USB Serial device configuration
 #
 
-menu "USB Serial Converter support"
-	depends on USB!=n
-
-config USB_SERIAL
+menuconfig USB_SERIAL
 	tristate "USB Serial Converter support"
 	depends on USB
 	---help---
@@ -480,5 +477,3 @@ config USB_EZUSB
 	depends on USB_SERIAL_KEYSPAN_PDA || USB_SERIAL_XIRCOM || USB_SERIAL_KEYSPAN || USB_SERIAL_WHITEHEAT
 	default y
 
-endmenu
-
diff -rNup a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
--- a/drivers/video/logo/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/video/logo/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -2,10 +2,8 @@
 # Logo configuration
 #
 
-menu "Logo configuration"
-
-config LOGO
-	bool "Bootup logo"
+menuconfig LOGO
+	bool "Bootup logo configuration"
 	depends on FB || SGI_NEWPORT_CONSOLE
 
 config LOGO_LINUX_MONO
@@ -67,6 +65,3 @@ config LOGO_M32R_CLUT224
 	bool "224-color M32R Linux logo"
 	depends on LOGO && M32R
 	default y
-
-endmenu
-
diff -rNup a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/drivers/w1/Kconfig	2005-07-17 08:23:15.000000000 +0200
@@ -1,7 +1,5 @@
-menu "Dallas's 1-wire bus"
-
-config W1
-	tristate "Dallas's 1-wire support"
+menuconfig W1
+	tristate "Dallas's 1-wire bus support"
 	---help---
 	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
@@ -53,5 +51,3 @@ config W1_SMEM
 	help
 	  Say Y here if you want to connect 1-wire
 	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
-
-endmenu
diff -rNup a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/fs/Kconfig	2005-07-17 08:23:16.000000000 +0200
@@ -1736,12 +1736,8 @@ config RXRPC
 
 endmenu
 
-menu "Partition Types"
-
 source "fs/partitions/Kconfig"
 
-endmenu
-
 source "fs/nls/Kconfig"
 
 endmenu
diff -rNup a/fs/nls/Kconfig b/fs/nls/Kconfig
--- a/fs/nls/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/fs/nls/Kconfig	2005-07-17 08:23:16.000000000 +0200
@@ -2,10 +2,8 @@
 # Native language support configuration
 #
 
-menu "Native Language Support"
-
-config NLS
-	tristate "Base native language support"
+menuconfig NLS
+	tristate "Native language support"
 	---help---
 	  The base Native Language Support. A number of filesystems
 	  depend on it (e.g. FAT, JOLIET, NT, BEOS filesystems), as well
@@ -500,5 +498,3 @@ config NLS_UTF8
 	  input/output character sets. Say Y here for the UTF-8 encoding of
 	  the Unicode/ISO9646 universal character set.
 
-endmenu
-
diff -rNup a/fs/partitions/Kconfig b/fs/partitions/Kconfig
--- a/fs/partitions/Kconfig	2005-07-17 08:09:08.000000000 +0200
+++ b/fs/partitions/Kconfig	2005-07-17 09:52:14.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Partition configuration
 #
-config PARTITION_ADVANCED
+menuconfig PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
 	  Say Y here if you would like to use hard disks under Linux which
diff -rNup a/fs/xfs/Kconfig b/fs/xfs/Kconfig
--- a/fs/xfs/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/fs/xfs/Kconfig	2005-07-17 08:23:16.000000000 +0200
@@ -1,7 +1,5 @@
-menu "XFS support"
-
-config XFS_FS
-	tristate "XFS filesystem support"
+menuconfig XFS_FS
+	tristate "XFS support"
 	select EXPORTFS if NFSD!=n
 	help
 	  XFS is a high performance journaling filesystem which originated
@@ -20,13 +18,15 @@ config XFS_FS
 	  system of your root partition is compiled as a module, you'll need
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
 	  which contain a realtime subvolume. The realtime subvolume is a
@@ -43,7 +43,6 @@ config XFS_RT
 
 config XFS_QUOTA
 	bool "Quota support"
-	depends on XFS_FS
 	help
 	  If you say Y here, you will be able to set limits for disk usage on
 	  a per user and/or a per group basis under XFS.  XFS considers quota
@@ -60,7 +59,6 @@ config XFS_QUOTA
 
 config XFS_SECURITY
 	bool "Security Label support"
-	depends on XFS_FS
 	help
 	  Security labels support alternative access control models
 	  implemented by security modules like SELinux.  This option
@@ -72,7 +70,6 @@ config XFS_SECURITY
 
 config XFS_POSIX_ACL
 	bool "POSIX ACL support"
-	depends on XFS_FS
 	help
 	  POSIX Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -82,4 +79,4 @@ config XFS_POSIX_ACL
 
 	  If you don't know what Access Control Lists are, say N.
 
-endmenu
+endif
diff -rNup a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/init/Kconfig	2005-07-17 08:23:16.000000000 +0200
@@ -391,10 +391,8 @@ config BASE_SMALL
 	default 0 if BASE_FULL
 	default 1 if !BASE_FULL
 
-menu "Loadable module support"
-
-config MODULES
-	bool "Enable loadable module support"
+menuconfig MODULES
+	bool "Loadable module support"
 	help
 	  Kernel modules are small pieces of compiled code which can
 	  be inserted in the running kernel, rather than being
@@ -413,9 +411,10 @@ config MODULES
 
 	  If unsure, say Y.
 
+if MODULES
+
 config MODULE_UNLOAD
 	bool "Module unloading"
-	depends on MODULES
 	help
 	  Without this option you will not be able to unload any
 	  modules (note that some modules may not be unloadable
@@ -435,7 +434,6 @@ config MODULE_FORCE_UNLOAD
 config OBSOLETE_MODPARM
 	bool
 	default y
-	depends on MODULES
 	help
 	  You need this option to use module parameters on modules which
 	  have not been converted to the new module parameter system yet.
@@ -443,7 +441,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
@@ -454,7 +452,6 @@ config MODVERSIONS
 
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
-	depends on MODULES
 	help
 	  Modules which contain a MODULE_VERSION get an extra "srcversion"
 	  field inserted into their modinfo section, which contains a
@@ -466,7 +463,6 @@ config MODULE_SRCVERSION_ALL
 
 config KMOD
 	bool "Automatic kernel module loading"
-	depends on MODULES
 	help
 	  Normally when you have selected some parts of the kernel to
 	  be created as kernel modules, you must load them (using the
@@ -482,4 +478,5 @@ config STOP_MACHINE
 	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
 	help
 	  Need stop_machine() primitive.
-endmenu
+
+endif
diff -rNup a/sound/Kconfig b/sound/Kconfig
--- a/sound/Kconfig	2005-07-17 09:51:47.000000000 +0200
+++ b/sound/Kconfig	2005-07-17 09:57:53.000000000 +0200
@@ -1,9 +1,7 @@
 # sound/Config.in
 #
 
-menu "Sound"
-
-config SOUND
+menuconfig SOUND
 	tristate "Sound card support"
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
@@ -32,16 +30,14 @@ config SOUND
 	  Kernel patches and supporting utilities to do that are in the pcsp
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
-	depends on SOUND
 	help
 	  Say 'Y' or 'M' to enable ALSA (Advanced Linux Sound Architecture),
 	  the new base sound system.
@@ -74,21 +70,14 @@ source "sound/sparc/Kconfig"
 
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
+	depends on (BROKEN || (!SPARC32 && !SPARC64))
 	help
 	  Say 'Y' or 'M' to enable Open Sound System drivers.
 
 source "sound/oss/Kconfig"
 
-endmenu
-
 endif
 
-endmenu
+endif
diff -rNup a/sound/oss/Kconfig b/sound/oss/Kconfig
--- a/sound/oss/Kconfig	2005-07-17 08:10:20.000000000 +0200
+++ b/sound/oss/Kconfig	2005-07-17 09:52:14.000000000 +0200
@@ -1084,7 +1084,7 @@ config SOUND_TVMIXER
 
 config SOUND_KAHLUA
 	tristate "XpressAudio Sound Blaster emulation"
-	depends on SOUND_SB
+	depends on SOUND_SB && SOUND_PRIME
 
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"

-- 
Top 100 things you don't want the sysadmin to say:
8. ...and after I patched the microcode...
