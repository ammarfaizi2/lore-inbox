Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUCPP3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUCPOj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:39:58 -0500
Received: from styx.suse.cz ([82.208.2.94]:62593 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261920AbUCPOTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:42 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467772503@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 16/44] Whitespace in atkbd.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467772420@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.1, 2004-03-03 00:25:49-05:00, dtor_core@ameritech.net
  Atkbd: whitespace fixes


 atkbd.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:10 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:10 2004
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
 

