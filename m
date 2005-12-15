Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVLOOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLOOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVLOOiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:55 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:39834 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750722AbVLOOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:37 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143830.187937000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:06 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 09/21] PID Virtualization: define vpid_to_pid functions
Content-Disposition: inline; filename=F9-define-vpid-to-pid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the reverse conversion functions namely from the 
user virtual pid to the kernel pid.
Again, we only specify the API here, will utilize the API 
at the appropriate locations in subsequent patches and finally
will provide a real implementation for the virtualization
behind these functions together with the pid_to_vpid conversion.
Any pid passed through the syscall interface from userspace
is virtual and therefore must pass through this conversion 
before it can be used as a kernel pid.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/sched.h |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h	2005-11-30 18:08:03.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/sched.h	2005-11-30 18:08:04.000000000 -0500
@@ -879,6 +879,16 @@ static inline pid_t pgid_to_vpgid(pid_t 
 	return pid;
 }
 
+static inline pid_t vpid_to_pid(pid_t pid)
+{
+	return pid;
+}
+
+static inline pid_t vpgid_to_pgid(pid_t pid)
+{
+	return pid;
+}
+
 /**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.

--
