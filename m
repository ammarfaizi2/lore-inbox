Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVIHFmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVIHFmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVIHFmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:42:35 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:12504 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932614AbVIHFme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:42:34 -0400
Message-ID: <431FCF11.3090906@jp.fujitsu.com>
Date: Thu, 08 Sep 2005 14:41:37 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13 1/4] Cleanup - remove unnecessary handle_IRQ_event()
 prototype (mips)
References: <431FCDBF.2010409@jp.fujitsu.com>
In-Reply-To: <431FCDBF.2010409@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype for handle_IRQ_event() in include/asm-mips/irq.h
seems no longer needed because mips uses GENERIC_HARDIRQ. This patch
removes it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 include/asm-mips/irq.h |    3 ---
 1 files changed, 3 deletions(-)

Index: linux-2.6.13/include/asm-mips/irq.h
===================================================================
--- linux-2.6.13.orig/include/asm-mips/irq.h
+++ linux-2.6.13/include/asm-mips/irq.h
@@ -49,7 +49,4 @@ do {									\
 
 extern void arch_init_irq(void);
 
-struct irqaction;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
-
 #endif /* _ASM_IRQ_H */

