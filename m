Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWCHMSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWCHMSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWCHMSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:18:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34824 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932540AbWCHMSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:18:43 -0500
Date: Wed, 8 Mar 2006 13:18:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ericvh@gmail.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/9p/: make 2 functions static
Message-ID: <20060308121841.GI4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2006

 fs/9p/vfs_dentry.c |    2 +-
 fs/9p/vfs_inode.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5-mm2-full/fs/9p/vfs_dentry.c.old	2006-03-03 18:05:58.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/fs/9p/vfs_dentry.c	2006-03-03 18:06:14.000000000 +0100
@@ -51,7 +51,7 @@
  *
  */
 
-int v9fs_dentry_delete(struct dentry *dentry)
+static int v9fs_dentry_delete(struct dentry *dentry)
 {
 	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
 	return 1;
--- linux-2.6.16-rc5-mm2-full/fs/9p/vfs_inode.c.old	2006-03-03 18:06:25.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/fs/9p/vfs_inode.c	2006-03-03 18:06:41.000000000 +0100
@@ -350,7 +350,7 @@
 	return ERR_PTR(err);
 }
 
-struct inode *
+static struct inode *
 v9fs_inode_from_fid(struct v9fs_session_info *v9ses, u32 fid,
 	struct super_block *sb)
 {

