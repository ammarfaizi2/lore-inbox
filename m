Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVADWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVADWtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVADWex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:34:53 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:24966 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262391AbVADWd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:33:27 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104223346.21889.61950.89635@localhost.localdomain>
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Subject: [PATCH 3/4] mips: remove cli()/sti() in arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 16:33:26 -0600
Date: Tue, 4 Jan 2005 16:33:26 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c linux-2.6.10-mm1/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
--- linux-2.6.10-mm1-original/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2004-12-24 16:34:30.000000000 -0500
+++ linux-2.6.10-mm1/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2005-01-04 16:55:42.122629623 -0500
@@ -669,7 +669,7 @@
 {
 	extern void tx4927_irq_init(void);
 
-	cli();
+	local_irq_disable();
 
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
