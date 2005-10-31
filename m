Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVJaAdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVJaAdr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVJaAdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:33:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22802 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932420AbVJaAdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:33:46 -0500
Date: Mon, 31 Oct 2005 01:33:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/hamradio/dmascc.c: remove dmascc_setup()
Message-ID: <20051031003345.GB8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems dmascc_setup() is a leftover time before dmascc_init() was 
there.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/hamradio/dmascc.c |   10 ----------
 1 file changed, 10 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/net/hamradio/dmascc.c.old	2005-10-31 01:21:39.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/hamradio/dmascc.c	2005-10-31 01:21:49.000000000 +0100
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

