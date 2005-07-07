Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVGGV6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVGGV6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVGGVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:41 -0400
Received: from coderock.org ([193.77.147.115]:48780 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262331AbVGGVcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:32:12 -0400
Message-Id: <20050707213139.416004000@homer>
Date: Thu, 07 Jul 2005 23:31:39 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 2/4] kernel/audit.c: fix sparse warnings (__nocast type)
Content-Disposition: inline; filename=sparse-kernel_audit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: kernel/audit.c

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 audit.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/kernel/audit.c
===================================================================
--- quilt.orig/kernel/audit.c
+++ quilt/kernel/audit.c
@@ -560,7 +560,7 @@ static void audit_buffer_free(struct aud
 }
 
 static struct audit_buffer * audit_buffer_alloc(struct audit_context *ctx,
-						int gfp_mask, int type)
+						unsigned int __nocast gfp_mask, int type)
 {
 	unsigned long flags;
 	struct audit_buffer *ab = NULL;

--
