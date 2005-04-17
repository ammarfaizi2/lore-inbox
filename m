Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVDQJJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVDQJJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDQJJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 05:09:31 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:49755 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261293AbVDQJEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 05:04:45 -0400
Date: Sun, 17 Apr 2005 11:04:37 +0200
Message-Id: <200504170904.j3H94b6m021029@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 548] M68k: Update defconfigs for 2.6.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfigs for 2.6.11

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.11/arch/m68k/configs/amiga_defconfig	2005-04-17 10:44:01.982181521 +0200
+++ linux-m68k-2.6.11/arch/m68k/configs/amiga_defconfig	2005-04-17 10:39:47.988326441 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:22:54 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:00 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -104,6 +105,7 @@ CONFIG_ZORRO_NAMES=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -133,6 +135,7 @@ CONFIG_AMIGA_FLOPPY=y
 CONFIG_AMIGA_Z2RAM=y
 # CONFIG_BLK_DEV_XD is not set
 # CONFIG_PARIDE is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -152,6 +155,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -212,6 +216,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -396,8 +401,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -709,6 +712,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -738,6 +742,11 @@ CONFIG_DMASOUND=m
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_AMIGA_BUILTIN_SERIAL=y
@@ -760,10 +769,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -923,8 +938,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -961,6 +977,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/apollo_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/apollo_defconfig	2005-04-17 10:39:47.988326441 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:22:58 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:01 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -99,6 +100,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -118,6 +120,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -137,6 +140,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -171,6 +175,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -320,8 +325,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -476,6 +479,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -595,6 +599,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_DN_SERIAL=y
@@ -615,10 +624,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -778,8 +793,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -816,6 +832,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/atari_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/atari_defconfig	2005-04-17 10:39:47.988326441 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:11 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:03 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -100,6 +101,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -125,6 +127,7 @@ CONFIG_PARPORT_1284=y
 #
 CONFIG_ATARI_FLOPPY=y
 # CONFIG_PARIDE is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -144,6 +147,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -201,6 +205,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -349,8 +354,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -507,6 +510,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 # CONFIG_SERIO_PARKBD is not set
+CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -619,6 +623,7 @@ CONFIG_FONT_8x16=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -648,6 +653,11 @@ CONFIG_DMASOUND=m
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_ATARI_MFPSER=m
@@ -672,9 +682,15 @@ CONFIG_REISERFS_PROC_INFO=y
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -833,8 +849,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -871,6 +888,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/bvme6000_defconfig	2005-04-17 10:44:01.982181521 +0200
+++ linux-m68k-2.6.11/arch/m68k/configs/bvme6000_defconfig	2005-04-17 10:39:47.989326275 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:15 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:04 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -99,6 +100,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -118,6 +120,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -137,6 +140,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -171,6 +175,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -322,8 +327,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -477,6 +480,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -596,6 +600,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_BVME6000_SCC=y
@@ -616,10 +625,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -779,8 +794,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -817,6 +833,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/hp300_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/hp300_defconfig	2005-04-17 10:39:47.989326275 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:40 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:06 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -100,6 +101,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -119,6 +121,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -138,6 +141,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -172,6 +176,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -321,8 +326,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -477,6 +480,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -596,6 +600,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 
@@ -614,10 +623,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -777,8 +792,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -815,6 +831,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/mac_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/mac_defconfig	2005-04-17 10:39:47.990326109 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:44 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:08 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -101,6 +102,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -120,6 +122,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -139,6 +142,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -196,6 +200,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -356,8 +361,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -519,6 +522,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -630,6 +634,7 @@ CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
 CONFIG_LOGO_MAC_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -657,6 +662,11 @@ CONFIG_LOGO_MAC_CLUT224=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_MAC_SCC=y
@@ -679,10 +689,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -856,8 +872,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -894,6 +911,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/mvme147_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/mvme147_defconfig	2005-04-17 10:39:47.990326109 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:49 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:09 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -99,6 +100,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -118,6 +120,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -137,6 +140,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -171,6 +175,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -321,8 +326,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -477,6 +480,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -584,6 +588,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -611,6 +616,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_MVME147_SCC=y
@@ -631,10 +641,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -796,8 +812,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -834,6 +851,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/mvme16x_defconfig	2005-04-17 10:44:01.983181355 +0200
+++ linux-m68k-2.6.11/arch/m68k/configs/mvme16x_defconfig	2005-04-17 10:39:47.990326109 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:53 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:11 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -99,6 +100,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -118,6 +120,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -137,6 +140,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -171,6 +175,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -322,8 +327,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -478,6 +481,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -585,6 +589,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -612,6 +617,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_MVME162_SCC=y
@@ -632,10 +642,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -797,8 +813,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -835,6 +852,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/q40_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/q40_defconfig	2005-04-17 10:39:47.991325943 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:57 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:12 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -101,6 +102,7 @@ CONFIG_GENERIC_ISA_DMA=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -123,6 +125,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_DEV_XD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -142,6 +145,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -200,6 +204,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -374,8 +379,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -547,6 +550,7 @@ CONFIG_SERIO=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
 CONFIG_SERIO_Q40KBD=m
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -658,6 +662,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -687,6 +692,11 @@ CONFIG_DMASOUND=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 
@@ -705,10 +715,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -868,8 +884,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -906,6 +923,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/sun3_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/sun3_defconfig	2005-04-17 10:39:47.991325943 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:24:01 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:14 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -87,6 +88,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -106,6 +108,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -125,6 +128,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -159,6 +163,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -309,8 +314,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -466,6 +469,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -573,6 +577,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -600,6 +605,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 
@@ -618,10 +628,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -783,8 +799,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -821,6 +838,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/configs/sun3x_defconfig	2005-01-22 09:27:50.000000000 +0100
+++ linux-m68k-2.6.11/arch/m68k/configs/sun3x_defconfig	2005-04-17 10:39:47.992325777 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:24:05 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:28:15 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -27,7 +28,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
@@ -98,6 +99,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -117,6 +119,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -136,6 +139,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -170,6 +174,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -320,8 +325,6 @@ CONFIG_IP_NF_TARGET_NOTRACK=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP_NF_COMPAT_IPCHAINS=m
-CONFIG_IP_NF_COMPAT_IPFWADM=m
 
 #
 # IPv6: Netfilter Configuration
@@ -476,6 +479,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -583,6 +587,7 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -610,6 +615,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 
@@ -628,10 +638,16 @@ CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_FS_XATTR is not set
 CONFIG_JFS_FS=m
 # CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_SECURITY is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
 CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
 # CONFIG_XFS_RT is not set
 # CONFIG_XFS_QUOTA is not set
 # CONFIG_XFS_SECURITY is not set
@@ -793,8 +809,9 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
@@ -831,6 +848,10 @@ CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_TEST=m
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
--- linux-2.6.11/arch/m68k/defconfig	2005-04-17 10:44:01.984181189 +0200
+++ linux-m68k-2.6.11/arch/m68k/defconfig	2005-04-17 10:39:47.987326607 +0200
@@ -1,12 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-m68k
-# Sun Dec 26 11:23:36 2004
+# Linux kernel version: 2.6.11-m68k
+# Wed Mar  2 15:27:58 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
@@ -92,6 +93,7 @@ CONFIG_PROC_HARDWARE=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -112,6 +114,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 CONFIG_AMIGA_FLOPPY=y
 # CONFIG_AMIGA_Z2RAM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
@@ -130,6 +133,7 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -164,6 +168,7 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -333,6 +338,7 @@ CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 
 #
@@ -442,6 +448,7 @@ CONFIG_DUMMY_CONSOLE=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -469,6 +476,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # Character devices
 #
 CONFIG_AMIGA_BUILTIN_SERIAL=y
@@ -485,6 +497,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 CONFIG_MINIX_FS=y
 # CONFIG_ROMFS_FS is not set
@@ -546,7 +562,6 @@ CONFIG_NFS_FS=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -611,6 +626,7 @@ CONFIG_NLS_CODEPAGE_437=y
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 
 #
 # Security options
@@ -624,6 +640,10 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
