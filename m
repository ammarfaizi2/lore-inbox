Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVFWGrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVFWGrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVFWGqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:46:24 -0400
Received: from [24.22.56.4] ([24.22.56.4]:30694 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262345AbVFWGTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:07 -0400
Message-Id: <20050623061758.266524000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:12 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Nishanth Aravamudan <nacc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 20/38] CKRM e18: Clean up typo in printk message
Content-Disposition: inline; filename=ckrm-printf-cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Simple typo, but makes code look incomplete.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Gerrit Huizenga <gh@us.ibm.com>

 ckrm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm.c	2005-06-20 13:08:36.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c	2005-06-20 13:08:49.000000000 -0700
@@ -598,7 +598,7 @@ ckrm_register_res_ctlr(struct ckrm_class
 		 */
 		read_lock(&ckrm_class_lock);
 		list_for_each_entry(core, &clstype->classes, clslist) {
-			printk("CKRM .. create res clsobj for resouce <%s>"
+			printk(KERN_NOTICE "CKRM .. create res clsobj for resource <%s>"
 			       "class <%s> par=%p\n", rcbs->res_name,
 			       core->name, core->hnode.parent);
 			ckrm_alloc_res_class(core, core->hnode.parent, resid);

--
