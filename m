Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWAaVcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWAaVcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWAaVcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:32:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18703 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751508AbWAaVci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:32:38 -0500
Date: Tue, 31 Jan 2006 22:32:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/: make some functions static
Message-ID: <20060131213234.GD3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/joystick/twidjoy.c  |    4 ++--
 drivers/input/touchscreen/mk712.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c.old	2005-11-04 11:37:38.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c	2005-11-04 11:38:01.000000000 +0100
@@ -265,13 +265,13 @@
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
--- linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c.old	2005-11-04 11:38:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c	2005-11-04 11:38:29.000000000 +0100
@@ -154,7 +154,7 @@
 	spin_unlock_irqrestore(&mk712_lock, flags);
 }
 
-int __init mk712_init(void)
+static int __init mk712_init(void)
 {
 	int err;
 
