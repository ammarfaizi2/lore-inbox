Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbULWAhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbULWAhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbULWAhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:37:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262095AbULWAhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:07 -0500
Date: Thu, 23 Dec 2004 01:37:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/pty.c: make a struct static (fwd)
Message-ID: <20041223003704.GC5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 18:12:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/pty.c: make a struct static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

