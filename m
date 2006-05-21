Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWEVKZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWEVKZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVKZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:25:12 -0400
Received: from thunk.org ([69.25.196.29]:5516 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750722AbWEVKYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:24:43 -0400
To: ext2-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup dead code from ext2 mount code
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Fhx1R-0001io-Fx@candygram.thunk.org>
Date: Sun, 21 May 2006 19:07:41 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The variable i is guaranteed to be the same as db_count given the
previous for loop.  So get rid of it since it's dead code.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6/fs/ext2/super.c
===================================================================
--- linux-2.6.orig/fs/ext2/super.c	2006-05-21 18:39:27.000000000 -0400
+++ linux-2.6/fs/ext2/super.c	2006-05-21 18:39:29.000000000 -0400
@@ -857,7 +857,6 @@
 	}
 	if (!ext2_check_descriptors (sb)) {
 		printk ("EXT2-fs: group descriptors corrupted!\n");
-		db_count = i;
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
