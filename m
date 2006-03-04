Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWCDMOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWCDMOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWCDMOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751827AbWCDMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:34 -0500
Date: Sat, 4 Mar 2006 13:14:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/9p/: make 2 functions static
Message-ID: <20060304121434.GO9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

