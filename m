Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933874AbWKTCZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874AbWKTCZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933876AbWKTCY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933886AbWKTCYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:23 -0500
Date: Mon, 20 Nov 2006 03:24:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make fs/proc/base.c:proc_pid_instantiate() static
Message-ID: <20061120022422.GQ31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global proc_pid_instantiate() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/proc/base.c.old	2006-11-20 02:08:33.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/proc/base.c	2006-11-20 02:08:47.000000000 +0100
@@ -1946,8 +1946,9 @@
 	return;
 }
 
-struct dentry *proc_pid_instantiate(struct inode *dir,
-	struct dentry * dentry, struct task_struct *task, void *ptr)
+static struct dentry *proc_pid_instantiate(struct inode *dir,
+					   struct dentry * dentry,
+					   struct task_struct *task, void *ptr)
 {
 	struct dentry *error = ERR_PTR(-ENOENT);
 	struct inode *inode;

