Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVHHWbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVHHWbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVHHWbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:17 -0400
Received: from coderock.org ([193.77.147.115]:41603 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932301AbVHHWbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:13 -0400
Message-Id: <20050808223057.119463000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:51 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 15/16] reiserfs: super.c - vfree() checking cleanups
Content-Disposition: inline; filename=vfree-fs_reiserfs_super.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jlamanna@gmail.com



super.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 super.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/fs/reiserfs/super.c
===================================================================
--- quilt.orig/fs/reiserfs/super.c
+++ quilt/fs/reiserfs/super.c
@@ -1934,8 +1934,7 @@ static int reiserfs_fill_super(struct su
 			if (SB_AP_BITMAP(s))
 				brelse(SB_AP_BITMAP(s)[j].bh);
 		}
-		if (SB_AP_BITMAP(s))
-			vfree(SB_AP_BITMAP(s));
+		vfree(SB_AP_BITMAP(s));
 	}
 	if (SB_BUFFER_WITH_SB(s))
 		brelse(SB_BUFFER_WITH_SB(s));

--
