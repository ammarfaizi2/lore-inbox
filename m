Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbULVLwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbULVLwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbULVLwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:52:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62993 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261971AbULVLuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:21 -0500
Date: Wed, 22 Dec 2004 12:50:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/n_tty.: make two functions static (fwd)
Message-ID: <20041222115018.GR5217@stusta.de>
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

Date:	Sun, 5 Dec 2004 18:08:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/n_tty.: make two functions static

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/char/n_tty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/n_tty.c.old	2004-11-07 00:33:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/n_tty.c	2004-11-07 00:34:05.000000000 +0100
@@ -152,7 +152,7 @@
  *	lock_kernel() still.
  */
  
-void n_tty_flush_buffer(struct tty_struct * tty)
+static void n_tty_flush_buffer(struct tty_struct * tty)
 {
 	/* clear everything and unthrottle the driver */
 	reset_buffer_flags(tty);
@@ -174,7 +174,7 @@
  *	at this instant in time. 
  */
  
-ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
+static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
 	ssize_t n = 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

