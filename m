Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760512AbWLFL4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760512AbWLFL4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 06:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760513AbWLFL4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 06:56:36 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1268 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760511AbWLFL4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 06:56:35 -0500
Date: Wed, 6 Dec 2006 11:56:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19] i386/io_apic: Fix a typo in an IRQ handler name
Message-ID: <Pine.LNX.4.64N.0612061151010.29000@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The "fasteoi" IRQ handler is named "fasteio" incorrectly.  This is a fix.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 It should be obvious.

 Please apply.

  Maciej

patch-mips-2.6.19-rc2-20061023-fasteoi-0
diff -up --recursive --new-file linux-mips-2.6.19-rc2-20061023.macro/arch/i386/kernel/io_apic.c linux-mips-2.6.19-rc2-20061023/arch/i386/kernel/io_apic.c
--- linux-mips-2.6.19-rc2-20061023.macro/arch/i386/kernel/io_apic.c	2006-10-19 04:56:53.000000000 +0000
+++ linux-mips-2.6.19-rc2-20061023/arch/i386/kernel/io_apic.c	2006-12-06 00:10:05.000000000 +0000
@@ -2236,7 +2236,7 @@ static inline void check_timer(void)
 
 	disable_8259A_irq(0);
 	set_irq_chip_and_handler_name(0, &lapic_chip, handle_fasteoi_irq,
-				      "fasteio");
+				      "fasteoi");
 	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
