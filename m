Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936261AbWK3MM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936261AbWK3MM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936267AbWK3MM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:12:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936261AbWK3MMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:12:22 -0500
Subject: [GFS2] fields of gfs2_sb_host are host-endian [4/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:07 +0000
Message-Id: <1164888787.3752.310.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From bc558c87bb7e50c4f728d32684a9f4f4c73ebde3 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 21:02:41 -0400
Subject: [PATCH] [GFS2] fields of gfs2_sb_host are host-endian

... and several could be killed, but that's another story.
Annotate scalar ones, kill completely unused.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 include/linux/gfs2_ondisk.h |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index b7bdfef..a5d36cd 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -131,16 +131,13 @@ struct gfs2_sb {
 struct gfs2_sb_host {
 	struct gfs2_meta_header sb_header;
 
-	__be32 sb_fs_format;
-	__be32 sb_multihost_format;
-	__u32  __pad0;	/* Was superblock flags in gfs1 */
+	__u32 sb_fs_format;
+	__u32 sb_multihost_format;
 
-	__be32 sb_bsize;
-	__be32 sb_bsize_shift;
-	__u32 __pad1;	/* Was journal segment size in gfs1 */
+	__u32 sb_bsize;
+	__u32 sb_bsize_shift;
 
 	struct gfs2_inum sb_master_dir; /* Was jindex dinode in gfs1 */
-	struct gfs2_inum __pad2; /* Was rindex dinode in gfs1 */
 	struct gfs2_inum sb_root_dir;
 
 	char sb_lockproto[GFS2_LOCKNAME_LEN];
-- 
1.4.1



