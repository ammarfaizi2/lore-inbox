Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULERNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULERNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULERJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:09:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58378 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261335AbULERGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:06:49 -0500
Date: Sun, 5 Dec 2004 18:06:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mxser.c: make some code static
Message-ID: <20041205170647.GT2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

