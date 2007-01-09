Return-Path: <linux-kernel-owner+w=401wt.eu-S1750934AbXAICM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXAICM0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbXAICL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:11:57 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44480 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXAICLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:54 -0500
Message-Id: <200701090205.l0925mRk024401@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/7] UML - const a variable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kstack_depth_to_print can be made const.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/sysrq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm/arch/um/kernel/sysrq.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/sysrq.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/sysrq.c	2007-01-08 16:45:45.000000000 -0500
@@ -50,7 +50,7 @@ void dump_stack(void)
 EXPORT_SYMBOL(dump_stack);
 
 /*Stolen from arch/i386/kernel/traps.c */
-static int kstack_depth_to_print = 24;
+static const int kstack_depth_to_print = 24;
 
 /* This recently started being used in arch-independent code too, as in
  * kernel/sched.c.*/

