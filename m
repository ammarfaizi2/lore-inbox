Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936314AbWLDMnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936314AbWLDMnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936439AbWLDMnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:43:09 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:64990 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936316AbWLDMfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:15 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 10/35] fsstack: Make fsstack_copy_attr_all copy inode size
Date: Mon,  4 Dec 2006 07:30:43 -0500
Message-Id: <11652354691241-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

fsstack_copy_attr_all should copy the inode size in addition to all the
other attributes.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---
 fs/stack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 8ffb880..5ddbc34 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -34,5 +34,7 @@ void fsstack_copy_attr_all(struct inode
 	dest->i_ctime = src->i_ctime;
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
+
+	fsstack_copy_inode_size(dest, src);
 }
 EXPORT_SYMBOL_GPL(fsstack_copy_attr_all);
-- 
1.4.3.3

