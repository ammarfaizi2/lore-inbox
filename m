Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVC0UcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVC0UcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVC0UcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:32:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261526AbVC0Ubz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:31:55 -0500
Date: Sun, 27 Mar 2005 22:31:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/radeonfb.c: fix an array overflow
Message-ID: <20050327203153.GS4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c.old	2005-03-23 01:50:14.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c	2005-03-23 01:50:30.000000000 +0100
@@ -2107,7 +2107,7 @@ static void radeon_write_mode (struct ra
 
 
 	if (rinfo->arch == RADEON_M6) {
-		for (i=0; i<8; i++)
+		for (i=0; i<7; i++)
 			OUTREG(common_regs_m6[i].reg, common_regs_m6[i].val);
 	} else {
 		for (i=0; i<9; i++)

