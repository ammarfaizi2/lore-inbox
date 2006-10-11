Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWJKQkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWJKQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWJKQkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:40:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47292 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161126AbWJKQkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:40:23 -0400
To: torvalds@osdl.org
Subject: [PATCH] remove bogus arch-specific syscall exports
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXh82-00066y-2H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:40:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/kernel/armksyms.c        |    6 ------
 arch/arm26/kernel/armksyms.c      |    8 --------
 arch/parisc/kernel/parisc_ksyms.c |    4 ----
 arch/s390/kernel/s390_ksyms.c     |    1 -
 4 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index da69e66..4779f47 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -178,9 +178,3 @@ EXPORT_SYMBOL(_find_next_zero_bit_be);
 EXPORT_SYMBOL(_find_first_bit_be);
 EXPORT_SYMBOL(_find_next_bit_be);
 #endif
-
-	/* syscalls */
-EXPORT_SYMBOL(sys_write);
-EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(sys_exit);
-EXPORT_SYMBOL(sys_wait4);
diff --git a/arch/arm26/kernel/armksyms.c b/arch/arm26/kernel/armksyms.c
index 07907b6..93293d0 100644
--- a/arch/arm26/kernel/armksyms.c
+++ b/arch/arm26/kernel/armksyms.c
@@ -202,14 +202,6 @@ EXPORT_SYMBOL(_find_next_zero_bit_le);
 EXPORT_SYMBOL(elf_platform);
 EXPORT_SYMBOL(elf_hwcap);
 
-	/* syscalls */
-EXPORT_SYMBOL(sys_write);
-EXPORT_SYMBOL(sys_read);
-EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(sys_open);
-EXPORT_SYMBOL(sys_exit);
-EXPORT_SYMBOL(sys_wait4);
-
 #ifdef CONFIG_PREEMPT
 EXPORT_SYMBOL(kernel_flag);
 #endif
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 6d57553..8f6a0b3 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -69,10 +69,6 @@ EXPORT_SYMBOL(memcpy_toio);
 EXPORT_SYMBOL(memcpy_fromio);
 EXPORT_SYMBOL(memset_io);
 
-#include <asm/unistd.h>
-EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(sys_write);
-
 #include <asm/semaphore.h>
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down_interruptible);
diff --git a/arch/s390/kernel/s390_ksyms.c b/arch/s390/kernel/s390_ksyms.c
index 9f19e83..90b5ef5 100644
--- a/arch/s390/kernel/s390_ksyms.c
+++ b/arch/s390/kernel/s390_ksyms.c
@@ -51,4 +51,3 @@ EXPORT_SYMBOL(csum_fold);
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_devno);
 EXPORT_SYMBOL(console_irq);
-EXPORT_SYMBOL(sys_wait4);
-- 
1.4.2.GIT

