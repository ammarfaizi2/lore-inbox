Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbULGTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbULGTsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbULGTiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:38:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39947 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261905AbULGTfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:24 -0500
Date: Tue, 7 Dec 2004 20:35:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Carsten Paeth <calle@calle.de>, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ISDN b1pcmcia.c: remove an unused variable (fwd)
Message-ID: <20041207193515.GA7250@stusta.de>
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

Date:	Fri, 29 Oct 2004 21:32:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Carsten Paeth <calle@calle.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de,
	isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ISDN b1pcmcia.c: remove an unused variable


I'm getting the following compile warning in recent 2.6 kernels:


<--  snip  -->

...
  CC      drivers/isdn/hardware/avm/b1pcmcia.o
drivers/isdn/hardware/avm/b1pcmcia.c: In function `b1pcmcia_init':
drivers/isdn/hardware/avm/b1pcmcia.c:203: warning: unused variable `err'
...

<--  snip  -->


Since this variable is completely unused, the fix is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/avm/b1pcmcia.c.old	2004-10-29 21:28:00.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/avm/b1pcmcia.c	2004-10-29 21:28:16.000000000 +0200
@@ -200,7 +200,6 @@
 {
 	char *p;
 	char rev[32];
-	int err;
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
 		strlcpy(rev, p + 2, 32);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
