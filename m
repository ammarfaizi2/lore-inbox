Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWEIPdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWEIPdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWEIPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:33:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64204 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751474AbWEIPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:33:50 -0400
Date: Tue, 9 May 2006 10:33:49 -0500
From: Cliff Wickman <cpw@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fs/freevxfs  cleanup of spelling errors
Message-ID: <20060509153349.GA12336@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix of some trivial spelling errors in fs/freevxfs error messages and comments

Diffed against 2.6.17-rc3

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---

---
 fs/freevxfs/vxfs.h        |    4 ++--
 fs/freevxfs/vxfs_fshead.c |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: linus.060509/fs/freevxfs/vxfs.h
===================================================================
--- linus.060509.orig/fs/freevxfs/vxfs.h
+++ linus.060509/fs/freevxfs/vxfs.h
@@ -159,11 +159,11 @@ struct vxfs_sb {
  * In core superblock filesystem private data for VxFS.
  */
 struct vxfs_sb_info {
-	struct vxfs_sb		*vsi_raw;	/* raw (on disk) supeblock */
+	struct vxfs_sb		*vsi_raw;	/* raw (on disk) superblock */
 	struct buffer_head	*vsi_bp;	/* buffer for raw superblock*/
 	struct inode		*vsi_fship;	/* fileset header inode */
 	struct inode		*vsi_ilist;	/* inode list inode */
-	struct inode		*vsi_stilist;	/* structual inode list inode */
+	struct inode		*vsi_stilist;	/* structural inode list inode */
 	u_long			vsi_iext;	/* initial inode list */
 	ino_t			vsi_fshino;	/* fileset header inode */
 	daddr_t			vsi_oltext;	/* OLT extent */
Index: linus.060509/fs/freevxfs/vxfs_fshead.c
===================================================================
--- linus.060509.orig/fs/freevxfs/vxfs_fshead.c
+++ linus.060509/fs/freevxfs/vxfs_fshead.c
@@ -112,7 +112,7 @@ vxfs_read_fshead(struct super_block *sbp
 
 	vip = vxfs_blkiget(sbp, infp->vsi_iext, infp->vsi_fshino);
 	if (!vip) {
-		printk(KERN_ERR "vxfs: unabled to read fsh inode\n");
+		printk(KERN_ERR "vxfs: unable to read fsh inode\n");
 		return -EINVAL;
 	}
 	if (!VXFS_ISFSH(vip)) {
@@ -129,13 +129,13 @@ vxfs_read_fshead(struct super_block *sbp
 
 	infp->vsi_fship = vxfs_get_fake_inode(sbp, vip);
 	if (!infp->vsi_fship) {
-		printk(KERN_ERR "vxfs: unabled to get fsh inode\n");
+		printk(KERN_ERR "vxfs: unable to get fsh inode\n");
 		goto out_free_fship;
 	}
 
 	sfp = vxfs_getfsh(infp->vsi_fship, 0);
 	if (!sfp) {
-		printk(KERN_ERR "vxfs: unabled to get structural fsh\n");
+		printk(KERN_ERR "vxfs: unable to get structural fsh\n");
 		goto out_iput_fship;
 	} 
 
@@ -145,7 +145,7 @@ vxfs_read_fshead(struct super_block *sbp
 
 	pfp = vxfs_getfsh(infp->vsi_fship, 1);
 	if (!pfp) {
-		printk(KERN_ERR "vxfs: unabled to get primary fsh\n");
+		printk(KERN_ERR "vxfs: unable to get primary fsh\n");
 		goto out_free_sfp;
 	}
 
@@ -159,7 +159,7 @@ vxfs_read_fshead(struct super_block *sbp
 
 	infp->vsi_stilist = vxfs_get_fake_inode(sbp, tip);
 	if (!infp->vsi_stilist) {
-		printk(KERN_ERR "vxfs: unabled to get structual list inode\n");
+		printk(KERN_ERR "vxfs: unable to get structural list inode\n");
 		kfree(tip);
 		goto out_free_pfp;
 	}
@@ -174,7 +174,7 @@ vxfs_read_fshead(struct super_block *sbp
 		goto out_iput_stilist;
 	infp->vsi_ilist = vxfs_get_fake_inode(sbp, tip);
 	if (!infp->vsi_ilist) {
-		printk(KERN_ERR "vxfs: unabled to get inode list inode\n");
+		printk(KERN_ERR "vxfs: unable to get inode list inode\n");
 		kfree(tip);
 		goto out_iput_stilist;
 	}
