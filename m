Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270429AbUJUHmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270429AbUJUHmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270405AbUJUHmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:42:01 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:50331 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270393AbUJUHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/7] Input: whitespace fixes
Date: Thu, 21 Oct 2004 02:24:29 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net>
In-Reply-To: <200410210223.45498.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210224.33971.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1954, 2004-10-13 01:03:04-05:00, dtor_core@ameritech.net
  Input: couple of whitespace fixes.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sermouse.c |   24 ++++++++++++------------
 vsxxxaa.c  |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-10-21 02:08:05 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-10-21 02:08:05 -05:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -73,19 +73,19 @@
 
 		case 0:
 			if ((data & 0xf8) != 0x80) return;
-			input_report_key(dev, BTN_LEFT,   !(data & 4)); 
+			input_report_key(dev, BTN_LEFT,   !(data & 4));
 			input_report_key(dev, BTN_RIGHT,  !(data & 1));
 			input_report_key(dev, BTN_MIDDLE, !(data & 2));
 			break;
 
-		case 1: 
-		case 3: 
+		case 1:
+		case 3:
 			input_report_rel(dev, REL_X, data / 2);
 			input_report_rel(dev, REL_Y, -buf[1]);
 			buf[0] = data - data / 2;
 			break;
 
-		case 2: 
+		case 2:
 		case 4:
 			input_report_rel(dev, REL_X, buf[0]);
 			input_report_rel(dev, REL_Y, buf[1] - data);
@@ -145,7 +145,7 @@
 		case 3:
 
 			switch (sermouse->type) {
-			
+
 				case SERIO_MS:
 					 sermouse->type = SERIO_MP;
 
@@ -164,7 +164,7 @@
 					input_report_rel(dev, REL_WHEEL,  (data & 8) - (data & 7));
 					break;
 			}
-					
+
 			break;
 
 		case 4:
@@ -243,7 +243,7 @@
 {
 	struct sermouse *sermouse;
 	unsigned char c;
-	
+
 	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
 		return;
 
@@ -287,7 +287,7 @@
 	}
 
 	input_register_device(&sermouse->dev);
-	
+
 	printk(KERN_INFO "input: %s on %s\n", sermouse_protocols[sermouse->type], serio->phys);
 }
 
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-10-21 02:08:05 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-10-21 02:08:05 -05:00
@@ -45,7 +45,7 @@
  *  | 4 --- 3 |
  *   \  2 1  /
  *    -------
- * 
+ *
  *	DEC socket	DE9	DB25	Note
  *	1 (GND)		5	7	-
  *	2 (RxD)		2	3	-
