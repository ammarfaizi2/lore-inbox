Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWD0SAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWD0SAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWD0SAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:00:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965018AbWD0SAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:00:17 -0400
Date: Thu, 27 Apr 2006 20:00:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Manoj Naik <manoj@almaden.ibm.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/nfs/inode.c: make nfs_follow_referral()
Message-ID: <20060427180015.GI3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 01:41:41AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm3:
>...
>  git-nfs.patch
>...
>  git trees
>...


This patch makes the needlessly global nfs_follow_referral() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc2-mm1-full/fs/nfs/inode.c.old	2006-04-27 19:45:08.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/fs/nfs/inode.c	2006-04-27 19:45:26.000000000 +0200
@@ -2677,8 +2677,9 @@
  * @addr - host addr of new server
  *
  */
-struct vfsmount *nfs_follow_referral(const struct vfsmount *mnt_parent,
-	     const struct dentry *dentry, struct nfs4_fs_locations *locations)
+static struct vfsmount *nfs_follow_referral(const struct vfsmount *mnt_parent,
+					    const struct dentry *dentry,
+					    struct nfs4_fs_locations *locations)
 {
 	struct vfsmount *mnt = ERR_PTR(-ENOENT);
 	struct nfs_clone_mount mountdata = {

