Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGYOVp>; Thu, 25 Jul 2002 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGYOVp>; Thu, 25 Jul 2002 10:21:45 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31107
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314553AbSGYOVp>; Thu, 25 Jul 2002 10:21:45 -0400
Date: Thu, 25 Jul 2002 07:24:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Export synchronize_irq on CONFIG_SMP=y
Message-ID: <20020725142457.GB746@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all arches which support SMP define synchronize_irq(irq)
to be a real function (generally defined in arch/$(ARCH)/kernel/irq.c).
This export was removed inadvertanly I believe in the "bit IRQ lock"
removal and IRQ cleanups ChangeSet.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/i386/kernel/i386_ksyms.c 1.26 vs edited =====
--- 1.26/arch/i386/kernel/i386_ksyms.c	Sun Jul 21 09:09:17 2002
+++ edited/arch/i386/kernel/i386_ksyms.c	Thu Jul 25 07:24:12 2002
@@ -133,6 +133,7 @@
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 
 /* Global SMP stuff */
+EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
