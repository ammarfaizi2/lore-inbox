Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbULERJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbULERJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbULERJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:09:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261347AbULERID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:08:03 -0500
Date: Sun, 5 Dec 2004 18:08:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/n_tty.: make two functions static
Message-ID: <20041205170801.GU2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

