Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVKDMpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVKDMpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVKDMpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:45:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62474 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932730AbVKDMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:45:11 -0500
Date: Fri, 4 Nov 2005 13:45:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mark.gross@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/char/tlclk.c: make two functions static
Message-ID: <20051104124507.GD5587@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 char/tlclk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/char/tlclk.c.old	2005-11-04 11:18:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/char/tlclk.c	2005-11-04 11:19:21.000000000 +0100
@@ -225,8 +225,8 @@
 	return 0;
 }
 
-ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
-		loff_t *f_pos)
+static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
+			  loff_t *f_pos)
 {
 	if (count < sizeof(struct tlclk_alarms))
 		return -EIO;
@@ -241,8 +241,8 @@
 	return  sizeof(struct tlclk_alarms);
 }
 
-ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
-	    loff_t *f_pos)
+static ssize_t tlclk_write(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *f_pos)
 {
 	return 0;
 }

