Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKTGsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKTGsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKTGsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:48:50 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:30561 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750772AbVKTGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:13 -0500
Message-Id: <20051120064420.845578000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 13/14] Input updates for 2.6.15
Content-Disposition: inline; filename=saa7133-fix-ir-init.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an OOPS when initializing IR remote on saa7134
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/video/saa7134/saa7134-input.c |    2 ++
 1 files changed, 2 insertions(+)

Index: work/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- work.orig/drivers/media/video/saa7134/saa7134-input.c
+++ work/drivers/media/video/saa7134/saa7134-input.c
@@ -713,6 +713,8 @@ int saa7134_input_init1(struct saa7134_d
 		return -ENOMEM;
 	}
 
+	ir->dev = input_dev;
+
 	/* init hardware-specific stuff */
 	ir->mask_keycode = mask_keycode;
 	ir->mask_keydown = mask_keydown;

