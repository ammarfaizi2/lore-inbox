Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVAYLap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVAYLap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVAYL3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:29:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261904AbVAYL2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:28:05 -0500
Date: Tue, 25 Jan 2005 12:28:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: make 3 functions static
Message-ID: <20050125112802.GH30909@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/nbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This patch was already sent on:
- 29 Nov 2004

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
 

