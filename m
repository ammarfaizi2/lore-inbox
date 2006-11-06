Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWKFLFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWKFLFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKFLFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:05:31 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:50098 "EHLO fogou.chygwyn.com")
	by vger.kernel.org with ESMTP id S1751471AbWKFLFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:05:30 -0500
Subject: [GFS2] don't panic needlessly [1/5]
From: Steven Whitehouse <steve@chygwyn.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 06 Nov 2006 11:07:51 +0000
Message-Id: <1162811271.18219.31.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >From eb1dc33aa235b0e44ada6716cda385883c6e6bff Mon Sep
	17 00:00:00 2001 From: Alexey Dobriyan <adobriyan@gmail.com> Date: Sat,
	28 Oct 2006 03:03:48 +0400 Subject: [PATCH] [GFS2] don't panic
	needlessly [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From eb1dc33aa235b0e44ada6716cda385883c6e6bff Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 28 Oct 2006 03:03:48 +0400
Subject: [PATCH] [GFS2] don't panic needlessly

First, SLAB_PANIC is unjustified. Second, all error propagating and backing out
is in place.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 21508a1..9889c1e 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -84,8 +84,8 @@ static int __init init_gfs2_fs(void)
 
 	gfs2_inode_cachep = kmem_cache_create("gfs2_inode",
 					      sizeof(struct gfs2_inode),
-					      0, (SLAB_RECLAIM_ACCOUNT|
-					      SLAB_PANIC|SLAB_MEM_SPREAD),
+					      0,  SLAB_RECLAIM_ACCOUNT|
+					          SLAB_MEM_SPREAD,
 					      gfs2_init_inode_once, NULL);
 	if (!gfs2_inode_cachep)
 		goto fail;
-- 
1.4.1



