Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVAPIDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVAPIDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVAPIDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:03:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17679 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262450AbVAPIBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:01:54 -0500
Date: Sun, 16 Jan 2005 09:01:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/fuse/dev.c: make two functions static
Message-ID: <20050116080151.GC4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/fs/fuse/dev.c.old	2005-01-16 05:56:22.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/fs/fuse/dev.c	2005-01-16 05:56:35.000000000 +0100
@@ -119,7 +119,7 @@
 	return intr ? NULL : do_get_request(fc);
 }
 
-void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
+static void fuse_putback_request(struct fuse_conn *fc, struct fuse_req *req)
 {
 	if (!req->preallocated)
 		fuse_request_free(req);
@@ -293,7 +293,7 @@
 	request_send_wait(fc, req, 0);
 }
 
-void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
+static void request_send_nowait(struct fuse_conn *fc, struct fuse_req *req)
 {
 	spin_lock(&fuse_lock);
 	if (fc->file) {

