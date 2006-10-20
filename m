Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWJTJLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWJTJLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWJTJLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:11:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751693AbWJTJLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:11:30 -0400
Subject: [PATCH 4/8] [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): remove
	dead code
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:36 +0100
Message-Id: <1161335916.27980.187.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From abbdbd2065e74411dc2c401501c2c85a82f60e06 Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 19 Oct 2006 15:12:24 +0200
Subject: [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): remove dead code

The Coverity checker spotted this obviously dead code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index d43caf0..ce52bd9 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -212,8 +212,6 @@ static int gfs2_dir_write_data(struct gf
 		gfs2_trans_add_bh(ip->i_gl, bh, 1);
 		memcpy(bh->b_data + o, buf, amount);
 		brelse(bh);
-		if (error)
-			goto fail;
 
 		buf += amount;
 		copied += amount;
-- 
1.4.1



