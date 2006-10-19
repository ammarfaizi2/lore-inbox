Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWJSNNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWJSNNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWJSNNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:13:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65032 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751605AbWJSNNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:13:30 -0400
Date: Thu, 19 Oct 2006 15:13:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: swhiteho@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/gfs2/ops_fstype.c:gfs2_get_sb_meta(): remove unused variable
Message-ID: <20061019131326.GM3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this unused variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/gfs2/ops_fstype.c.old	2006-10-19 01:02:37.000000000 +0200
+++ linux-2.6/fs/gfs2/ops_fstype.c	2006-10-19 01:03:05.000000000 +0200
@@ -854,7 +854,6 @@ static int gfs2_get_sb_meta(struct file_
 	int error = 0;
 	struct super_block *sb = NULL, *new;
 	struct gfs2_sbd *sdp;
-	char *gfs2mnt = NULL;
 
 	sb = get_gfs2_sb(dev_name);
 	if (!sb) {
@@ -892,8 +891,6 @@ static int gfs2_get_sb_meta(struct file_
 	atomic_inc(&sdp->sd_gfs2mnt->mnt_count);
 	return simple_set_mnt(mnt, new);
 error:
-	if (gfs2mnt)
-		kfree(gfs2mnt);
 	return error;
 }
 

