Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbULGTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbULGTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbULGTf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:35:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35851 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261899AbULGTfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:10 -0500
Date: Tue, 7 Dec 2004 20:35:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Fernando Fuganti <fuganti@netbank.com.br>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] watchdog/machzwd.c: remove unused functions (fwd)
Message-ID: <20041207193505.GW7250@stusta.de>
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

Date:	Fri, 29 Oct 2004 02:30:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Fernando Fuganti <fuganti@netbank.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] watchdog/machzwd.c: remove unused functions

The patch below removes unused functions from 
drivers/char/watchdog/machzwd.c


diffstat output:
 drivers/char/watchdog/machzwd.c |   29 -----------------------------
 1 files changed, 29 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/char/watchdog/machzwd.c.old	2004-10-28 22:57:31.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/char/watchdog/machzwd.c	2004-10-28 23:56:59.000000000 +0200
@@ -88,12 +88,6 @@
 	return inw(DATA_W);
 }
 
-static unsigned short zf_readb(unsigned char port)
-{
-	outb(port, INDEX);
-	return inb(DATA_B);
-}
-
 
 MODULE_AUTHOR("Fernando Fuganti <fuganti@conectiva.com.br>");
 MODULE_DESCRIPTION("MachZ ZF-Logic Watchdog driver");
@@ -155,13 +149,6 @@
 #endif
 
 
-/* STATUS register functions */
-
-static inline unsigned char zf_get_status(void)
-{
-	return zf_readb(STATUS);
-}
-
 static inline void zf_set_status(unsigned char new)
 {
 	zf_writeb(STATUS, new);
@@ -183,22 +170,6 @@
 
 /* WD#? counter functions */
 /*
- *	Just get current counter value
- */
-
-static inline unsigned short zf_get_timer(unsigned char n)
-{
-	switch(n){
-		case WD1:
-			return zf_readw(COUNTER_1);
-		case WD2:
-			return zf_readb(COUNTER_2);
-		default:
-			return 0;
-	}
-}
-
-/*
  *	Just set counter value
  */
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

