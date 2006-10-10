Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030618AbWJJWiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbWJJWiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWJJWio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61058 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWJJWiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:16 -0400
To: torvalds@osdl.org
Subject: [PATCH 9/16] fs/fat endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEp-0008WD-Se@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:31:04 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fat/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 0457380..4613cb2 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -384,7 +384,7 @@ static int fat_fill_inode(struct inode *
 				      le16_to_cpu(de->cdate)) + secs;
 		inode->i_ctime.tv_nsec = csecs * 10000000;
 		inode->i_atime.tv_sec =
-			date_dos2unix(le16_to_cpu(0), le16_to_cpu(de->adate));
+			date_dos2unix(0, le16_to_cpu(de->adate));
 		inode->i_atime.tv_nsec = 0;
 	} else
 		inode->i_ctime = inode->i_atime = inode->i_mtime;
-- 
1.4.2.GIT


