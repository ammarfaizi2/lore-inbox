Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVADWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVADWgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVADWfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:35:17 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:45245 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262273AbVADWdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:33:15 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104223333.21889.75956.21338@localhost.localdomain>
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Subject: [PATCH 1/4] mips: remove cli()/sti() in arch/mips/gt64120/ev64120/irq.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 16:33:13 -0600
Date: Tue, 4 Jan 2005 16:33:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/mips/gt64120/ev64120/irq.c linux-2.6.10-mm1/arch/mips/gt64120/ev64120/irq.c
--- linux-2.6.10-mm1-original/arch/mips/gt64120/ev64120/irq.c	2005-01-03 18:42:40.217472760 -0500
+++ linux-2.6.10-mm1/arch/mips/gt64120/ev64120/irq.c	2005-01-04 16:49:18.217458194 -0500
@@ -119,7 +119,7 @@
 	/* Sets the exception_handler array. */
 	set_except_vector(0, galileo_handle_int);
 
-	cli();
+	local_irq_disable();
 
 	/*
 	 * Enable timer.  Other interrupts will be enabled as they are
