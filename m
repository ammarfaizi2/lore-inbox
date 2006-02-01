Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWBAFJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWBAFJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWBAFJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:09 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:52079 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030320AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050733.848257000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 05/18] Make needlessly global code static
Content-Disposition: inline; filename=input-make-code-static.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Input: make needlessly global code static

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/twidjoy.c  |    4 ++--
 drivers/input/touchscreen/mk712.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/input/joystick/twidjoy.c
===================================================================
--- work.orig/drivers/input/joystick/twidjoy.c
+++ work/drivers/input/joystick/twidjoy.c
@@ -265,13 +265,13 @@ static struct serio_driver twidjoy_drv =
  * The functions for inserting/removing us as a module.
  */
 
-int __init twidjoy_init(void)
+static int __init twidjoy_init(void)
 {
 	serio_register_driver(&twidjoy_drv);
 	return 0;
 }
 
-void __exit twidjoy_exit(void)
+static void __exit twidjoy_exit(void)
 {
 	serio_unregister_driver(&twidjoy_drv);
 }
Index: work/drivers/input/touchscreen/mk712.c
===================================================================
--- work.orig/drivers/input/touchscreen/mk712.c
+++ work/drivers/input/touchscreen/mk712.c
@@ -154,7 +154,7 @@ static void mk712_close(struct input_dev
 	spin_unlock_irqrestore(&mk712_lock, flags);
 }
 
-int __init mk712_init(void)
+static int __init mk712_init(void)
 {
 	int err;
 

