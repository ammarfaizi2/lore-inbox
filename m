Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbTGFWZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbTGFWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:25:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:53939 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266752AbTGFWZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:25:09 -0400
Date: Mon, 7 Jul 2003 00:39:40 +0200 (MEST)
Message-Id: <200307062239.h66Mdegl023758@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.4.22-pre3] fix x86-64 show_regs() loop
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_regs() should call __show_regs() not itself.

/Mikael

--- linux-2.4.22-pre3/arch/x86_64/kernel/process.c.~1~	2003-07-06 18:37:43.000000000 +0200
+++ linux-2.4.22-pre3/arch/x86_64/kernel/process.c	2003-07-06 19:21:07.000000000 +0200
@@ -366,7 +366,7 @@
 
 void show_regs(struct pt_regs * regs)
 {
-	show_regs(regs);
+	__show_regs(regs);
 	show_trace(&regs->rsp);
 }
 
