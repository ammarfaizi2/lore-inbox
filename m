Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968648AbWLETVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968648AbWLETVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968650AbWLETVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:21:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54703 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968648AbWLETVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:21:30 -0500
Date: Tue, 5 Dec 2006 14:21:23 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fsstack: Make fsstack_copy_attr_all copy inode size
Message-ID: <20061205192122.GC2240@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

