Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263260AbUJ2Twr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUJ2Twr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUJ2Tvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:51:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262586AbUJ2TdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:33:09 -0400
Date: Fri, 29 Oct 2004 21:32:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Carsten Paeth <calle@calle.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] ISDN b1pcmcia.c: remove an unused variable
Message-ID: <20041029193229.GS6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

