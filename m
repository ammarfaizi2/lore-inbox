Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULNBOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULNBOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULNBMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:12:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261372AbULNBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:10:36 -0500
Date: Tue, 14 Dec 2004 02:10:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64: remove duplicate includes
Message-ID: <20041214011030.GT23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's usually no reason for including the same header file twice.

The patch below removes such duplicate includes in x86_64 specific 
files.


diffstat output:
 arch/x86_64/kernel/entry.S       |    1 -
 arch/x86_64/kernel/module.c      |    1 -
 arch/x86_64/kernel/setup.c       |    1 -
 arch/x86_64/kernel/time.c        |    1 -
 arch/x86_64/kernel/x8664_ksyms.c |    1 -
 include/asm-x86_64/pci.h         |    1 -
 6 files changed, 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/arch/x86_64/kernel/entry.S.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/entry.S	2004-10-22 21:50:19.000000000 +0200
@@ -41,7 +41,6 @@
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
 #include <asm/hw_irq.h>
-#include <asm/errno.h>
 
 	.code64
 
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/module.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/module.c	2004-10-22 21:50:24.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 
 #include <asm/system.h>
 #include <asm/page.h>
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/setup.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/setup.c	2004-10-22 21:50:31.000000000 +0200
@@ -53,7 +53,6 @@
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
 #include <asm/bootsetup.h>
-#include <asm/smp.h>
 #include <asm/proto.h>
 #include <asm/setup.h>
 
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/time.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/time.c	2004-10-22 21:50:57.000000000 +0200
@@ -1000,7 +1000,6 @@
  * For (3), we use interrupts at 64Hz or user specified periodic
  * frequency, whichever is higher.
  */
-#include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
 
 extern irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
--- linux-2.6.9-mm1-full/arch/x86_64/kernel/x8664_ksyms.c.old	2004-10-22 21:37:32.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/x86_64/kernel/x8664_ksyms.c	2004-10-22 21:51:04.000000000 +0200
@@ -30,7 +30,6 @@
 #include <asm/nmi.h>
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
-#include <asm/delay.h>
 #include <asm/tlbflush.h>
 
 extern spinlock_t rtc_lock;
--- linux-2.6.9-mm1-full/include/asm-x86_64/pci.h.old	2004-10-22 21:37:34.000000000 +0200
+++ linux-2.6.9-mm1-full/include/asm-x86_64/pci.h	2004-10-22 22:00:25.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
 #include <linux/string.h>
-#include <asm/io.h>
 #include <asm/page.h>
 
 extern int iommu_setup(char *opt);

