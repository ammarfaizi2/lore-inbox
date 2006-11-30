Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936269AbWK3MOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936269AbWK3MOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936276AbWK3MOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:14:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936278AbWK3MOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:14:40 -0500
Subject: [GFS2] gfs2 __user misannotation fix [16/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:20 +0000
Message-Id: <1164888920.3752.336.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9c9ab3d5414653bfe5e5b9f4dfdaab0c6ab17196 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 23:49:23 -0400
Subject: [PATCH] [GFS2] gfs2 __user misannotation fix

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index 359965c..2fc8868 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -71,7 +71,7 @@ static int gfs2_read_actor(read_descript
 		size = count;
 
 	kaddr = kmap(page);
-	memcpy(desc->arg.buf, kaddr + offset, size);
+	memcpy(desc->arg.data, kaddr + offset, size);
 	kunmap(page);
 
 	desc->count = count - size;
@@ -86,7 +86,7 @@ int gfs2_internal_read(struct gfs2_inode
 	struct inode *inode = &ip->i_inode;
 	read_descriptor_t desc;
 	desc.written = 0;
-	desc.arg.buf = buf;
+	desc.arg.data = buf;
 	desc.count = size;
 	desc.error = 0;
 	do_generic_mapping_read(inode->i_mapping, ra_state,
-- 
1.4.1



