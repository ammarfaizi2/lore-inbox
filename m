Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVCVV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVCVV7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVCVV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:56:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262106AbVCVVzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:55:07 -0500
Date: Tue, 22 Mar 2005 22:55:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/gscd.c: kill dead code
Message-ID: <20050322215505.GN1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c.old	2005-03-22 20:58:54.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c	2005-03-22 20:59:46.000000000 +0100
@@ -694,12 +694,8 @@
 		do {
 			result = wait_drv_ready();
 		} while (result != 6 || result == 0x0E);
 
-		if (result != 6) {
-			cmd_end();
-			return;
-		}
 #ifdef GSCD_DEBUG
 		printk("LOC_191 ");
 #endif
 

