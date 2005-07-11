Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVGKBZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVGKBZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGKBZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:25:25 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:22249 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262178AbVGKBYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:24:17 -0400
Date: Sun, 10 Jul 2005 18:21:23 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel/capability.c: add kerneldoc
Message-Id: <20050710182123.426b4c7b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kerneldoc to kernel/capability.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 kernel/capability.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff -Naurp linux-2613-rc2/kernel/capability.c~kdoc_kernel_caps linux-2613-rc2/kernel/capability.c
--- linux-2613-rc2/kernel/capability.c~kdoc_kernel_caps	2005-06-17 12:48:29.000000000 -0700
+++ linux-2613-rc2/kernel/capability.c	2005-07-09 23:04:20.000000000 -0700
@@ -31,8 +31,14 @@ static DEFINE_SPINLOCK(task_capability_l
  * uninteresting and/or not to be changed.
  */
 
-/*
+/**
  * sys_capget - get the capabilities of a given process.
+ * @header: pointer to struct that contains capability version and
+ *	target pid data
+ * @dataptr: pointer to struct that contains the effective, permitted,
+ *	and inheritable capabilities that are returned
+ *
+ * Returns 0 on success and < 0 on error.
  */
 asmlinkage long sys_capget(cap_user_header_t header, cap_user_data_t dataptr)
 {
@@ -141,8 +147,14 @@ static inline int cap_set_all(kernel_cap
      return ret;
 }
 
-/*
- * sys_capset - set capabilities for a given process, all processes, or all
+/**
+ * sys_capset - set capabilities for a process or a group of processes
+ * @header: pointer to struct that contains capability version and
+ *	target pid data
+ * @data: pointer to struct that contains the effective, permitted,
+ *	and inheritable capabilities
+ *
+ * Set capabilities for a given process, all processes, or all
  * processes in a given process group.
  *
  * The restrictions on setting capabilities are specified as:
@@ -152,6 +164,8 @@ static inline int cap_set_all(kernel_cap
  * I: any raised capabilities must be a subset of the (old current) permitted
  * P: any raised capabilities must be a subset of the (old current) permitted
  * E: must be set to a subset of (new target) permitted
+ *
+ * Returns 0 on success and < 0 on error.
  */
 asmlinkage long sys_capset(cap_user_header_t header, const cap_user_data_t data)
 {


---
