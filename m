Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVCBV1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVCBV1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCBV1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:27:08 -0500
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:40108 "EHLO
	falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
	id S262463AbVCBV0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:26:20 -0500
Date: Wed, 2 Mar 2005 13:26:18 -0800 (PST)
From: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
To: linux-kernel@vger.kernel.org
Subject: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Message-ID: <Pine.GSO.4.44.0503021324200.25652-100000@hornet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No obvous reason. Works fine with kernel 2.6.10

Result of lspci:
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control
Registers (rev 02)
00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration
Process Registers (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02)
00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics
Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
(rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97
Audio Controller (rev 01)
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
02:02.0 Network controller: Broadcom Corporation: Unknown device 4324 (rev
03)
02:04.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus
Controller



Diff of .config between 2.6.10 & 2.6.11

--- linux-2.6.10/.config        2005-02-19 18:33:49.000000000 -0800
+++ linux-2.6.11/.config        2005-03-02 12:11:54.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10
-# Sat Feb 19 17:34:02 2005
+# Linux kernel version: 2.6.11
+# Wed Mar  2 12:11:54 2005
 #
 CONFIG_X86=y
 CONFIG_MMU=y
@@ -92,6 +92,7 @@
 CONFIG_X86_XADD=y
 CONFIG_X86_L1_CACHE_SHIFT=7
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_X86_WP_WORKS_OK=y
 CONFIG_X86_INVLPG=y
 CONFIG_X86_BSWAP=y
@@ -102,6 +103,7 @@
 # CONFIG_HPET_TIMER is not set
 # CONFIG_SMP is not set
 CONFIG_PREEMPT=y
+CONFIG_PREEMPT_BKL=y
 # CONFIG_X86_UP_APIC is not set
 CONFIG_X86_TSC=y
 CONFIG_X86_MCE=y
@@ -158,6 +160,7 @@
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
 CONFIG_X86_PM_TIMER=y
+# CONFIG_ACPI_CONTAINER is not set

 #
 # APM (Advanced Power Management) BIOS Support
@@ -176,7 +179,8 @@
 #
 CONFIG_CPU_FREQ=y
 # CONFIG_CPU_FREQ_DEBUG is not set
-# CONFIG_CPU_FREQ_PROC_INTF is not set
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
@@ -216,6 +220,7 @@
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_MMCONFIG=y
+# CONFIG_PCIEPORTBUS is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 # CONFIG_ISA is not set
@@ -227,7 +232,6 @@
 #
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_DEBUG=y
-CONFIG_PCMCIA_OBSOLETE=y
 CONFIG_PCMCIA=y
 CONFIG_CARDBUS=y

@@ -238,6 +242,7 @@
 CONFIG_PD6729=y
 CONFIG_I82092=y
 CONFIG_TCIC=y
+CONFIG_PCCARD_NONSTATIC=y

 #
 # PCI Hotplug Support
@@ -291,6 +296,7 @@
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -313,6 +319,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set

 #
 # ATA/ATAPI/MFM/RLL support
@@ -406,6 +413,7 @@
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set

 #
 # SCSI low-level drivers
@@ -426,6 +434,7 @@
 CONFIG_SCSI_ATA_PIIX=y
 # CONFIG_SCSI_SATA_NV is not set
 # CONFIG_SCSI_SATA_PROMISE is not set
+# CONFIG_SCSI_SATA_QSTOR is not set
 CONFIG_SCSI_SATA_SX4=m
 # CONFIG_SCSI_SATA_SIL is not set
 CONFIG_SCSI_SATA_SIS=m
@@ -454,7 +463,6 @@
 # CONFIG_SCSI_QLA2300 is not set
 # CONFIG_SCSI_QLA2322 is not set
 # CONFIG_SCSI_QLA6312 is not set
-# CONFIG_SCSI_QLA6322 is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
@@ -579,7 +587,6 @@
 CONFIG_IP_NF_TARGET_REDIRECT=y
 CONFIG_IP_NF_TARGET_NETMAP=y
 CONFIG_IP_NF_TARGET_SAME=y
-# CONFIG_IP_NF_NAT_LOCAL is not set
 # CONFIG_IP_NF_NAT_SNMP_BASIC is not set
 CONFIG_IP_NF_MANGLE=y
 CONFIG_IP_NF_TARGET_TOS=y
@@ -798,6 +805,7 @@
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
 CONFIG_SERIO_PCIPS2=y
+CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set

 #
@@ -968,6 +976,7 @@
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
 # Sound
@@ -986,7 +995,7 @@
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 CONFIG_SND_SEQUENCER_OSS=y
-# CONFIG_SND_RTCTIMER is not set
+CONFIG_SND_RTCTIMER=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set

@@ -1014,6 +1023,8 @@
 # CONFIG_SND_CS46XX is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_CA0106 is not set
 # CONFIG_SND_KORG1212 is not set
 # CONFIG_SND_MIXART is not set
 # CONFIG_SND_NM256 is not set
@@ -1037,6 +1048,7 @@
 # CONFIG_SND_INTEL8X0M is not set
 # CONFIG_SND_SONICVIBES is not set
 # CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
 # CONFIG_SND_VX222 is not set

 #
@@ -1129,7 +1141,6 @@
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-# CONFIG_USB_HPUSBSCSI is not set

 #
 # USB Multimedia devices
@@ -1163,7 +1174,6 @@
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
-# CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1172,6 +1182,7 @@
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_TEST is not set

 #
@@ -1189,6 +1200,11 @@
 # CONFIG_MMC is not set

 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1202,6 +1218,10 @@
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 CONFIG_MINIX_FS=y
 # CONFIG_ROMFS_FS is not set
@@ -1223,7 +1243,7 @@
 # DOS/FAT/NT Filesystems
 #
 CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
+# CONFIG_MSDOS_FS is not set
 CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
@@ -1267,7 +1287,6 @@
 #
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-# CONFIG_EXPORTFS is not set
 CONFIG_SMB_FS=y
 # CONFIG_SMB_NLS_DEFAULT is not set
 CONFIG_CIFS=y
@@ -1338,6 +1357,8 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_FRAME_POINTER is not set
 CONFIG_EARLY_PRINTK=y
 # CONFIG_4KSTACKS is not set
@@ -1354,6 +1375,10 @@
 # CONFIG_CRYPTO is not set

 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m


