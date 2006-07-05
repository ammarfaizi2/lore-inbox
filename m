Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWGESx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWGESx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWGESx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:53:28 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:27410 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S964981AbWGESx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:53:27 -0400
Date: Wed, 5 Jul 2006 14:52:25 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fix several typos in /drivers
Message-Id: <20060705145225.95cd8ff2.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Wed, 05 Jul 2006 14:52:29 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 05 Jul 2006 14:52:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to avoid the typo patch spam, here's a larger patch to cover many Kconfigs in /drivers.

This does not include any of the previously posted patches.

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

diff -ru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- a/drivers/firmware/Kconfig	2006-07-04 21:38:30.000000000 -0400
+++ b/drivers/firmware/Kconfig	2006-07-04 21:42:17.000000000 -0400
@@ -64,7 +64,7 @@
 	help
 	 Say m if you want to have the option of updating the BIOS for your
 	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
-	 supporting application to comunicate with the BIOS regarding the new
+	 supporting application to communicate with the BIOS regarding the new
 	 image for the image update to take effect.
 	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
 
diff -ru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2006-07-04 21:38:30.000000000 -0400
+++ b/drivers/i2c/busses/Kconfig	2006-07-04 21:47:50.000000000 -0400
@@ -323,10 +323,10 @@
 
 	  This driver is a light version of i2c-parport.  It doesn't depend
 	  on the parport driver, and uses direct I/O access instead.  This
-	  might be prefered on embedded systems where wasting memory for
+	  might be preferred on embedded systems where wasting memory for
 	  the clean but heavy parport handling is not an option.  The
 	  drawback is a reduced portability and the impossibility to
-	  dasiy-chain other parallel port devices.
+	  daisy-chain other parallel port devices.
 	  
 	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to
 	  both is possible but both modules should not be loaded at the same
diff -ru a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
--- a/drivers/ieee1394/Kconfig	2006-07-04 21:38:30.000000000 -0400
+++ b/drivers/ieee1394/Kconfig	2006-07-04 21:54:25.000000000 -0400
@@ -133,7 +133,7 @@
 	help
 	  This builds sbp2 for use with non-OHCI host adapters which do not
 	  support physical DMA or for when ohci1394 is run with phys_dma=0.
-	  Physical DMA is data movement without assistence of the drivers'
+	  Physical DMA is data movement without assistance of the drivers'
 	  interrupt handlers.  This option includes the interrupt handlers
 	  that are required in absence of this hardware feature.
 
diff -ru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/input/keyboard/Kconfig	2006-07-04 21:58:52.000000000 -0400
@@ -166,7 +166,7 @@
 	  However, it has been thoroughly tested and is stable.
 
 	  If you want full HIL support including support for multiple
-	  keyboards, mices and tablets, you have to enable the
+	  keyboards, mice, and tablets, you have to enable the
 	  "HP System Device Controller i8042 Support" in the input/serio
 	  submenu.
 
diff -ru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/input/serio/Kconfig	2006-07-04 22:21:43.000000000 -0400
@@ -115,9 +115,9 @@
 	depends on GSC && SERIO
 	default y
 	---help---
-	  This option enables supports for the the "System Device
+	  This option enables support for the "System Device
 	  Controller", an i8042 carrying microcode to manage a
-	  few miscellanous devices on some Hewlett Packard systems.
+	  few miscellaneous devices on some Hewlett Packard systems.
 	  The SDC itself contains a 10ms resolution timer/clock capable
 	  of delivering interrupts on a periodic and one-shot basis.
 	  The SDC may also be connected to a battery-backed real-time
diff -ru a/drivers/isdn/hardware/eicon/Kconfig b/drivers/isdn/hardware/eicon/Kconfig
--- a/drivers/isdn/hardware/eicon/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/isdn/hardware/eicon/Kconfig	2006-07-04 22:03:09.000000000 -0400
@@ -47,7 +47,7 @@
 	tristate "DIVA Maint driver support"
 	depends on ISDN_DIVAS && m
 	help
-	  Enable Divas Maintainance driver.
+	  Enable Divas Maintenance driver.
 
 endmenu
 
diff -ru a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
--- a/drivers/isdn/hisax/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/isdn/hisax/Kconfig	2006-07-04 22:04:55.000000000 -0400
@@ -321,7 +321,7 @@
 	help
 	  This enables HiSax support for the HFC-S PCI 2BDS0 based cards.
 
-	  For more informations see under
+	  For more information see under
 	  <file:Documentation/isdn/README.hfc-pci>.
 
 config HISAX_W6692
diff -ru a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
--- a/drivers/macintosh/Kconfig	2006-07-04 21:38:31.000000000 -0400
+++ b/drivers/macintosh/Kconfig	2006-07-04 22:07:34.000000000 -0400
@@ -176,7 +176,7 @@
 	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
 	help
 	  This driver provides some thermostat and fan control for the
-          iBook G4, and the ATI based aluminium PowerBooks, allowing slighlty
+          iBook G4, and the ATI based aluminium PowerBooks, allowing slightly
 	  better fan behaviour by default, and some manual control.
 
 config THERM_PM72
diff -ru a/drivers/media/dvb/cinergyT2/Kconfig b/drivers/media/dvb/cinergyT2/Kconfig
--- a/drivers/media/dvb/cinergyT2/Kconfig	2006-07-04 21:38:31.000000000 -0400
+++ b/drivers/media/dvb/cinergyT2/Kconfig	2006-07-04 22:11:12.000000000 -0400
@@ -56,7 +56,7 @@
 	  measurements.
 
 	  Please keep in mind that these updates cause traffic on the tuner
-	  control bus and thus may or may not affect receiption sensitivity.
+	  control bus and thus may or may not affect reception sensitivity.
 
 	  The default value should be a safe choice for common applications.
 
diff -ru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig	2006-07-04 21:38:31.000000000 -0400
+++ b/drivers/media/video/Kconfig	2006-07-04 22:16:52.000000000 -0400
@@ -37,7 +37,7 @@
 	help
 	  Support for  Radio Data System (RDS) decoder. This allows seeing
 	  radio station identification transmitted using this standard.
-	  Currentlly, it works only with bt8x8 chips.
+	  Currently, it works only with bt8x8 chips.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa6588.
diff -ru a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
--- a/drivers/mtd/chips/Kconfig	2006-07-04 21:38:32.000000000 -0400
+++ b/drivers/mtd/chips/Kconfig	2006-07-05 00:43:34.000000000 -0400
@@ -270,7 +270,7 @@
 	tristate "JEDEC device support"
 	depends on MTD && MTD_OBSOLETE_CHIPS && BROKEN
 	help
-	  Enable older older JEDEC flash interface devices for self
+	  Enable older JEDEC flash interface devices for self
 	  programming flash.  It is commonly used in older AMD chips.  It is
 	  only called JEDEC because the JEDEC association
 	  <http://www.jedec.org/> distributes the identification codes for the
diff -ru a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
--- a/drivers/mtd/nand/Kconfig	2006-07-04 21:38:32.000000000 -0400
+++ b/drivers/mtd/nand/Kconfig	2006-07-05 00:48:47.000000000 -0400
@@ -21,7 +21,7 @@
 	  NAND flash device internally checks only bits transitioning
 	  from 1 to 0. There is a rare possibility that even though the
 	  device thinks the write was successful, a bit could have been
-	  flipped accidentaly due to device wear or something else.
+	  flipped accidentally due to device wear or something else.
 
 config MTD_NAND_ECC_SMC
 	bool "NAND ECC Smart Media byte order"
diff -ru a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
--- a/drivers/mtd/onenand/Kconfig	2006-07-04 21:38:32.000000000 -0400
+++ b/drivers/mtd/onenand/Kconfig	2006-07-05 00:49:14.000000000 -0400
@@ -21,7 +21,7 @@
 	  OneNAND flash device internally checks only bits transitioning
 	  from 1 to 0. There is a rare possibility that even though the
 	  device thinks the write was successful, a bit could have been
-	  flipped accidentaly due to device wear or something else.
+	  flipped accidentally due to device wear or something else.
 
 config MTD_ONENAND_GENERIC
 	tristate "OneNAND Flash device via platform device driver"
diff -ru a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig	2006-07-04 21:38:40.000000000 -0400
+++ b/drivers/net/wireless/Kconfig	2006-07-05 00:59:12.000000000 -0400
@@ -312,7 +312,7 @@
 	tristate "Hermes chipset 802.11b support (Orinoco/Prism2/Symbol)"
 	depends on NET_RADIO && (PPC_PMAC || PCI || PCMCIA)
 	---help---
-	  A driver for 802.11b wireless cards based based on the "Hermes" or
+	  A driver for 802.11b wireless cards based on the "Hermes" or
 	  Intersil HFA384x (Prism 2) MAC controller.  This includes the vast
 	  majority of the PCMCIA 802.11b cards (which are nearly all rebadges)
 	  - except for the Cisco/Aironet cards.  Cards supported include the
diff -ru a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
--- a/drivers/rapidio/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/rapidio/Kconfig	2006-07-05 13:56:15.000000000 -0400
@@ -15,4 +15,4 @@
 	default "30"
 	---help---
 	  Amount of time a discovery node waits for a host to complete
-	  enumeration beforing giving up.
+	  enumeration before giving up.
diff -ru a/drivers/scsi/aic7xxx/Kconfig.aic79xx b/drivers/scsi/aic7xxx/Kconfig.aic79xx
--- a/drivers/scsi/aic7xxx/Kconfig.aic79xx	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/scsi/aic7xxx/Kconfig.aic79xx	2006-07-05 14:00:10.000000000 -0400
@@ -22,12 +22,12 @@
 	to be used for any device.  The aic7xxx driver will automatically
 	vary this number based on device behavior.  For devices with a
 	fixed maximum, the driver will eventually lock to this maximum
-	and display a console message inidicating this value.
+	and display a console message indicating this value.
 
 	Due to resource allocation issues in the Linux SCSI mid-layer, using
 	a high number of commands per device may result in memory allocation
 	failures when many devices are attached to the system.  For this reason,
-	the default is set to 32.  Higher values may result in higer performance
+	the default is set to 32.  Higher values may result in higher performance
 	on some devices.  The upper bound is 253.  0 disables tagged queueing.
 
 	Per device tag depth can be controlled via the kernel command line
diff -ru a/drivers/scsi/aic7xxx/Kconfig.aic7xxx b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
--- a/drivers/scsi/aic7xxx/Kconfig.aic7xxx	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/scsi/aic7xxx/Kconfig.aic7xxx	2006-07-05 14:00:40.000000000 -0400
@@ -27,12 +27,12 @@
 	to be used for any device.  The aic7xxx driver will automatically
 	vary this number based on device behavior.  For devices with a
 	fixed maximum, the driver will eventually lock to this maximum
-	and display a console message inidicating this value.
+	and display a console message indicating this value.
 
 	Due to resource allocation issues in the Linux SCSI mid-layer, using
 	a high number of commands per device may result in memory allocation
 	failures when many devices are attached to the system.  For this reason,
-	the default is set to 32.  Higher values may result in higer performance
+	the default is set to 32.  Higher values may result in higher performance
 	on some devices.  The upper bound is 253.  0 disables tagged queueing.
 
 	Per device tag depth can be controlled via the kernel command line
diff -ru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2006-07-04 21:38:40.000000000 -0400
+++ b/drivers/scsi/Kconfig	2006-07-05 14:05:30.000000000 -0400
@@ -33,10 +33,10 @@
 	default y
 	---help---
 	  This option enables support for the various files in
-	  /proc/scsi.  In Linux 2.6 this has been superceeded by
+	  /proc/scsi.  In Linux 2.6 this has been superseded by
 	  files in sysfs but many legacy applications rely on this.
 
-	  If unusure say Y.
+	  If unsure say Y.
 
 comment "SCSI support type (disk, tape, CD-ROM)"
 	depends on SCSI
diff -ru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	2006-07-04 21:38:44.000000000 -0400
+++ b/drivers/serial/Kconfig	2006-07-05 14:08:49.000000000 -0400
@@ -121,7 +121,7 @@
 	default "4"
 	help
 	  Set this to the maximum number of serial ports you want
-	  the kernel to register at boot time.  This can be overriden
+	  the kernel to register at boot time.  This can be overridden
 	  with the module parameter "nr_uarts", or boot-time parameter
 	  8250.nr_uarts
 
@@ -205,7 +205,7 @@
 	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
 	help
 	  Say Y here if you have a Boca serial board.  Please read the Boca
-	  mini-HOWTO, avaialble from <http://www.tldp.org/docs.html#howto>
+	  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_boca.
@@ -662,7 +662,7 @@
 	depends on M68328 || M68EZ328 || M68VZ328
 	help
 	  This driver supports the built-in serial port of the Motorola 68328
-	  (standard, EZ and VZ varities).
+	  (standard, EZ and VZ varieties).
 
 config SERIAL_68328_RTS_CTS
 	bool "Support RTS/CTS on 68328 serial port"
diff -ru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/usb/gadget/Kconfig	2006-07-05 14:10:49.000000000 -0400
@@ -26,7 +26,7 @@
 	   you need a low level bus controller driver, and some software
 	   talking to it.  Peripheral controllers are often discrete silicon,
 	   or are integrated with the CPU in a microcontroller.  The more
-	   familiar host side controllers have names like like "EHCI", "OHCI",
+	   familiar host side controllers have names like "EHCI", "OHCI",
 	   or "UHCI", and are usually integrated into southbridges on PC
 	   motherboards.
 
diff -ru a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
--- a/drivers/usb/storage/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/usb/storage/Kconfig	2006-07-05 14:15:19.000000000 -0400
@@ -120,7 +120,7 @@
 	  Say Y here to include additional code to support the Olympus MAUSB-10
 	  and Fujifilm DPC-R1 USB Card reader/writer devices.
 
-	  These devices are based on the Alauda chip and support support both
+	  These devices are based on the Alauda chip and support both
 	  XD and SmartMedia cards.
 
 config USB_STORAGE_ONETOUCH
diff -ru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2006-07-04 21:38:44.000000000 -0400
+++ b/drivers/video/Kconfig	2006-07-05 14:20:36.000000000 -0400
@@ -396,7 +396,7 @@
 	  is based on the KS-108 lcd controller and is typically a matrix
 	  of 2*n chips. This driver was tested with a 128x64 panel. This
 	  driver supports it for use with x86 SBCs through a 16 bit GPIO
-	  interface (8 bit data, 8 bit control). If you anticpate using
+	  interface (8 bit data, 8 bit control). If you anticipate using
 	  this driver, say Y or M; otherwise say N. You must specify the
 	  GPIO IO address to be used for setting control and data.
 
@@ -764,7 +764,7 @@
 	default n
 	help
 	  Say Y here if you want the Riva driver to output all sorts
-	  of debugging informations to provide to the maintainer when
+	  of debugging information to provide to the maintainer when
 	  something goes wrong.
 
 config FB_RIVA_BACKLIGHT
@@ -848,7 +848,7 @@
 	depends on FB_INTEL
 	---help---
 	  Say Y here if you want the Intel driver to output all sorts
-	  of debugging informations to provide to the maintainer when
+	  of debugging information to provide to the maintainer when
 	  something goes wrong.
 
 config FB_MATROX
@@ -1039,7 +1039,7 @@
 	default n
 	help
 	  Say Y here if you want the Radeon driver to output all sorts
-	  of debugging informations to provide to the maintainer when
+	  of debugging information to provide to the maintainer when
 	  something goes wrong.
 
 config FB_ATY128
diff -ru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2006-07-04 21:38:45.000000000 -0400
+++ b/drivers/w1/Kconfig	2006-07-05 14:21:20.000000000 -0400
@@ -21,7 +21,7 @@
 	  There are three types of messages between w1 core and userspace:
 	  1. Events. They are generated each time new master or slave device found
 		either due to automatic or requested search.
-	  2. Userspace commands. Includes read/write and search/alarm search comamnds.
+	  2. Userspace commands. Includes read/write and search/alarm search commands.
 	  3. Replies to userspace commands.
 
 source drivers/w1/masters/Kconfig

