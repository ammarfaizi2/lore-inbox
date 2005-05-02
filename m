Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVEBCgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEBCgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVEBCQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:16:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28176 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261638AbVEBBqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:39 -0400
Date: Mon, 2 May 2005 03:46:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/hamradio/: cleanups
Message-ID: <20050502014637.GQ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- mkiss.c: make a needlessly global variable static
- dmascc.c: remove the unused global function dmascc_setup

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

 drivers/net/hamradio/dmascc.c |   10 ----------
 drivers/net/hamradio/mkiss.c  |    2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/hamradio/dmascc.c.old	2005-04-19 03:04:36.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/hamradio/dmascc.c	2005-04-19 03:04:57.000000000 +0200
@@ -311,16 +311,6 @@
 	}
 }
 
-#ifndef MODULE
-void __init dmascc_setup(char *str, int *ints)
-{
-	int i;
-
-	for (i = 0; i < MAX_NUM_DEVS && i < ints[0]; i++)
-		io[i] = ints[i + 1];
-}
-#endif
-
 static int __init dmascc_init(void)
 {
 	int h, i, j, n;
--- linux-2.6.12-rc2-mm3-full/drivers/net/hamradio/mkiss.c.old	2005-04-19 03:05:20.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/hamradio/mkiss.c	2005-04-19 03:05:30.000000000 +0200
@@ -65,7 +65,7 @@
 
 static ax25_ctrl_t **ax25_ctrls;
 
-int ax25_maxdev = AX25_MAXDEV;		/* Can be overridden with insmod! */
+static int ax25_maxdev = AX25_MAXDEV;	/* Can be overridden with insmod! */
 
 static struct tty_ldisc	ax_ldisc;
 

