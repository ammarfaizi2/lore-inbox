Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUIGOxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUIGOxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUIGOu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:50:59 -0400
Received: from verein.lst.de ([213.95.11.210]:49049 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268111AbUIGOpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:45:44 -0400
Date: Tue, 7 Sep 2004 16:45:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport get_wchan
Message-ID: <20040907144539.GA8808@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only usedby procfs which certainly can't be modular


--- 1.38/arch/alpha/kernel/alpha_ksyms.c	2004-08-31 01:05:49 +02:00
+++ edited/arch/alpha/kernel/alpha_ksyms.c	2004-09-07 14:44:39 +02:00
@@ -258,8 +258,6 @@
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memchr);
 
-EXPORT_SYMBOL(get_wchan);
-
 #ifdef CONFIG_ALPHA_IRONGATE
 EXPORT_SYMBOL(irongate_ioremap);
 EXPORT_SYMBOL(irongate_iounmap);
--- 1.39/arch/arm/kernel/process.c	2004-06-22 05:14:16 +02:00
+++ edited/arch/arm/kernel/process.c	2004-09-07 14:43:04 +02:00
@@ -452,4 +452,3 @@
 	} while (count ++ < 16);
 	return 0;
 }
-EXPORT_SYMBOL(get_wchan);
--- 1.2/arch/arm26/kernel/armksyms.c	2004-02-25 11:31:13 +01:00
+++ edited/arch/arm26/kernel/armksyms.c	2004-09-07 14:44:44 +02:00
@@ -219,8 +219,6 @@
 EXPORT_SYMBOL_NOVERS(__down_trylock_failed);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
 
-EXPORT_SYMBOL(get_wchan);
-
 #ifdef CONFIG_PREEMPT
 EXPORT_SYMBOL(kernel_flag);
 #endif
--- 1.4/arch/h8300/kernel/h8300_ksyms.c	2004-05-25 11:53:07 +02:00
+++ edited/arch/h8300/kernel/h8300_ksyms.c	2004-09-07 14:45:23 +02:00
@@ -58,8 +58,6 @@
 EXPORT_SYMBOL_NOVERS(memscan);
 EXPORT_SYMBOL_NOVERS(memmove);
 
-EXPORT_SYMBOL(get_wchan);
-
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
--- 1.63/arch/i386/kernel/i386_ksyms.c	2004-08-31 09:55:10 +02:00
+++ edited/arch/i386/kernel/i386_ksyms.c	2004-09-07 14:45:26 +02:00
@@ -167,8 +167,6 @@
 EXPORT_SYMBOL(screen_info);
 #endif
 
-EXPORT_SYMBOL(get_wchan);
-
 EXPORT_SYMBOL(rtc_lock);
 
 EXPORT_SYMBOL_GPL(set_nmi_callback);
--- 1.11/arch/m68k/kernel/m68k_ksyms.c	2003-04-01 00:29:49 +02:00
+++ edited/arch/m68k/kernel/m68k_ksyms.c	2004-09-07 14:45:33 +02:00
@@ -85,5 +85,3 @@
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
-
-EXPORT_SYMBOL(get_wchan);
--- 1.4/arch/m68knommu/kernel/m68k_ksyms.c	2004-05-10 15:51:25 +02:00
+++ edited/arch/m68knommu/kernel/m68k_ksyms.c	2004-09-07 14:45:37 +02:00
@@ -61,8 +61,6 @@
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
 
-EXPORT_SYMBOL(get_wchan);
-
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
===== arch/mips/kernel/process.c 1.14 vs edited =====
--- 1.14/arch/mips/kernel/process.c	2004-05-10 13:25:34 +02:00
+++ edited/arch/mips/kernel/process.c	2004-09-07 14:43:23 +02:00
@@ -340,5 +340,3 @@
 
 	return pc;
 }
-
-EXPORT_SYMBOL(get_wchan);
--- 1.60/arch/ppc/kernel/ppc_ksyms.c	2004-06-25 14:52:53 +02:00
+++ edited/arch/ppc/kernel/ppc_ksyms.c	2004-09-07 14:45:43 +02:00
@@ -295,7 +295,6 @@
 void ppc_irq_dispatch_handler(struct pt_regs *, int);
 EXPORT_SYMBOL(ppc_irq_dispatch_handler);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
-EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
 #ifdef CONFIG_XMON
 EXPORT_SYMBOL(xmon);
--- 1.42/arch/ppc64/kernel/ppc_ksyms.c	2004-06-24 10:55:56 +02:00
+++ edited/arch/ppc64/kernel/ppc_ksyms.c	2004-09-07 14:45:46 +02:00
@@ -157,7 +157,6 @@
 
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
-EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
 
 EXPORT_SYMBOL(tb_ticks_per_usec);
