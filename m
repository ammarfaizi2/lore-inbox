Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUKXAzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUKXAzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKXAxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:53:19 -0500
Received: from mail.dif.dk ([193.138.115.101]:29669 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261667AbUKXAw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:52:27 -0500
Date: Wed, 24 Nov 2004 02:01:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Subject: [PATCH][very trivial, cosmetic change] indent 1 line to make it
 clear it depends on the if statement above  in arch/x86_64/kernel/traps.c
Message-ID: <Pine.LNX.4.61.0411240157420.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This very trivial cosmetic patch simply indents a single line in 
arch/x86_64/kernel/traps.c to make it obvious when skimming the code that 
it is dependant on the if statement on the line above.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk8-orig/arch/x86_64/kernel/traps.c linux-2.6.10-rc2-bk8/arch/x86_64/kernel/traps.c
--- linux-2.6.10-rc2-bk8-orig/arch/x86_64/kernel/traps.c	2004-11-17 01:19:30.000000000 +0100
+++ linux-2.6.10-rc2-bk8/arch/x86_64/kernel/traps.c	2004-11-24 01:55:57.000000000 +0100
@@ -729,7 +729,7 @@ clear_TF:
 	/* RED-PEN could cause spurious errors */
 	if (notify_die(DIE_DEBUG, "debug2", regs, condition, 1, SIGTRAP) 
 								!= NOTIFY_STOP)
-	regs->eflags &= ~TF_MASK;
+		regs->eflags &= ~TF_MASK;
 	return regs;	
 }
 

