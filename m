Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVD3UOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVD3UOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVD3UNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:13:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9487 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261406AbVD3UIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:08:24 -0400
Date: Sat, 30 Apr 2005 22:08:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/stallion.c: make a function static
Message-ID: <20050430200822.GS3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/char/stallion.c.old	2005-04-17 18:27:46.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/stallion.c	2005-04-17 18:28:03.000000000 +0200
@@ -466,7 +466,7 @@
 
 static unsigned long stl_atol(char *str);
 
-int		stl_init(void);
+static int	stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
 static void	stl_close(struct tty_struct *tty, struct file *filp);
 static int	stl_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -3063,7 +3063,7 @@
 
 /*****************************************************************************/
 
-int __init stl_init(void)
+static int __init stl_init(void)
 {
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);

