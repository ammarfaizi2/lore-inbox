Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271812AbTGRKFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTGRJrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:47:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:54015 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271532AbTGRJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Rename config option CONFIG_V850E_MA1_HIGHRES_TIMER on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094540.3E2F537C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This feature is not actually MA1-specific, so get rid of the `MA1' in
the name.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/intv.S linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/intv.S
--- linux-2.6.0-test1-moo/arch/v850/kernel/intv.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/intv.S	2003-07-16 17:23:42.000000000 +0900
@@ -16,7 +16,7 @@
 #include <asm/machdep.h>
 #include <asm/entry.h>
 
-#ifdef CONFIG_V850E_MA1_HIGHRES_TIMER
+#ifdef CONFIG_V850E_HIGHRES_TIMER
 #include <asm/highres_timer.h>
 #endif
 
@@ -59,7 +59,7 @@
 	.section	.intv.mach, "ax"
 	.org	0x0
 
-#if defined (CONFIG_V850E_MA1_HIGHRES_TIMER) && defined (IRQ_INTCMD)
+#if defined (CONFIG_V850E_HIGHRES_TIMER) && defined (IRQ_INTCMD)
 
 	/* Interrupts before the highres timer interrupt.  */
 	.rept	IRQ_INTCMD (HIGHRES_TIMER_TIMER_D_UNIT)
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/entry.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/entry.h
--- linux-2.6.0-test1-moo/include/asm-v850/entry.h	2003-02-25 10:45:23.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/entry.h	2003-07-16 17:23:42.000000000 +0900
@@ -65,10 +65,10 @@
 #define RESET_GUARD_ACTIVE	0xFAB4BEEF
 #endif /* CONFIG_RESET_GUARD */
 
-#ifdef CONFIG_V850E_MA1_HIGHRES_TIMER
+#ifdef CONFIG_V850E_HIGHRES_TIMER
 #define HIGHRES_TIMER_SLOW_TICKS_ADDR (KERNEL_VAR_SPACE_ADDR + 32)
 #define HIGHRES_TIMER_SLOW_TICKS     KERNEL_VAR (HIGHRES_TIMER_SLOW_TICKS_ADDR)
-#endif /* CONFIG_V850E_MA1_HIGHRES_TIMER */
+#endif /* CONFIG_V850E_HIGHRES_TIMER */
 
 #ifndef __ASSEMBLY__
 
