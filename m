Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWE3RRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWE3RRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWE3RRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:17:25 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:55751 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932350AbWE3RRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:17:24 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Message-Id: <20060530171723.27305.31883.sendpatchset@skynet>
In-Reply-To: <20060530171642.27305.38862.sendpatchset@skynet>
References: <20060530171642.27305.38862.sendpatchset@skynet>
Subject: [PATCH 2/2] 2.6.17-rc5-mm1 compile-fix on ia64 for desc->handler
Date: Tue, 30 May 2006 18:17:23 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


genirq-rename-desc-handler-to-desc-chip.patch renames a number of IRQ
desc->handler to desk->chip. This patch renames one that was missed.



 hpsim_irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc5-mm1-irqflags/arch/ia64/hp/sim/hpsim_irq.c linux-2.6.17-rc5-mm1-hpsim_irq/arch/ia64/hp/sim/hpsim_irq.c
--- linux-2.6.17-rc5-mm1-irqflags/arch/ia64/hp/sim/hpsim_irq.c	2006-05-30 14:41:20.000000000 +0100
+++ linux-2.6.17-rc5-mm1-hpsim_irq/arch/ia64/hp/sim/hpsim_irq.c	2006-05-30 16:25:31.000000000 +0100
@@ -45,7 +45,7 @@ hpsim_irq_init (void)
 
 	for (i = 0; i < NR_IRQS; ++i) {
 		idesc = irq_desc + i;
-		if (idesc->handler == &no_irq_type)
-			idesc->handler = &irq_type_hp_sim;
+		if (idesc->chip == &no_irq_type)
+			idesc->chip = &irq_type_hp_sim;
 	}
 }
