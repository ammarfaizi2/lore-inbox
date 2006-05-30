Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWE3KFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWE3KFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWE3KFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:05:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:444 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932203AbWE3KFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:05:09 -0400
Date: Tue, 30 May 2006 12:05:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] genirq: ia64 build fix
Message-ID: <20060530100526.GA31982@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: genirq: ia64 build fix
From: Ingo Molnar <mingo@elte.hu>

fix missed handler -> chip rename.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/ia64/hp/sim/hpsim_irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/ia64/hp/sim/hpsim_irq.c
===================================================================
--- linux.orig/arch/ia64/hp/sim/hpsim_irq.c
+++ linux/arch/ia64/hp/sim/hpsim_irq.c
@@ -45,7 +45,7 @@ hpsim_irq_init (void)
 
 	for (i = 0; i < NR_IRQS; ++i) {
 		idesc = irq_desc + i;
-		if (idesc->handler == &no_irq_type)
-			idesc->handler = &irq_type_hp_sim;
+		if (idesc->chip == &no_irq_type)
+			idesc->chip = &irq_type_hp_sim;
 	}
 }
