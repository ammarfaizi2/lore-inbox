Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWIJECX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWIJECX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIJECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:02:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63907 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965211AbWIJEBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:01:55 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/4] proc: Comment what proc_fill_cache does.
Date: Sat,  9 Sep 2006 22:01:05 -0600
Message-Id: <1157860865556-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
References: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 433a01d..a317eb2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1057,6 +1057,18 @@ static struct dentry_operations pid_dent
 
 typedef struct dentry *instantiate_t(struct inode *, struct dentry *, struct task_struct *, void *);
 
+/*
+ * Fill a directory entry.
+ *
+ * If possible create the dcache entry and derive our inode number and
+ * file type from dcache entry.
+ *
+ * Since all of the proc inode numbers are dynamically generated, the inode
+ * numbers do not exist until the inode is cache.  This means creating the
+ * the dcache entry in readdir is necessary to keep the inode numbers
+ * reported by readdir in sync with the inode numbers reported
+ * by stat.
+ */
 static int proc_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
 	char *name, int len,
 	instantiate_t instantiate, struct task_struct *task, void *ptr)
-- 
1.4.2.rc3.g7e18e-dirty

