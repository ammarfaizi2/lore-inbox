Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUGEJjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUGEJjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUGEJhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:37:01 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:32734 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265977AbUGEJeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:34:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Return value from no_action in irq.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040705093210.EB003493@mctpc71>
Date: Mon,  5 Jul 2004 18:32:10 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/irq.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/arch/v850/kernel/irq.c linux-2.6.7-uc0-v850-20040705/arch/v850/kernel/irq.c
--- linux-2.6.7-uc0/arch/v850/kernel/irq.c	2004-02-06 10:21:55.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040705/arch/v850/kernel/irq.c	2004-07-05 18:13:28.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/irq.c -- High-level interrupt handling
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994-2000  Ralf Baechle
  *  Copyright (C) 1992  Linus Torvalds
  *
@@ -40,7 +40,10 @@
  * Special irq handlers.
  */
 
-irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
+irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
 
 /*
  * Generic no controller code
