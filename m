Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVDKXdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVDKXdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVDKXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:33:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:22015 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261670AbVDKXdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:33:36 -0400
From: Peter Missel <peter.missel@onlinehome.de>
To: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] LifeView FlyTV Platinum FM: Remote Control support
Date: Tue, 12 Apr 2005 01:33:06 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504120133.06996.peter.missel@onlinehome.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:eea5ddcdb9e55c285e39b42944f081ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

Subject says it ... this card's IR microcontroller design and attachment
are compatible to the company's previous designs, so the patch was as simple as it gets.

Note that this patch goes on top of the other one I posted yesterday, thank you very much.

regards,
Peter

--- linux-2.6.12-rc2/drivers/media/video/saa7134/saa7134-cards.c        2005-04-09 12:01:47.000000000 +0200
+++ video4linux/saa7134-cards.c 2005-04-12 00:58:57.000000000 +0200
@@ -1948,6 +1948,7 @@
                dev->has_remote = 1;
                board_flyvideo(dev);
                break;
+       case SAA7134_BOARD_FLYTVPLATINUM_FM:
        case SAA7134_BOARD_CINERGY400:
        case SAA7134_BOARD_CINERGY600:
        case SAA7134_BOARD_CINERGY600_MK3:

--- linux-2.6.12-rc2/drivers/media/video/saa7134/saa7134-input.c 2005-04-09 12:01:47.000000000 +0200
+++ video4linux/saa7134-input.c 2005-04-12 01:15:11.000000000 +0200
@@ -379,6 +379,7 @@
        switch (dev->board) {
        case SAA7134_BOARD_FLYVIDEO2000:
        case SAA7134_BOARD_FLYVIDEO3000:
+       case SAA7134_BOARD_FLYTVPLATINUM_FM:
                ir_codes     = flyvideo_codes;
                mask_keycode = 0xEC00000;
                mask_keydown = 0x0040000;
