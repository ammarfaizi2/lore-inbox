Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbUDRXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbUDRXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:12:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:17820 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264200AbUDRXM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:12:26 -0400
Subject: [PATCH] Fix typo in previous patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082329606.13458.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 09:06:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my brown paper bag day, I sent you the wrong patch for
fixing the deadlock in rtas.c, here's one to apply on top of current
bk that fixes build. Sorry.

===== arch/ppc64/kernel/rtas.c 1.28 vs edited =====
--- 1.28/arch/ppc64/kernel/rtas.c	Mon Apr 19 02:13:09 2004
+++ edited/arch/ppc64/kernel/rtas.c	Mon Apr 19 09:05:35 2004
@@ -505,7 +505,7 @@
 {
 	struct rtas_args *rtas_args = &(get_paca()->xRtas);
 
-	local_irq_disable(s);
+	local_irq_disable();
 
 	rtas_args->token = rtas_token("stop-self");
 	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);


