Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVBQE4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVBQE4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVBQE4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:56:04 -0500
Received: from mail.renesas.com ([202.234.163.13]:53412 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262212AbVBQExl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:53:41 -0500
Date: Thu, 17 Feb 2005 13:53:34 +0900 (JST)
Message-Id: <20050217.135334.782297373.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.11-rc4] m32r: defconfig updates
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patchset to update defconfig files for m32r.
The m32r kernel's API/ABI has been changed since 2.6.11-rc1.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/defconfig                       |   44 ++++++++++++++++++++----
 arch/m32r/m32700ut/defconfig.m32700ut.smp |   44 ++++++++++++++++++++----
 arch/m32r/m32700ut/defconfig.m32700ut.up  |   44 ++++++++++++++++++++----
 arch/m32r/mappi/defconfig.nommu           |   45 +++++++++++++++++++------
 arch/m32r/mappi/defconfig.smp             |   44 ++++++++++++++++++++----
 arch/m32r/mappi/defconfig.up              |   44 ++++++++++++++++++++----
 arch/m32r/mappi2/defconfig.vdec2          |   43 +++++++++++++++++++----
 arch/m32r/oaks32r/defconfig.nommu         |   44 +++++++++++++++++++-----
 arch/m32r/opsput/defconfig.opsput         |   54 +++++++++++++++++++++++-------
 9 files changed, 329 insertions(+), 77 deletions(-)


diff -ruNp a/arch/m32r/defconfig b/arch/m32r/defconfig
--- a/arch/m32r/defconfig	2004-12-25 06:35:00.000000000 +0900
+++ b/arch/m32r/defconfig	2005-02-16 21:10:44.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:49 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:10:44 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -81,6 +83,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -96,7 +99,6 @@ CONFIG_PREEMPT=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -146,10 +148,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -162,6 +166,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -219,12 +224,12 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -396,6 +401,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -450,7 +456,6 @@ CONFIG_DS1302=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -524,6 +529,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -537,11 +543,25 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -558,6 +578,10 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -628,7 +652,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -697,7 +720,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -712,6 +736,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.smp b/arch/m32r/m32700ut/defconfig.m32700ut.smp
--- a/arch/m32r/m32700ut/defconfig.m32700ut.smp	2004-12-25 06:34:58.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.smp	2005-02-16 21:10:50.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:45 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:10:50 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -81,6 +83,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 CONFIG_SMP=y
@@ -99,7 +102,6 @@ CONFIG_NR_CPUS=2
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -149,10 +151,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -165,6 +169,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -222,12 +227,12 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -399,6 +404,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -453,7 +459,6 @@ CONFIG_DS1302=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -527,6 +532,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -540,11 +546,25 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -561,6 +581,10 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -631,7 +655,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -700,7 +723,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -715,6 +739,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.up b/arch/m32r/m32700ut/defconfig.m32700ut.up
--- a/arch/m32r/m32700ut/defconfig.m32700ut.up	2004-12-25 06:35:01.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.up	2005-02-16 21:10:54.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:49 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:10:54 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -81,6 +83,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -96,7 +99,6 @@ CONFIG_PREEMPT=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -146,10 +148,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -162,6 +166,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -219,12 +224,12 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -396,6 +401,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -450,7 +456,6 @@ CONFIG_DS1302=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -524,6 +529,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -537,11 +543,25 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -558,6 +578,10 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -628,7 +652,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -697,7 +720,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -712,6 +736,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/mappi/defconfig.nommu b/arch/m32r/mappi/defconfig.nommu
--- a/arch/m32r/mappi/defconfig.nommu	2004-12-25 06:35:40.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.nommu	2005-02-16 21:10:57.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:51 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:10:57 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -34,12 +36,11 @@ CONFIG_EMBEDDED=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
-# CONFIG_TINY_SHMEM is not set
+CONFIG_TINY_SHMEM=y
 
 #
 # Loadable module support
@@ -79,6 +80,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -94,7 +96,6 @@ CONFIG_PREEMPT=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -144,10 +145,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -160,6 +163,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -329,6 +333,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -380,7 +385,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -430,11 +434,25 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -443,6 +461,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -468,7 +490,6 @@ CONFIG_DNOTIFY=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
 CONFIG_DEVFS_FS=y
 CONFIG_DEVFS_MOUNT=y
@@ -507,7 +528,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -576,7 +596,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -591,6 +612,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/mappi/defconfig.smp b/arch/m32r/mappi/defconfig.smp
--- a/arch/m32r/mappi/defconfig.smp	2004-12-25 06:35:00.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.smp	2005-02-16 21:11:02.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:53 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:11:02 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -84,6 +86,7 @@ CONFIG_IRAM_START=0x00f00000
 CONFIG_IRAM_SIZE=0x00080000
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 CONFIG_SMP=y
@@ -102,7 +105,6 @@ CONFIG_NR_CPUS=2
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -140,6 +142,7 @@ CONFIG_MTD=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
 # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
 # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
@@ -185,6 +188,7 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
 
 #
 # Disk-On-Chip Device Drivers
@@ -211,10 +215,12 @@ CONFIG_MTD_CFI_I2=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -227,6 +233,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -421,6 +428,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -472,7 +480,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -522,11 +529,25 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -535,6 +556,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
@@ -593,6 +618,7 @@ CONFIG_JFFS_PROC_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
@@ -615,7 +641,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -684,7 +709,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -699,6 +725,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/mappi/defconfig.up b/arch/m32r/mappi/defconfig.up
--- a/arch/m32r/mappi/defconfig.up	2004-12-25 06:34:31.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.up	2005-02-16 21:11:07.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:55 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:11:07 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -83,6 +85,7 @@ CONFIG_IRAM_START=0x00f00000
 CONFIG_IRAM_SIZE=0x00080000
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -98,7 +101,6 @@ CONFIG_PREEMPT=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -136,6 +138,7 @@ CONFIG_MTD=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
 # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
 # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
@@ -181,6 +184,7 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
 
 #
 # Disk-On-Chip Device Drivers
@@ -207,10 +211,12 @@ CONFIG_MTD_CFI_I2=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -223,6 +229,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -417,6 +424,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -468,7 +476,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -518,11 +525,25 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -531,6 +552,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
@@ -589,6 +614,7 @@ CONFIG_JFFS_PROC_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
@@ -611,7 +637,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -680,7 +705,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -695,6 +721,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/mappi2/defconfig.vdec2 b/arch/m32r/mappi2/defconfig.vdec2
--- a/arch/m32r/mappi2/defconfig.vdec2	2004-12-25 06:35:40.000000000 +0900
+++ b/arch/m32r/mappi2/defconfig.vdec2	2005-02-16 21:11:10.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:08:58 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:11:10 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -79,6 +81,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -94,7 +97,6 @@ CONFIG_PREEMPT=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -142,10 +144,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -158,6 +162,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -215,12 +220,12 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -392,6 +397,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -445,7 +451,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -516,11 +521,25 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -537,6 +556,10 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -607,7 +630,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -676,7 +698,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -691,6 +714,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/oaks32r/defconfig.nommu b/arch/m32r/oaks32r/defconfig.nommu
--- a/arch/m32r/oaks32r/defconfig.nommu	2004-12-25 06:33:48.000000000 +0900
+++ b/arch/m32r/oaks32r/defconfig.nommu	2005-02-16 21:11:13.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:09:00 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:11:13 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -33,12 +35,11 @@ CONFIG_EMBEDDED=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
-# CONFIG_TINY_SHMEM is not set
+CONFIG_TINY_SHMEM=y
 
 #
 # Loadable module support
@@ -74,6 +75,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PREEMPT=y
 # CONFIG_HAVE_DEC_LOCK is not set
 # CONFIG_SMP is not set
@@ -134,10 +136,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -150,6 +154,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -314,6 +319,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -365,7 +371,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
@@ -410,11 +415,25 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -423,6 +442,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -448,7 +471,6 @@ CONFIG_DNOTIFY=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
 CONFIG_DEVPTS_FS_XATTR=y
@@ -485,7 +507,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -554,7 +575,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
 #
@@ -569,6 +591,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -ruNp a/arch/m32r/opsput/defconfig.opsput b/arch/m32r/opsput/defconfig.opsput
--- a/arch/m32r/opsput/defconfig.opsput	2004-12-25 06:34:29.000000000 +0900
+++ b/arch/m32r/opsput/defconfig.opsput	2005-02-16 21:11:41.000000000 +0900
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-bk21
-# Fri Nov 12 16:09:02 2004
+# Linux kernel version: 2.6.11-rc4
+# Wed Feb 16 21:11:41 2005
 #
 CONFIG_M32R=y
-CONFIG_UID16=y
+# CONFIG_UID16 is not set
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 
 #
 # Code maturity level options
@@ -80,6 +82,7 @@ CONFIG_NOHIGHMEM=y
 # CONFIG_DISCONTIGMEM is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 # CONFIG_PREEMPT is not set
 # CONFIG_SMP is not set
 
@@ -94,7 +97,6 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 #
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-# CONFIG_PCMCIA_OBSOLETE is not set
 CONFIG_PCMCIA=y
 
 #
@@ -144,10 +146,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -160,6 +164,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -194,12 +199,12 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -371,6 +376,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -423,7 +429,6 @@ CONFIG_DS1302=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_AGP is not set
 # CONFIG_DRM is not set
 
 #
@@ -473,11 +478,25 @@ CONFIG_DS1302=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -494,6 +513,10 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -564,7 +587,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -633,15 +655,19 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_STACKOVERFLOW is not set
-# CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_IOVIRT is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
-CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
 # CONFIG_FRAME_POINTER is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
 
 #
 # Security options
@@ -655,6 +681,10 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
