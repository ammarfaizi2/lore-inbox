Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUB2HFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUB2HEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:04:01 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:64910 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261995AbUB2HDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/9] psmouse whitespace fixes
Date: Sun, 29 Feb 2004 01:58:02 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290155.46360.dtor_core@ameritech.net> <200402290156.53325.dtor_core@ameritech.net>
In-Reply-To: <200402290156.53325.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290158.04309.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1688, 2004-02-27 23:46:16-05:00, dtor_core@ameritech.net
  Psmouse: whitespace fixes


 psmouse-base.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sun Feb 29 01:17:01 2004
+++ b/drivers/input/mouse/psmouse-base.c	Sun Feb 29 01:17:01 2004
@@ -163,14 +163,14 @@
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
 	}
-	
+
 	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
 
 	if (psmouse->packet[0] == PSMOUSE_RET_BAT) {
 		if (psmouse->pktcnt == 1)
 			goto out;
-		
+
 		if (psmouse->pktcnt == 2) {
 			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 				psmouse->state = PSMOUSE_IGNORE;
@@ -258,7 +258,7 @@
 			return (psmouse->cmdcnt = 0) - 1;
 
 	while (psmouse->cmdcnt && timeout--) {
-	
+
 		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
 				timeout > 100000) /* do not run in a endless loop */
 			timeout = 100000; /* 1 sec */
@@ -497,7 +497,7 @@
 static void psmouse_initialize(struct psmouse *psmouse)
 {
 	unsigned char param[2];
-	
+
 /*
  * We set the mouse report rate, resolution and scaling.
  */
@@ -571,7 +571,7 @@
 static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct psmouse *psmouse;
-	
+
 	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
 	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
 		return;
@@ -603,7 +603,7 @@
 		serio->private = NULL;
 		return;
 	}
-	
+
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
 	sprintf(psmouse->phys, "%s/input0",
@@ -617,7 +617,7 @@
 	psmouse->dev.id.version = psmouse->model;
 
 	input_register_device(&psmouse->dev);
-	
+
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
 	psmouse_initialize(psmouse);
