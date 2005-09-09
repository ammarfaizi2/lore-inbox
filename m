Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVIITh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVIITh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVIITgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:36:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61864 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030341AbVIITgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:36:44 -0400
Date: Fri, 9 Sep 2005 20:36:43 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] trivial __user annotations (md)
Message-ID: <20050909193643.GY9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/md/md.c current/drivers/md/md.c
--- RC13-git8-base/drivers/md/md.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/md/md.c	2005-09-08 23:53:33.000000000 -0400
@@ -2087,7 +2087,7 @@
 	return 0;
 }
 
-static int get_bitmap_file(mddev_t * mddev, void * arg)
+static int get_bitmap_file(mddev_t * mddev, void __user * arg)
 {
 	mdu_bitmap_file_t *file = NULL; /* too big for stack allocation */
 	char *ptr, *buf = NULL;
@@ -2781,7 +2781,7 @@
 			goto done_unlock;
 
 		case GET_BITMAP_FILE:
-			err = get_bitmap_file(mddev, (void *)arg);
+			err = get_bitmap_file(mddev, argp);
 			goto done_unlock;
 
 		case GET_DISK_INFO:
