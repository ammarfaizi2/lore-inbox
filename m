Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVDLUOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVDLUOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVDLUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:13:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:29640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262144AbVDLKbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:34 -0400
Message-Id: <200504121030.j3CAUnoP005159@shell0.pdx.osdl.net>
Subject: [patch 012/198] fix Bug 4395: modprobe bttv freezes the computer
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, js@linuxtv.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Johannes Stezenbach <js@linuxtv.org>

Fix http://bugme.osdl.org/show_bug.cgi?id=4395.

Patch by Manu Abraham and Gerd Knorr:

Remove redundant bttv_reset_audio() which caused the computer to freeze
with some bt8xx based DVB cards when loading the bttv driver.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/media/video/bttv-cards.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/media/video/bttv-cards.c~fix-bug-4395-modprobe-bttv-freezes-the-computer drivers/media/video/bttv-cards.c
--- 25/drivers/media/video/bttv-cards.c~fix-bug-4395-modprobe-bttv-freezes-the-computer	2005-04-12 03:21:06.348171832 -0700
+++ 25-akpm/drivers/media/video/bttv-cards.c	2005-04-12 03:21:06.354170920 -0700
@@ -2785,8 +2785,6 @@ void __devinit bttv_init_card2(struct bt
         }
 	btv->pll.pll_current = -1;
 
-	bttv_reset_audio(btv);
-
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)
_
