Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVINPxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVINPxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVINPxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:53:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:38589 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030204AbVINPxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:53:07 -0400
Date: Wed, 14 Sep 2005 17:53:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/7] s390: default configuration.
Message-ID: <20050914155308.GA27169@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/7] s390: default configuration.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Update default configuration of s390.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2005-09-14 16:48:14.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.13-rc4
-# Fri Jul 29 14:49:30 2005
+# Linux kernel version: 2.6.14-rc1
+# Wed Sep 14 16:46:19 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -21,6 +21,7 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -33,6 +34,7 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
@@ -94,6 +96,7 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
 
 #
 # I/O subsystem configuration
@@ -151,8 +154,8 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-CONFIG_IP_TCPDIAG_IPV6=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 CONFIG_IPV6=y
@@ -165,6 +168,11 @@ CONFIG_IPV6=y
 # CONFIG_NETFILTER is not set
 
 #
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
@@ -217,9 +225,11 @@ CONFIG_NET_CLS_POLICE=y
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NETFILTER_NETLINK is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
 # CONFIG_PCMCIA is not set
 
 #
@@ -233,6 +243,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_PROC_FS=y
 
@@ -260,6 +271,7 @@ CONFIG_SCSI_LOGGING=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -280,7 +292,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -384,6 +395,10 @@ CONFIG_EQUALIZER=m
 CONFIG_TUN=m
 
 #
+# PHY device support
+#
+
+#
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
@@ -453,10 +468,6 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-
-#
-# XFS support
-#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -465,6 +476,7 @@ CONFIG_INOTIFY=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -485,11 +497,10 @@ CONFIG_DNOTIFY=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -533,6 +544,7 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -572,6 +584,7 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOG_BUF_SHIFT=17
+CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
@@ -626,5 +639,6 @@ CONFIG_CRYPTO=y
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
