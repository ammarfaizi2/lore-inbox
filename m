Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWH2LKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWH2LKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWH2LKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:10:34 -0400
Received: from server6.greatnet.de ([83.133.96.26]:1410 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932299AbWH2LKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:10:33 -0400
Message-ID: <44F420CC.4010608@nachtwindheim.de>
Date: Tue, 29 Aug 2006 13:11:08 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: mingo@redhead.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [DOC] kerneldoc for handle_bad_irq()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Adds the description of the parameters from handle_bad_irq().
That should be merged before 2.6.18 release.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

diff -ruN linux-2.6.18-rc2/kernel/irq/handle.c linux/kernel/irq/handle.c
--- linux-2.6.18-rc2/kernel/irq/handle.c        2006-07-18 13:37:39.000000000 +0200
+++ linux/kernel/irq/handle.c   2006-07-18 13:51:15.000000000 +0200
@@ -20,6 +20,11 @@

 /**
  * handle_bad_irq - handle spurious and unhandled irqs
+ * @irq:       the interrupt number
+ * @desc:      description of the interrupt
+ * @regs:      pointer to a register structure
+ *
+ * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
  */
 void fastcall
 handle_bad_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
