Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWJTJLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWJTJLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWJTJLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:11:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22158 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751693AbWJTJLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:11:32 -0400
Subject: [PATCH 5/8] [GFS2] fs/gfs2/ops_fstype.c:gfs2_get_sb_meta(): remove
	unused variable
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:41 +0100
Message-Id: <1161335921.27980.189.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b0cb66955f4bf7a72b544096ceef48a829361a3c Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 19 Oct 2006 15:13:26 +0200
Subject: [GFS2] fs/gfs2/ops_fstype.c:gfs2_get_sb_meta(): remove unused variable

The Coverity checker spotted this unused variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_fstype.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 178b339..e99444d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
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
 
-- 
1.4.1



