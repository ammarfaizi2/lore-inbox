Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVEES3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVEES3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVEES3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:29:14 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:40593 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S261298AbVEES3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:09 -0400
Message-Id: <20050505180936.044586000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:51 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 20/21] CKRM: Clean up typo in printk message
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=ckrm-printf-cleanup


Description: Simple typo, but makes code look incomplete.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Gerrit Huizenga <gh@us.ibm.com>

 ckrm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/kernel/ckrm/ckrm.c	2005-05-05 09:35:14.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm.c	2005-05-05 09:43:47.000000000 -0700
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

