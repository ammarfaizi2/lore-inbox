Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbULVLwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbULVLwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbULVLwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:52:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62481 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261970AbULVLuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:14 -0500
Date: Wed, 22 Dec 2004 12:50:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mxser.c: make some code static (fwd)
Message-ID: <20041222115012.GQ5217@stusta.de>
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

Date:	Sun, 5 Dec 2004 18:06:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mxser.c: make some code static

The patch below makes a struct and a function that both were needlessly 
global static.


diffstat output:
 drivers/char/mxser.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/mxser.c.old	2004-11-07 00:32:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/mxser.c	2004-11-07 00:33:20.000000000 +0100
@@ -321,7 +321,7 @@
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
 	9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600, 0};
 
-struct mxser_hwconf mxsercfg[MXSER_BOARDS];
+static struct mxser_hwconf mxsercfg[MXSER_BOARDS];
 
 /*
  * static functions:
@@ -389,7 +389,7 @@
 
 }
 
-int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
+static int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
 {
 	struct mxser_struct *info;
 	unsigned long flags;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

