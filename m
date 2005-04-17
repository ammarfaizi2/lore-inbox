Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVDQUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVDQUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVDQUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:23:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24083 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261483AbVDQUT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:19:56 -0400
Date: Sun, 17 Apr 2005 22:19:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/stallion.c: make a function static
Message-ID: <20050417201952.GR3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

