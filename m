Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbULFXEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbULFXEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULFXEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:04:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38661 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261682AbULFXCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:02:47 -0500
Date: Tue, 7 Dec 2004 00:02:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] media/video/ir-kbd-i2c.c: remove an unused function (fwd)
Message-ID: <20041206230244.GR7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:19:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] media/video/ir-kbd-i2c.c: remove an unused function

The patch below removes an unused function from 
drivers/media/video/ir-kbd-i2c.c


diffstat output:
 drivers/media/video/ir-kbd-i2c.c |   10 ----------
 1 files changed, 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/media/video/ir-kbd-i2c.c.old	2004-10-28 23:05:55.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/video/ir-kbd-i2c.c	2004-10-28 23:06:06.000000000 +0200
@@ -155,16 +155,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-static inline int reverse(int data, int bits)
-{
-	int i,c;
-
-	for (c=0,i=0; i<bits; i++) {
-		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
-	}
-	return c;
-}
-
 static int get_key_haup(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
 	unsigned char buf[3];
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

