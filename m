Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFLW37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFLW37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 18:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFLW37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 18:29:59 -0400
Received: from femail.waymark.net ([206.176.148.84]:48867 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261243AbVFLW3s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 18:29:48 -0400
Date: 12 Jun 2005 22:20:26 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: [2.6 patch] fix arch/i386/defconfig nonexistent symbols
To: linux-kernel@vger.kernel.org
Message-ID: <603f62.cc8a8d@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'make menuconfig' warns on these arch/i386/defconfig entries,

#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:129: trying to assign nonexistent symbol PM_DISK
arch/i386/defconfig:176: trying to assign nonexistent symbol PCI_USE_VECTOR
arch/i386/defconfig:221: trying to assign nonexistent symbol PARPORT_PC_CML1
arch/i386/defconfig:225: trying to assign nonexistent symbol PARPORT_OTHER
arch/i386/defconfig:252: trying to assign nonexistent symbol BLK_DEV_CARMEL
arch/i386/defconfig:273: trying to assign nonexistent symbol IDE_TASKFILE_IO
arch/i386/defconfig:292: trying to assign nonexistent symbol BLK_DEV_ADMA
arch/i386/defconfig:365: trying to assign nonexistent symbol SCSI_MEGARAID
arch/i386/defconfig:406: trying to assign nonexistent symbol SCSI_QLA6322
arch/i386/defconfig:477: trying to assign nonexistent symbol NETLINK_DEV
arch/i386/defconfig:569: trying to assign nonexistent symbol NET_FASTROUTE
arch/i386/defconfig:570: trying to assign nonexistent symbol NET_HW_FLOWCONTROL
arch/i386/defconfig:720: trying to assign nonexistent symbol SOUND_GAMEPORT
arch/i386/defconfig:776: trying to assign nonexistent symbol QIC02_TAPE
arch/i386/defconfig:998: trying to assign nonexistent symbol
USB_STORAGE_HP8200e
arch/i386/defconfig:1024: trying to assign nonexistent symbol USB_HPUSBSCSI
arch/i386/defconfig:1059: trying to assign nonexistent symbol USB_TIGL
arch/i386/defconfig:1246: trying to assign nonexistent symbol X86_STD_RESOURCES

-+-

Signed-off-by: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>

--- linux-2.6.12-rc6/arch/i386/defconfig.orig   2005-06-12 16:39:27.000000000
-0500
+++ linux-2.6.12-rc6/arch/i386/defconfig        2005-06-12 16:50:57.000000000 -
@@ -126,7 +126,6 @@
 #
 CONFIG_PM=y
 CONFIG_SOFTWARE_SUSPEND=y
-# CONFIG_PM_DISK is not set

 #
 # ACPI (Advanced Configuration and Power Interface) Support
@@ -173,7 +172,6 @@
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_MMCONFIG=y
-# CONFIG_PCI_USE_VECTOR is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
@@ -218,11 +216,9 @@
 #
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
-CONFIG_PARPORT_PC_CML1=y
 # CONFIG_PARPORT_SERIAL is not set
 # CONFIG_PARPORT_PC_FIFO is not set
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_OTHER is not set
 # CONFIG_PARPORT_1284 is not set

 #
@@ -249,7 +245,6 @@
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_CARMEL is not set
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_LBD=y

@@ -270,7 +265,6 @@
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-CONFIG_IDE_TASKFILE_IO=y

 #
 # IDE chipset support/bugfixes
@@ -289,7 +283,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
@@ -362,7 +355,6 @@
 CONFIG_SCSI_DPT_I2O=m
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_MEGARAID is not set
 CONFIG_SCSI_SATA=y
 # CONFIG_SCSI_SATA_SVW is not set
 CONFIG_SCSI_ATA_PIIX=y
@@ -403,7 +395,6 @@
 # CONFIG_SCSI_QLA2300 is not set
 # CONFIG_SCSI_QLA2322 is not set
 # CONFIG_SCSI_QLA6312 is not set
-# CONFIG_SCSI_QLA6322 is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -474,7 +465,6 @@
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -566,8 +556,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_FASTROUTE is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set

 #
 # QoS and/or fair queueing
@@ -717,7 +705,6 @@
 # Input I/O drivers
 #
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_I8042=y
 # CONFIG_SERIO_SERPORT is not set
@@ -773,7 +760,6 @@
 # CONFIG_LP_CONSOLE is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
-# CONFIG_QIC02_TAPE is not set

 #
 # IPMI
@@ -995,7 +981,6 @@
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_HP8200e is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
@@ -1021,7 +1006,6 @@
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-# CONFIG_USB_HPUSBSCSI is not set

 #
 # USB Multimedia devices
@@ -1056,7 +1040,6 @@
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
-# CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1243,5 +1226,4 @@
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
 CONFIG_X86_TRAMPOLINE=y
-CONFIG_X86_STD_RESOURCES=y
 CONFIG_PC=y

... The first kindergarten appeared in Blankenberg, Germany in 1837.
--- MultiMail/Linux v0.46
