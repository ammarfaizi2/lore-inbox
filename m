Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVDISF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVDISF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVDISFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:05:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8708 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261364AbVDISD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:03:59 -0400
Date: Sat, 9 Apr 2005 20:03:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net,
       adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/radeonfb.c: fix an array overflow
Message-ID: <20050409180358.GE3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c.old	2005-03-23 01:50:14.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c	2005-03-23 01:50:30.000000000 +0100
@@ -2107,7 +2107,7 @@ static void radeon_write_mode (struct ra
 
 
 	if (rinfo->arch == RADEON_M6) {
-		for (i=0; i<8; i++)
+		for (i=0; i<7; i++)
 			OUTREG(common_regs_m6[i].reg, common_regs_m6[i].val);
 	} else {
 		for (i=0; i<9; i++)

