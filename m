Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTE0JIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTE0JIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:08:32 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31111 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262942AbTE0JI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:08:26 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Update irq.c on v850 to use irqreturn_t
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527092133.70D893773@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 18:21:33 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.70/arch/v850/kernel/irq.c linux-2.5.70-v850-20030527/arch/v850/kernel/irq.c
--- linux-2.5.70/arch/v850/kernel/irq.c	2003-03-18 13:23:02.000000000 +0900
+++ linux-2.5.70-v850-20030527/arch/v850/kernel/irq.c	2003-05-27 16:09:43.000000000 +0900
@@ -35,7 +35,7 @@
  * Special irq handlers.
  */
 
-void no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
+irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
 
 /*
  * Generic no controller code
@@ -352,7 +352,7 @@
  */
  
 int request_irq(unsigned int irq, 
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		unsigned long irqflags, 
 		const char * devname,
 		void *dev_id)
