Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVIHFoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVIHFoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVIHFoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:44:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40379 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932623AbVIHFoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:44:10 -0400
Message-ID: <431FCF50.80600@jp.fujitsu.com>
Date: Thu, 08 Sep 2005 14:42:40 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13 2/4] Cleanup - remove unnecessary handle_IRQ_event()
 prototype (ppc)
References: <431FCDBF.2010409@jp.fujitsu.com>
In-Reply-To: <431FCDBF.2010409@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype for handle_IRQ_event() in include/asm-ppc/irq.h
seems no longer needed because ppc uses GENERIC_HARDIRQ. This patch
removes it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 include/asm-ppc/irq.h |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.13/include/asm-ppc/irq.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/irq.h
+++ linux-2.6.13/include/asm-ppc/irq.h
@@ -398,9 +398,5 @@ extern unsigned long ppc_cached_irq_mask
 extern unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
 extern atomic_t ppc_n_lost_interrupts;
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */

