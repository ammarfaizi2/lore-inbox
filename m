Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbUK2McN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUK2McN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUK2MaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:30:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52242 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261701AbUK2M30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:29:26 -0500
Date: Mon, 29 Nov 2004 13:29:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: make some functions static
Message-ID: <20041129122924.GL9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes three needlessly global functions static.


diffstat output:
 drivers/block/nbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/nbd.c.old	2004-11-06 20:09:39.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/nbd.c	2004-11-06 20:10:16.000000000 +0100
@@ -315,7 +315,7 @@
 }
 
 /* NULL returned = something went wrong, inform userspace */
-struct request *nbd_read_stat(struct nbd_device *lo)
+static struct request *nbd_read_stat(struct nbd_device *lo)
 {
 	int result;
 	struct nbd_reply reply;
@@ -377,7 +377,7 @@
 	return NULL;
 }
 
-void nbd_do_it(struct nbd_device *lo)
+static void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
@@ -388,7 +388,7 @@
 	return;
 }
 
-void nbd_clear_que(struct nbd_device *lo)
+static void nbd_clear_que(struct nbd_device *lo)
 {
 	struct request *req;
 

