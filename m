Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUCPPfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUCPOjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:39:33 -0500
Received: from styx.suse.cz ([82.208.2.94]:63361 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261924AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467772683@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 18/44] Whitespace fixes in psmouse.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467772247@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.4, 2004-03-03 00:30:04-05:00, dtor_core@ameritech.net
  Psmouse: whitespace fixes


 psmouse-base.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:59 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:59 2004
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

