Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbULWAok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbULWAok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbULWAoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:44:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262100AbULWAhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:19 -0500
Date: Thu, 23 Dec 2004 01:37:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jonathan@buzzard.org.uk, tlinux-users@tce.toshiba-dme.co.jp,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/toshiba.c: make a function static (fwd)
Message-ID: <20041223003716.GG5217@stusta.de>
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

Date:	Sun, 5 Dec 2004 18:21:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jonathan@buzzard.org.uk
Cc: tlinux-users@tce.toshiba-dme.co.jp, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/toshiba.c: make a function static

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c.old	2004-11-07 01:25:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c	2004-11-07 01:25:08.000000000 +0100
@@ -407,7 +407,7 @@
  *   laptop, otherwise zero and determines the Machine ID, BIOS version and
  *   date, and SCI version.
  */
-int tosh_probe(void)
+static int tosh_probe(void)
 {
 	int i,major,minor,day,year,month,flag;
 	unsigned char signature[7] = { 0x54,0x4f,0x53,0x48,0x49,0x42,0x41 };

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

