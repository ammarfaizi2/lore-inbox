Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWIJEBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWIJEBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIJEBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:01:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62883 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965209AbWIJEBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:01:54 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/4] proc: Remove the useless SMP-safe comments from /proc
Date: Sat,  9 Sep 2006 22:01:04 -0600
Message-Id: <11578608653969-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
References: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 725e279..433a01d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1247,7 +1247,6 @@ out_iput:
 	goto out;
 }
 
-/* SMP-safe */
 static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct task_struct *task = get_proc_task(dir);
@@ -1374,7 +1373,6 @@ out:
 	return error;
 }
 
-/* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
 					 struct pid_entry *ents,
@@ -1899,7 +1897,6 @@ out:
 	return error;
 }
 
-/* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct dentry *result = ERR_PTR(-ENOENT);
@@ -2106,7 +2103,6 @@ out:
 	return error;
 }
 
-/* SMP-safe */
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct dentry *result = ERR_PTR(-ENOENT);
-- 
1.4.2.rc3.g7e18e-dirty

