Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVAPK7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVAPK7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAPK7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:59:13 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:33941 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262471AbVAPK7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:59:09 -0500
To: akpm@osdl.org
CC: bunk@stusta.de, linux-kernel@vger.kernel.org
In-reply-to: <20050116080151.GC4274@stusta.de> (message from Adrian Bunk on
	Sun, 16 Jan 2005 09:01:51 +0100)
Subject: Re: [-mm patch] fs/fuse/dev.c: make two functions static
References: <20050116080151.GC4274@stusta.de>
Message-Id: <E1Cq84J-0004lL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 16 Jan 2005 11:55:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Adrian,

The patch below makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

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

