Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWAPEc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWAPEc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWAPEc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:32:59 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:51043 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932208AbWAPEc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:32:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] Fix compile warning in bt8xx module
Date: Sun, 15 Jan 2006 23:32:53 -0500
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152332.54168.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: work/drivers/media/dvb/bt8xx/dvb-bt8xx.c
===================================================================
--- work.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ work/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -893,7 +893,7 @@ static int dvb_bt8xx_probe(struct bttv_s
 	return 0;
 }
 
-static int dvb_bt8xx_remove(struct bttv_sub_device *sub)
+static void dvb_bt8xx_remove(struct bttv_sub_device *sub)
 {
 	struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
 
@@ -911,8 +911,6 @@ static int dvb_bt8xx_remove(struct bttv_
 	dvb_unregister_adapter(&card->dvb_adapter);
 
 	kfree(card);
-
-	return 0;
 }
 
 static struct bttv_sub_driver driver = {
