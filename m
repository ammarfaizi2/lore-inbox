Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWAQOub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWAQOub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAQOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:30 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:42181 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750996AbWAQOua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143326.452219000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:12 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 14/34] PID Virtualization const parameter for process group
Content-Disposition: inline; filename=F1-const-task-parameter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change parameter in access functions to const.
We try to be more diligent with the "const" attribute.
As a result not introducing const for this function will
result in many compiler warnings.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 sched.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
@@ -859,7 +859,7 @@
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 };
 
-static inline pid_t process_group(struct task_struct *tsk)
+static inline pid_t process_group(const struct task_struct *tsk)
 {
 	return tsk->signal->pgrp;
 }

--

