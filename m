Return-Path: <linux-kernel-owner+w=401wt.eu-S1761825AbWLJQMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761825AbWLJQMq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761829AbWLJQMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:12:45 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:6019 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761825AbWLJQMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:12:45 -0500
Message-Id: <20061210161159.321405000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 08:11:59 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] drop some kruft
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some left overs.. Seems like I've made this patch before.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 init/main.c |    6 ------
 1 files changed, 6 deletions(-)

Index: linux-2.6.19/init/main.c
===================================================================
--- linux-2.6.19.orig/init/main.c
+++ linux-2.6.19/init/main.c
@@ -667,12 +667,6 @@ static void __init do_initcalls(void)
 			msg = "disabled interrupts";
 			local_irq_enable();
 		}
-#ifdef CONFIG_PREEMPT_RT
-		if (irqs_disabled()) {
-			msg = "disabled hard interrupts";
-			local_irq_enable();
-		}
-#endif
 		if (msg) {
 			printk(KERN_WARNING "initcall at 0x%p", *call);
 			print_fn_descriptor_symbol(": %s()",
--
