Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWEZOYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEZOYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWEZOWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36268 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750801AbWEZOWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:22:04 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 6/10] Remove ``NULL =='' syntax
Message-Id: <E1FjdCG-00033Y-MO@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ``NULL =='' syntax; easier on the eyes.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |    2 +-
 fs/ecryptfs/main.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

c6a4cc09586f339bd97330efcd388c92100a6780
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index ef7d7fa..0284e16 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -371,7 +371,7 @@ ecryptfs_fsync(struct file *file, struct
 	struct file *lower_file = NULL;
 	struct dentry *lower_dentry;
 
-	if (NULL == file) {
+	if (!file) {
 		lower_dentry = ecryptfs_dentry_to_lower(dentry);
 		if (lower_dentry->d_inode->i_fop
 		    && lower_dentry->d_inode->i_fop->fsync) {
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9376482..5cbc948 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -98,7 +98,7 @@ int ecryptfs_interpose(struct dentry *lo
 		rc = -ENOMEM;
 		goto out;
 	}
-	if (NULL == ecryptfs_inode_to_lower(inode))
+	if (!ecryptfs_inode_to_lower(inode))
 		ecryptfs_set_inode_lower(inode, igrab(lower_inode));
 	if (S_ISLNK(lower_inode->i_mode))
 		inode->i_op = &ecryptfs_symlink_iops;
-- 
1.3.3

