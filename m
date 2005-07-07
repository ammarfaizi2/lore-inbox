Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVGGVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVGGVkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVGGVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:56 -0400
Received: from coderock.org ([193.77.147.115]:43916 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261781AbVGGVby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:31:54 -0400
Message-Id: <20050707213123.330139000@homer>
Date: Thu, 07 Jul 2005 23:31:23 +0200
From: domen@coderock.org
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, Alejandro Andres <fuzzy.alej@gmail.com>,
       domen@coderock.org
Subject: [patch 1/1] kernel/module.c use __set_current_state() instead of direct assigment
Content-Disposition: inline; filename=set_current_state-kernel_module.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: aLeJ <fuzzy.alej@gmail.com>


Use of __set_current_state() instead of direct assigment of
current->state.

Signed-off-by: Alejandro Andres <fuzzy.alej@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 module.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/kernel/module.c
===================================================================
--- quilt.orig/kernel/module.c
+++ quilt/kernel/module.c
@@ -556,7 +556,7 @@ static void wait_for_zero_refcount(struc
 			break;
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 	down(&module_mutex);
 }
 

--
