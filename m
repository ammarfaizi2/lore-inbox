Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266474AbSKGKSc>; Thu, 7 Nov 2002 05:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266476AbSKGKSc>; Thu, 7 Nov 2002 05:18:32 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:50083 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266474AbSKGKS2>; Thu, 7 Nov 2002 05:18:28 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Nov 2002 11:35:49 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] c99 struct initialization for the tuner module
Message-ID: <20021107103549.GA2235@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

$SUBJECT says all, please apply,

  Gerd

--- linux-2.5.46/drivers/media/video/tuner.c	2002-11-07 09:20:37.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2002-11-07 09:22:20.000000000 +0100
@@ -975,18 +975,18 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-        name:           "i2c TV tuner driver",
-        id:             I2C_DRIVERID_TUNER,
-        flags:          I2C_DF_NOTIFY,
-        attach_adapter: tuner_probe,
-        detach_client:  tuner_detach,
-        command:        tuner_command,
+        .name           = "i2c TV tuner driver",
+        .id             = I2C_DRIVERID_TUNER,
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = tuner_probe,
+        .detach_client  = tuner_detach,
+        .command        = tuner_command,
 };
 static struct i2c_client client_template =
 {
-        name:   "(tuner unset)",
-	flags:  I2C_CLIENT_ALLOW_USE,
-        driver: &driver,
+        .name   = "(tuner unset)",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
 };
 
 static int tuner_init_module(void)

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
