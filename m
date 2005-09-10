Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVIJWfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVIJWfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVIJWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:25 -0400
Received: from styx.suse.cz ([82.119.242.94]:44196 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932364AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 26/26] i8042 - use kzalloc instead of kcalloc
In-Reply-To: <11263916542240@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:14 +0200
Message-Id: <11263916543736@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: i8042 - use kzalloc instead of kcalloc
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1126371882 -0500

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/serio/i8042.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

d39969deee4b541be4ee5789a2e4c14511c886e2
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -986,7 +986,7 @@ static int __init i8042_create_kbd_port(
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
 
-	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
@@ -1011,7 +1011,7 @@ static int __init i8042_create_aux_port(
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_AUX_PORT_NO];
 
-	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
@@ -1036,7 +1036,7 @@ static int __init i8042_create_mux_port(
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_MUX_PORT_NO + index];
 
-	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 

