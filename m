Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVDSAiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVDSAiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDSAiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:38:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261219AbVDSAie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:38:34 -0400
Date: Tue, 19 Apr 2005 02:38:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/bttv-driver.c: make 2 functions static
Message-ID: <20050419003829.GH5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/bttv-driver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/media/video/bttv-driver.c.old	2005-04-19 01:32:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/bttv-driver.c	2005-04-19 01:33:31.000000000 +0200
@@ -3169,7 +3169,7 @@
 /* ----------------------------------------------------------------------- */
 /* some debug code                                                         */
 
-int bttv_risc_decode(u32 risc)
+static int bttv_risc_decode(u32 risc)
 {
 	static char *instr[16] = {
 		[ BT848_RISC_WRITE     >> 28 ] = "write",
@@ -3206,8 +3206,8 @@
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
-void bttv_risc_disasm(struct bttv *btv,
-		      struct btcx_riscmem *risc)
+static void bttv_risc_disasm(struct bttv *btv,
+			     struct btcx_riscmem *risc)
 {
 	unsigned int i,j,n;
 

