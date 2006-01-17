Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWAQOu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWAQOu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWAQOuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:30178 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751116AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143327.312822000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:17 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 19/34] PID Virtualization Define pid_to_vpid functions
Content-Disposition: inline; filename=F6-define-pid-to-vpid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch we introduce convertion functions to 
translate pids into virtual pids. These are just the APIs
not the implementation yet.
Subsequent patches will utilize these internal functions
to rewrite the task virtual pid/ppid/tgid access functions
such that finally we only have to rewrite these virtual
conversion functions to actually obtain the pid virtualization.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 sched.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:05.000000000 -0500
@@ -865,6 +865,20 @@
 }
 
 /**
+ *  pid domain translation functions:
+ *	- from kernel to user pid domain
+ */
+static inline pid_t pid_to_vpid(pid_t pid)
+{
+	return pid;
+}
+
+static inline pid_t pgid_to_vpgid(pid_t pid)
+{
+	return pid;
+}
+
+/**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.
  *

--

