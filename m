Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUKIBUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUKIBUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUKIBAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:00:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261324AbUKIA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:56:10 -0500
Date: Tue, 9 Nov 2004 01:55:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [4/11] bttv-cards.c: remove unused function bttv_reset_audio
Message-ID: <20041109005538.GS15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function bttv_reset_audio in drivers/media/video/bttv-cards.c is 
completely unused.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c.old	2004-11-07 16:34:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c	2004-11-07 17:14:25.000000000 +0100
@@ -2521,27 +2522,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-void bttv_reset_audio(struct bttv *btv)
-{
-	/*
-	 * BT878A has a audio-reset register.
-	 * 1. This register is an audio reset function but it is in
-	 *    function-0 (video capture) address space.
-	 * 2. It is enough to do this once per power-up of the card.
-	 * 3. There is a typo in the Conexant doc -- it is not at
-	 *    0x5B, but at 0x058. (B is an odd-number, obviously a typo!).
-	 * --//Shrikumar 030609
-	 */
-	if (btv->id != 878)
-		return;
-
-	if (bttv_debug)
-		printk("bttv%d: BT878A ARESET\n",btv->c.nr);
-	btwrite((1<<7), 0x058);
-	udelay(10);
-	btwrite(     0, 0x058);
-}
-
 /* initialization part one -- before registering i2c bus */
 void __devinit bttv_init_card1(struct bttv *btv)
 {

