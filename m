Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUB2HDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUB2HDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:03:46 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:16300 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261992AbUB2HDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/9] atkbd whitespace fixes
Date: Sun, 29 Feb 2004 01:55:02 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net>
In-Reply-To: <200402290153.08798.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290155.04825.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1685, 2004-02-27 23:41:11-05:00, dtor_core@ameritech.net
  Atkbd: whitespace fixes


 atkbd.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sun Feb 29 01:14:59 2004
+++ b/drivers/input/keyboard/atkbd.c	Sun Feb 29 01:14:59 2004
@@ -202,7 +202,7 @@
 		atkbd->resend = 1;
 		goto out;
 	}
-	
+
 	if (!flags && data == ATKBD_RET_ACK)
 		atkbd->resend = 0;
 #endif
@@ -276,7 +276,7 @@
 		case ATKBD_KEY_UNKNOWN:
 			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
 				atkbd->release ? "released" : "pressed",
-				atkbd->translated ? "translated" : "raw", 
+				atkbd->translated ? "translated" : "raw",
 				atkbd->set, code, serio->phys);
 			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
 				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
@@ -353,7 +353,7 @@
 	if (receive && param)
 		for (i = 0; i < receive; i++)
 			atkbd->cmdbuf[(receive - 1) - i] = param[i];
-	
+
 	if (command & 0xff)
 		if (atkbd_sendbyte(atkbd, command & 0xff))
 			return (atkbd->cmdcnt = 0) - 1;
@@ -373,7 +373,7 @@
 			atkbd->cmdcnt = 0;
 			break;
 		}
-	
+
 		udelay(1);
 	}
 
@@ -466,7 +466,7 @@
  */
 
 	if (atkbd_reset)
-		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
+		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
 			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
 
 /*
@@ -529,7 +529,7 @@
 		return 3;
 	}
 
-	if (atkbd_set != 2) 
+	if (atkbd_set != 2)
 		if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
 			atkbd->id = param[0] << 8 | param[1];
 			return 2;
@@ -541,7 +541,7 @@
 			return 4;
 	}
 
-	if (atkbd_set != 3) 
+	if (atkbd_set != 3)
 		return 2;
 
 	param[0] = 3;
@@ -637,7 +637,7 @@
 
 	switch (serio->type & SERIO_TYPE) {
 
-		case SERIO_8042_XL: 
+		case SERIO_8042_XL:
 			atkbd->translated = 1;
 		case SERIO_8042:
 			if (serio->write)
@@ -650,7 +650,7 @@
 			kfree(atkbd);
 			return;
 	}
-			
+
 	if (atkbd->write) {
 		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
@@ -687,7 +687,7 @@
 			kfree(atkbd);
 			return;
 		}
-		
+
 		atkbd->set = atkbd_set_3(atkbd);
 		atkbd_enable(atkbd);
 
