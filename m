Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWFSStx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWFSStx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWFSSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:13311 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932459AbWFSSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:20 -0400
Message-Id: <20060619183404.360808000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:18 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 03/20] cell: update defconfig
Content-Disposition: inline; filename=defconfig-update.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable some of the most requested features in defconfig
and refresh with the latest powerpc.git Kconfig files.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: powerpc.git/arch/powerpc/configs/cell_defconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/configs/cell_defconfig
+++ powerpc.git/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16
-# Thu Mar 23 20:48:09 2006
+# Linux kernel version: 2.6.17
+# Mon Jun 19 17:23:03 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -11,6 +11,7 @@ CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_COMPAT=y
@@ -55,7 +56,7 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-# CONFIG_CPUSETS is not set
+CONFIG_CPUSETS=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -116,6 +117,7 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 CONFIG_PPC_CELL=y
+CONFIG_PPC_SYSTEMSIM=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
@@ -153,20 +155,24 @@ CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
-# CONFIG_NUMA is not set
+CONFIG_NUMA=y
+CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_SPARSEMEM=y
+CONFIG_NEED_MULTIPLE_NODES=y
 CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPARSEMEM_EXTREME=y
-# CONFIG_MEMORY_HOTPLUG is not set
+CONFIG_MEMORY_HOTPLUG=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
+CONFIG_ARCH_MEMORY_PROBE=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
@@ -183,6 +189,7 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+CONFIG_PCIEPORTBUS=y
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -477,7 +484,7 @@ CONFIG_DM_MULTIPATH=m
 #
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
+CONFIG_BONDING=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 
@@ -625,6 +632,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_N_HDLC is not set
 # CONFIG_SPECIALIX is not set
 # CONFIG_SX is not set
+# CONFIG_RIO is not set
 # CONFIG_STALDRV is not set
 
 #
@@ -767,6 +775,7 @@ CONFIG_I2C_ALGOBIT=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -1055,11 +1064,7 @@ CONFIG_DEBUGGER=y
 # CONFIG_XMON is not set
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options

--

