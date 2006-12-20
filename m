Return-Path: <linux-kernel-owner+w=401wt.eu-S965133AbWLTPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWLTPbs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLTPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:31:48 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:44082 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965133AbWLTPbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:31:48 -0500
X-Greylist: delayed 1918 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 10:31:48 EST
Date: Wed, 20 Dec 2006 15:59:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] __set_irq_handler bogus space
Message-ID: <Pine.LNX.4.62.0612201559100.457@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__set_irq_handler: Kill a bogus space

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 kernel/irq/chip.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- ps3-linux-src.orig/kernel/irq/chip.c
+++ ps3-linux-src/kernel/irq/chip.c
@@ -520,7 +520,7 @@ __set_irq_handler(unsigned int irq, irq_
 
 	if (desc->chip == &no_irq_chip) {
 		printk(KERN_WARNING "Trying to install %sinterrupt handler "
-		       "for IRQ%d\n", is_chained ? "chained " : " ", irq);
+		       "for IRQ%d\n", is_chained ? "chained " : "", irq);
 		/*
 		 * Some ARM implementations install a handler for really dumb
 		 * interrupt hardware without setting an irq_chip. This worked

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
