Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbULWAsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbULWAsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULWApt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:45:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18445 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262103AbULWAha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:30 -0500
Date: Thu, 23 Dec 2004 01:37:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_ioctl.c: make a function static (fwd)
Message-ID: <20041223003728.GI5217@stusta.de>
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

Date:	Sun, 5 Dec 2004 18:24:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_ioctl.c: make a function static

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
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


