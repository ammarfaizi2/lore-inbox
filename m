Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVDIXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDIXCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDIXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:02:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56326 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261403AbVDIXB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:01:57 -0400
Date: Sun, 10 Apr 2005 01:01:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/matrox/matroxfb_misc.c: remove dead code
Message-ID: <20050409230156.GO3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm2-full/drivers/video/matrox/matroxfb_misc.c.old	2005-04-09 21:40:17.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/video/matrox/matroxfb_misc.c	2005-04-09 21:40:47.000000000 +0200
@@ -195,14 +195,11 @@ int matroxfb_vgaHWinit(WPMINFO struct my
 	fwidth = 8;
 
 	DBG(__FUNCTION__)
 
 	hw->SEQ[0] = 0x00;
-	if (fwidth == 9)
-		hw->SEQ[1] = 0x00;
-	else
-		hw->SEQ[1] = 0x01;	/* or 0x09 */
+	hw->SEQ[1] = 0x01;	/* or 0x09 */
 	hw->SEQ[2] = 0x0F;	/* bitplanes */
 	hw->SEQ[3] = 0x00;
 	hw->SEQ[4] = 0x0E;
 	/* CRTC 0..7, 9, 16..19, 21, 22 are reprogrammed by Matrox Millennium code... Hope that by MGA1064 too */
 	if (m->dblscan) {

