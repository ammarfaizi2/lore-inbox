Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVA2NgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVA2NgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVA2NgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:36:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65291 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262908AbVA2NfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:35:25 -0500
Date: Sat, 29 Jan 2005 14:35:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sam Hopkins <sah@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/aoe/aoechr.c cleanups
Message-ID: <20050129133520.GV28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make the needlessly global struct aoe_fops static
- #if 0 the unused global function aoechr_hdump

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/aoe/aoechr.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.11-rc2-mm1-full/drivers/block/aoe/aoechr.c.old	2005-01-29 13:43:34.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/aoe/aoechr.c	2005-01-29 13:44:16.000000000 +0100
@@ -99,6 +99,8 @@
 		up(&emsgs_sema);
 }
 
+#if 0
+
 #define PERLINE 16
 void
 aoechr_hdump(char *buf, int n)
@@ -134,6 +136,8 @@
 	kfree(fbuf);
 }
 
+#endif  /*  0  */
+
 static ssize_t
 aoechr_write(struct file *filp, const char __user *buf, size_t cnt, loff_t *offp)
 {
@@ -233,7 +237,7 @@
 	}
 }
 
-struct file_operations aoe_fops = {
+static struct file_operations aoe_fops = {
 	.write = aoechr_write,
 	.read = aoechr_read,
 	.open = aoechr_open,

