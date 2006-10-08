Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWJHIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWJHIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWJHIr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:47:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55710 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750949AbWJHIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:47:56 -0400
Date: Sun, 8 Oct 2006 11:47:54 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, blaisorblade@yahoo.it
Subject: [PATCH] um: fix magic sysrq
Message-ID: <Pine.LNX.4.64.0610081145460.4338@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Fix UML compilation when CONFIG_MAGIC_SYSRQ is enabled.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo "Blaisorblade" Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/um/drivers/mconsole_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6/arch/um/drivers/mconsole_kern.c
===================================================================
--- 2.6.orig/arch/um/drivers/mconsole_kern.c
+++ 2.6/arch/um/drivers/mconsole_kern.c
@@ -675,7 +675,7 @@ static void sysrq_proc(void *arg)
 {
 	char *op = arg;
 
-	handle_sysrq(*op, &current->thread.regs, NULL);
+	handle_sysrq(*op, NULL);
 }
 
 void mconsole_sysrq(struct mc_request *req)
