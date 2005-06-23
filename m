Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVFWH6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVFWH6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVFWH4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:56:33 -0400
Received: from [24.22.56.4] ([24.22.56.4]:12518 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262252AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061800.521157000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:23 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 31/38] CKRM e18: Fix a bug in the use of classtype
Content-Disposition: inline; filename=ckrm-rbce_class_del_crash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug using classtype

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_core.c	2005-06-20 15:04:53.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c	2005-06-20 15:37:50.000000000 -0700
@@ -60,7 +60,7 @@ rbce_class_deletecb(const char *classnam
 #endif
 		notify_class_action(cls, 0);
 		cls->classobj = NULL;
-		list_for_each_entry(pos, &rules_list[cls->classtype], link) {
+		list_for_each_entry(pos, &rules_list[classtype], link) {
 			rule = (struct rbce_rule *)pos;
 			if (rule->target_class) {
 				if (!strcmp

--
