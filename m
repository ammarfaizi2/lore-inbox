Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULER3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULER3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbULER0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:26:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20748 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261365AbULERY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:24:26 -0500
Date: Sun, 5 Dec 2004 18:24:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_ioctl.c: make a function static
Message-ID: <20041205172424.GD2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/tty_ioctl.c.old	2004-11-07 01:28:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tty_ioctl.c	2004-11-07 01:29:04.000000000 +0100
@@ -372,7 +372,7 @@
 /*
  * Send a high priority character to the tty.
  */
-void send_prio_char(struct tty_struct *tty, char ch)
+static void send_prio_char(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;
 

