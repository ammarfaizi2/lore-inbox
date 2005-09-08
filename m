Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVIHFoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVIHFoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVIHFoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:44:38 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47035 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932634AbVIHFoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:44:23 -0400
Message-ID: <431FCF88.70004@jp.fujitsu.com>
Date: Thu, 08 Sep 2005 14:43:36 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13 3/4] Cleanup - remove unnecessary handle_IRQ_event()
 prototype (sh)
References: <431FCDBF.2010409@jp.fujitsu.com>
In-Reply-To: <431FCDBF.2010409@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype for handle_IRQ_event() in include/asm-sh/irq.h
seems no longer needed because sh uses GENERIC_HARDIRQ. This patch
removes it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 include/asm-sh/irq.h |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.13/include/asm-sh/irq.h
===================================================================
--- linux-2.6.13.orig/include/asm-sh/irq.h
+++ linux-2.6.13/include/asm-sh/irq.h
@@ -587,10 +587,6 @@ static inline int generic_irq_demux(int 
 #define irq_canonicalize(irq)	(irq)
 #define irq_demux(irq)		__irq_demux(sh_mv.mv_irq_demux(irq))
 
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #if defined(CONFIG_CPU_SUBTYPE_SH73180)
 #include <asm/irq-sh73180.h>
 #endif

