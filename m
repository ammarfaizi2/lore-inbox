Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUCAH2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 02:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCAH2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 02:28:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:48063 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262258AbUCAH2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 02:28:33 -0500
Subject: [PATCH] Update G5 defconfig, remove DISCONTIGMEM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078125499.28288.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 18:18:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch updates the g5_defconfig on ppc64, running it through
oldconfig and removing CONFIG_DISTCONTIGMEM. I don't use the
discontigmem stuff at all, even on machines with +2Gb of RAM,
so it's just bloat.

Ben.

===== arch/ppc64/configs/g5_defconfig 1.2 vs edited =====
--- 1.2/arch/ppc64/configs/g5_defconfig	Sat Feb 14 16:10:02 2004
+++ edited/arch/ppc64/configs/g5_defconfig	Mon Mar  1 18:15:20 2004
@@ -26,6 +26,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=17
+CONFIG_HOTPLUG=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
@@ -56,15 +57,16 @@
 CONFIG_PPC_OF=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_PMAC=y
+# CONFIG_PMAC_DART is not set
 CONFIG_PPC_PMAC64=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_POWER4_ONLY=y
+# CONFIG_IOMMU_VMERGE is not set
 CONFIG_SMP=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NR_CPUS=2
 # CONFIG_HMT is not set
-CONFIG_DISCONTIGMEM=y
-# CONFIG_NUMA is not set
+# CONFIG_DISCONTIGMEM is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_LPARCFG is not set
 
@@ -77,7 +79,6 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
-CONFIG_HOTPLUG=y
 
 #
 # PCMCIA/CardBus support
@@ -128,6 +129,7 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_DCSSBLK is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -277,6 +279,7 @@
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
 CONFIG_DM_IOCTL_V4=y
+# CONFIG_DM_CRYPT is not set
 
 #
 # Fusion MPT device support
@@ -284,7 +287,7 @@
 # CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 CONFIG_IEEE1394=y
 
@@ -318,11 +321,11 @@
 #
 # Macintosh device drivers
 #
+CONFIG_ADB=y
 CONFIG_ADB_PMU=y
 # CONFIG_PMAC_PBOOK is not set
 # CONFIG_PMAC_BACKLIGHT is not set
 # CONFIG_MAC_SERIAL is not set
-CONFIG_ADB=y
 # CONFIG_INPUT_ADBHID is not set
 CONFIG_THERM_PM72=y
 
@@ -439,6 +442,7 @@
 # CONFIG_IXGB is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
+# CONFIG_IBMVETH is not set
 CONFIG_PPP=m
 # CONFIG_PPP_MULTILINK is not set
 # CONFIG_PPP_FILTER is not set
@@ -488,7 +492,7 @@
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set
 
 #
 # Telephony Support
@@ -556,7 +560,8 @@
 #
 # CONFIG_SERIAL_PMACZILOG is not set
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_HVC_CONSOLE=y
 
 #
@@ -676,6 +681,7 @@
 # CONFIG_FB_RADEON_OLD is not set
 CONFIG_FB_RADEON=y
 CONFIG_FB_RADEON_I2C=y
+# CONFIG_FB_RADEON_DEBUG is not set
 # CONFIG_FB_ATY128 is not set
 # CONFIG_FB_ATY is not set
 # CONFIG_FB_SIS is not set
@@ -919,7 +925,6 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 CONFIG_DEVPTS_FS_XATTR=y
 # CONFIG_DEVPTS_FS_SECURITY is not set
 CONFIG_TMPFS=y
@@ -933,6 +938,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -964,7 +970,6 @@
 CONFIG_CIFS=m
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
 
 #
@@ -1037,9 +1042,11 @@
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_XMON is not set
+# CONFIG_DEBUGGER is not set
 # CONFIG_PPCDBG is not set
 # CONFIG_DEBUG_INFO is not set
 


