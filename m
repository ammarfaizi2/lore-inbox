Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWJNPtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWJNPtd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWJNPtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:49:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40584 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422692AbWJNPtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:49:32 -0400
Date: Sat, 14 Oct 2006 16:49:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: swhiteho@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2 endianness bug: be16 assigned to be32 field
Message-ID: <20061014154930.GL29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 459498c..d43caf0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -815,7 +815,7 @@ static struct gfs2_leaf *new_leaf(struct
 	leaf = (struct gfs2_leaf *)bh->b_data;
 	leaf->lf_depth = cpu_to_be16(depth);
 	leaf->lf_entries = 0;
-	leaf->lf_dirent_format = cpu_to_be16(GFS2_FORMAT_DE);
+	leaf->lf_dirent_format = cpu_to_be32(GFS2_FORMAT_DE);
 	leaf->lf_next = 0;
 	memset(leaf->lf_reserved, 0, sizeof(leaf->lf_reserved));
 	dent = (struct gfs2_dirent *)(leaf+1);
-- 
1.4.2.GIT

