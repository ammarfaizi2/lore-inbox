Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbULERR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbULERR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbULERNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:13:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20235 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261351AbULERMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:12:05 -0500
Date: Sun, 5 Dec 2004 18:12:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/pty.c: make a struct static
Message-ID: <20041205171203.GX2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


diffstat output:
 drivers/char/pty.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/pty.c.old	2004-11-07 00:39:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/pty.c	2004-11-07 00:39:53.000000000 +0100
@@ -35,7 +35,7 @@
 /* These are global because they are accessed in tty_io.c */
 #ifdef CONFIG_UNIX98_PTYS
 struct tty_driver *ptm_driver;
-struct tty_driver *pts_driver;
+static struct tty_driver *pts_driver;
 #endif
 
 static void pty_close(struct tty_struct * tty, struct file * filp)

