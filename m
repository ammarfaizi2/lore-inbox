Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTA1WDT>; Tue, 28 Jan 2003 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTA1WDT>; Tue, 28 Jan 2003 17:03:19 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:3996 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261426AbTA1WDP>; Tue, 28 Jan 2003 17:03:15 -0500
Subject: [PATCH] 2.5.59 add six help texts to drivers/ide/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: trivial@rustcorp.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jan 2003 15:10:05 -0700
Message-Id: <1043791805.14310.145.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some help texts from 2.4.21-pre3 Configure.help which are
needed in 2.5.59 drivers/ide/Kconfig.

Steven

--- linux-2.5.59/drivers/ide/Kconfig.orig	Tue Jan 28 14:45:25 2003
+++ linux-2.5.59/drivers/ide/Kconfig	Tue Jan 28 14:50:41 2003
@@ -193,6 +193,13 @@
 config IDE_TASK_IOCTL
 	bool "IDE Taskfile Access"
 	depends on BLK_DEV_IDE
+	help
+	  This is a direct raw access to the media.  It is a complex but
+	  elegant solution to test and validate the domain of the hardware and
+	  perform below the driver data recover if needed.  This is the most
+	  basic form of media-forensics.
+
+	  If you are unsure, say N here.
 
 #bool '  IDE Taskfile IO' CONFIG_IDE_TASKFILE_IO
 comment "IDE chipset support/bugfixes"
@@ -245,6 +252,10 @@
 	bool "PCI IDE chipset support" if PCI
 	depends on BLK_DEV_IDE
 	default BLK_DEV_IDEDMA_PMAC if ALL_PPC && BLK_DEV_IDEDMA_PMAC
+	help
+	  Say Y here for PCI systems which use IDE drive(s).
+	  This option helps the IDE driver to automatically detect and
+	  configure all PCI-based IDE interfaces in your system.
 
 config BLK_DEV_GENERIC
 	bool "Generic PCI IDE Chipset Support"
@@ -347,6 +358,10 @@
 config BLK_DEV_IDEDMA_FORCED
 	bool "Force enable legacy 2.0.X HOSTS to use DMA"
 	depends on BLK_DEV_IDEDMA_PCI
+	help
+	  This is an old piece of lost code from Linux 2.0 Kernels.
+
+	  Generally say N here.
 
 config IDEDMA_PCI_AUTO
 	bool "Use PCI DMA by default when available"
@@ -383,6 +398,12 @@
 config IDEDMA_PCI_WIP
 	bool "ATA Work(s) In Progress (EXPERIMENTAL)"
 	depends on BLK_DEV_IDEDMA_PCI && EXPERIMENTAL
+	help
+	  If you enable this you will be able to use and test highly
+	  developmental projects. If you say N, the configurator will
+	  simply skip those options.
+
+	  It is SAFEST to say N to this question.
 
 config IDEDMA_NEW_DRIVE_LISTINGS
 	bool "Good-Bad DMA Model-Firmware (WIP)"
@@ -656,6 +677,18 @@
 config BLK_DEV_SLC90E66
 	tristate "SLC90E66 chipset support"
 	depends on BLK_DEV_IDEDMA_PCI
+	help
+	  This driver ensures (U)DMA support for Victroy66 SouthBridges for
+	  SMsC with Intel NorthBridges.  This is an Ultra66 based chipset.
+	  The nice thing about it is that you can mix Ultra/DMA/PIO devices
+	  and it will handle timing cycles.  Since this is an improved
+	  look-a-like to the PIIX4 it should be a nice addition.
+
+	  If you say Y here, you need to say Y to "Use DMA by default when
+	  available" as well.
+
+	  Please read the comments at the top of
+	  drivers/ide/slc90e66.c.
 
 config BLK_DEV_TRM290
 	tristate "Tekram TRM290 chipset support"
@@ -880,6 +913,12 @@
 config BLK_DEV_4DRIVES
 	bool "Generic 4 drives/port support"
 	depends on IDE_CHIPSETS
+	help
+	  Certain older chipsets, including the Tekram 690CD, use a single set
+	  of I/O ports at 0x1f0 to control up to four drives, instead of the
+	  customary two drives per port. Support for this can be enabled at
+	  runtime using the "ide0=four" kernel boot parameter if you say Y
+	  here.
 
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"




