Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbVIHFpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVIHFpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVIHFp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:45:27 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:11175 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932643AbVIHFpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:45:23 -0400
Message-ID: <431FCFBF.2010009@jp.fujitsu.com>
Date: Thu, 08 Sep 2005 14:44:31 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13 4/4] Cleanup - remove unnecessary handle_IRQ_event()
 prototype (x86_64)
References: <431FCDBF.2010409@jp.fujitsu.com>
In-Reply-To: <431FCDBF.2010409@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype for handle_IRQ_event() in include/asm-x86_64/irq.h
seems no longer needed because x86_64 uses GENERIC_HARDIRQ. This patch
removes it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 include/asm-x86_64/irq.h |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.13/include/asm-x86_64/irq.h
===================================================================
--- linux-2.6.13.orig/include/asm-x86_64/irq.h
+++ linux-2.6.13/include/asm-x86_64/irq.h
@@ -48,10 +48,6 @@ static __inline__ int irq_canonicalize(i
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #ifdef CONFIG_HOTPLUG_CPU
 #include <linux/cpumask.h>
 extern void fixup_irqs(cpumask_t map);

