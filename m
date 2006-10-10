Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWJJVyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWJJVyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWJJVyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:54:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34235 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030528AbWJJVss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] fs/inode.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPSx-0007RB-F3@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bf6bec4..d9a21d1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -162,7 +162,7 @@ #endif
 				bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 			mapping->backing_dev_info = bdi;
 		}
-		inode->i_private = 0;
+		inode->i_private = NULL;
 		inode->i_mapping = mapping;
 	}
 	return inode;
-- 
1.4.2.GIT


