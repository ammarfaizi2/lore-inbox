Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUJ1Xe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUJ1Xe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbUJ1XdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:33:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20243 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263089AbUJ1XcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:32:06 -0400
Date: Fri, 29 Oct 2004 01:31:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Fernando Fuganti <fuganti@netbank.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] watchdog/machzwd.c: remove unused functions
Message-ID: <20041028233134.GO3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes unused functions from 
drivers/char/watchdog/machzwd.c


diffstat output:
 drivers/char/watchdog/machzwd.c |   29 -----------------------------
 1 files changed, 29 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/char/watchdog/machzwd.c.old	2004-10-28 22:57:31.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/char/watchdog/machzwd.c	2004-10-28 23:56:59.000000000 +0200
@@ -88,12 +88,6 @@
 	return inw(DATA_W);
 }
 
- -static unsigned short zf_readb(unsigned char port)
- -{
- -	outb(port, INDEX);
- -	return inb(DATA_B);
- -}
- -
 
 MODULE_AUTHOR("Fernando Fuganti <fuganti@conectiva.com.br>");
 MODULE_DESCRIPTION("MachZ ZF-Logic Watchdog driver");
@@ -155,13 +149,6 @@
 #endif
 
 
- -/* STATUS register functions */
- -
- -static inline unsigned char zf_get_status(void)
- -{
- -	return zf_readb(STATUS);
- -}
- -
 static inline void zf_set_status(unsigned char new)
 {
 	zf_writeb(STATUS, new);
@@ -183,22 +170,6 @@
 
 /* WD#? counter functions */
 /*
- - *	Just get current counter value
- - */
- -
- -static inline unsigned short zf_get_timer(unsigned char n)
- -{
- -	switch(n){
- -		case WD1:
- -			return zf_readw(COUNTER_1);
- -		case WD2:
- -			return zf_readb(COUNTER_2);
- -		default:
- -			return 0;
- -	}
- -}
- -
- -/*
  *	Just set counter value
  */
 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgYFWmfzqmE8StAARAmlSAKDA7jm7qYoR+0t2dAqockIIhOQrwQCfVfhB
cCmEowuQG3448BONZ8bkd08=
=hf60
-----END PGP SIGNATURE-----
