Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVADWgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVADWgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVADWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:35:04 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:31661 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262388AbVADWdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:33:20 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104223339.21889.43506.17350@localhost.localdomain>
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Subject: [PATCH 2/4] mips: remove cli()/sti() in arch/mips/jmr3927/rbhma3100/setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 16:33:19 -0600
Date: Tue, 4 Jan 2005 16:33:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/mips/jmr3927/rbhma3100/setup.c linux-2.6.10-mm1/arch/mips/jmr3927/rbhma3100/setup.c
--- linux-2.6.10-mm1-original/arch/mips/jmr3927/rbhma3100/setup.c	2005-01-03 18:42:40.230471006 -0500
+++ linux-2.6.10-mm1/arch/mips/jmr3927/rbhma3100/setup.c	2005-01-04 16:50:40.966286806 -0500
@@ -108,7 +108,7 @@
 
 static void jmr3927_machine_restart(char *command)
 {
-	cli();
+	local_irq_disable();
 	puts("Rebooting...");
 	do_reset();
 }
