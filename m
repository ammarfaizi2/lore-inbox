Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVGGWIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVGGWIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGGVde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:34 -0400
Received: from coderock.org ([193.77.147.115]:48524 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262321AbVGGVcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:32:12 -0400
Message-Id: <20050707213140.750151000@homer>
Date: Thu, 07 Jul 2005 23:31:40 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 3/4] char/n_tty: fix sparse warnings (__nocast type)
Content-Disposition: inline; filename=sparse-drivers_char_n_tty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/char/n_tty.c

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 n_tty.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/char/n_tty.c
===================================================================
--- quilt.orig/drivers/char/n_tty.c
+++ quilt/drivers/char/n_tty.c
@@ -62,7 +62,7 @@
 
 static inline unsigned char *alloc_buf(void)
 {
-	int prio = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
+	unsigned int prio = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
 
 	if (PAGE_SIZE != N_TTY_BUF_SIZE)
 		return kmalloc(N_TTY_BUF_SIZE, prio);

--
