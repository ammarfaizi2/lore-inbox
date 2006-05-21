Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWEVKYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWEVKYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWEVKYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:24:42 -0400
Received: from thunk.org ([69.25.196.29]:3980 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750721AbWEVKYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:24:41 -0400
To: ext2-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove inconsistent space before exclamation point in ext3's mount code
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Fhx2t-0001nh-G5@candygram.thunk.org>
Date: Sun, 21 May 2006 19:09:11 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove inconsistent space before exclamation point in ext3's mount code

This was reported as Debian bug #336604.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6/fs/ext3/super.c
===================================================================
--- linux-2.6.orig/fs/ext3/super.c	2006-05-21 18:39:27.000000000 -0400
+++ linux-2.6/fs/ext3/super.c	2006-05-21 18:39:40.000000000 -0400
@@ -1595,7 +1595,7 @@
 		}
 	}
 	if (!ext3_check_descriptors (sb)) {
-		printk (KERN_ERR "EXT3-fs: group descriptors corrupted !\n");
+		printk (KERN_ERR "EXT3-fs: group descriptors corrupted!\n");
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
