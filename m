Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbULWAoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbULWAoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbULWAoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:44:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262099AbULWAhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:17 -0500
Date: Thu, 23 Dec 2004 01:37:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tipar.c: make two functions static (fwd)
Message-ID: <20041223003714.GF5217@stusta.de>
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

Date:	Sun, 5 Dec 2004 18:20:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Romain Lievin <roms@lpg.ticalc.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tipar.c: make two functions static

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/char/tipar.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c.old	2004-11-07 01:24:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c	2004-11-07 01:24:45.000000000 +0100
@@ -489,7 +489,7 @@
 	.detach = tipar_detach,
 };
 
-int __init
+static int __init
 tipar_init_module(void)
 {
 	int err = 0;
@@ -526,7 +526,7 @@
 	return err;	
 }
 
-void __exit
+static void __exit
 tipar_cleanup_module(void)
 {
 	unsigned int i;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

