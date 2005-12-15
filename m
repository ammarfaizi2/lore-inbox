Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVLOOhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVLOOhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVLOOhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:37:53 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:22426 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750710AbVLOOhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:37:53 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143745.535443000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:35:58 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 01/21] PID Virtualization: const parameter for process group
Content-Disposition: inline; filename=F1-const-task-parameter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change parameter in access functions to const.
We try to be more diligent with the "const" attribute.
As a result not introducing const for this function will
result in many compiler warnings.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/sched.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h	2005-11-30 18:07:18.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/sched.h	2005-11-30 18:08:02.000000000 -0500
@@ -860,7 +860,7 @@ struct task_struct {
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 };
 
-static inline pid_t process_group(struct task_struct *tsk)
+static inline pid_t process_group(const struct task_struct *tsk)
 {
 	return tsk->signal->pgrp;
 }

--
