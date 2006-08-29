Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWH2SLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWH2SLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWH2SLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:11:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965203AbWH2SGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:06 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/19] BLOCK: Don't call block_sync_page() from AFS [try #6]
Date: Tue, 29 Aug 2006 19:06:03 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180603.32596.21225.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The AFS filesystem no longer needs to override its sync_page() op.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 67d6634..0226456 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -37,7 +37,6 @@ struct inode_operations afs_file_inode_o
 
 const struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
-	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
