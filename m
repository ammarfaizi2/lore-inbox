Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWGCAS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWGCAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWGCASz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:18:55 -0400
Received: from www.osadl.org ([213.239.205.134]:63672 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750812AbWGCASy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:18:54 -0400
Subject: [PATCH] ARM: Fixup missing includes in arch/arm/mm/proc-<cputype>.S
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 02:21:18 +0200
Message-Id: <1151886079.24611.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For several proc-<cputype>.S files the include of proc-macros.S is
missing. Make it compile and work again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.git/arch/arm/mm/proc-sa110.S
===================================================================
--- linux-2.6.git.orig/arch/arm/mm/proc-sa110.S	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/arch/arm/mm/proc-sa110.S	2006-07-03 01:00:52.000000000 +0200
@@ -23,6 +23,8 @@
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 
+#include "proc-macros.S"
+
 /*
  * the cache line size of the I and D cache
  */
Index: linux-2.6.git/arch/arm/mm/proc-sa1100.S
===================================================================
--- linux-2.6.git.orig/arch/arm/mm/proc-sa1100.S	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/arch/arm/mm/proc-sa1100.S	2006-07-03 00:58:54.000000000 +0200
@@ -27,6 +27,8 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 
+#include "proc-macros.S"
+
 /*
  * the cache line size of the I and D cache
  */
Index: linux-2.6.git/arch/arm/mm/proc-arm720.S
===================================================================
--- linux-2.6.git.orig/arch/arm/mm/proc-arm720.S	2006-07-03 00:13:24.000000000 +0200
+++ linux-2.6.git/arch/arm/mm/proc-arm720.S	2006-07-03 01:08:16.000000000 +0200
@@ -41,6 +41,8 @@
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
 
+#include "proc-macros.S"
+
 /*
  * Function: arm720_proc_init (void)
  *	   : arm720_proc_fin (void)


