Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUFGM5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUFGM5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUFGMZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:25:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13697 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264582AbUFGL4S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:18 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609354396@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609354864@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 27/39] input: Trailing whitespace fixes in drivers/input/keyboard
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.7, 2004-05-10 01:31:35-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes in drivers/input/keyboard


 98kbd.c      |   16 ++++++++--------
 Kconfig      |    6 +++---
 maple_keyb.c |    2 +-
 sunkbd.c     |   16 ++++++++--------
 xtkbd.c      |   12 ++++++------
 5 files changed, 26 insertions(+), 26 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/98kbd.c b/drivers/input/keyboard/98kbd.c
--- a/drivers/input/keyboard/98kbd.c	2004-06-07 13:11:23 +02:00
+++ b/drivers/input/keyboard/98kbd.c	2004-06-07 13:11:23 +02:00
@@ -12,18 +12,18 @@
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
  */
 
 #include <linux/delay.h>
@@ -43,7 +43,7 @@
 #define KBD98_KEY	0x7f
 #define KBD98_RELEASE	0x80
 
-static unsigned char kbd98_keycode[256] = {	 
+static unsigned char kbd98_keycode[256] = {
 	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
 	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 41, 26, 28, 30, 31, 32,
 	 33, 34, 35, 36, 37, 38, 39, 40, 27, 44, 45, 46, 47, 48, 49, 50,
@@ -247,7 +247,7 @@
 	int i;
 
 	kbd98->cmdcnt = receive;
-	
+
 	if (command & 0xff)
 		if (kbd98_sendbyte(kbd98, command & 0xff))
 			return (kbd98->cmdcnt = 0) - 1;
@@ -262,7 +262,7 @@
 		for (i = 0; i < receive; i++)
 			param[i] = kbd98->cmdbuf[(receive - 1) - i];
 
-	if (kbd98->cmdcnt) 
+	if (kbd98->cmdcnt)
 		return (kbd98->cmdcnt = 0) - 1;
 
 	return 0;
@@ -322,7 +322,7 @@
 
 	memset(kbd98, 0, sizeof(struct kbd98));
 	kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
-	
+
 	kbd98->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 	kbd98->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_KANA);
 
diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	2004-06-07 13:11:23 +02:00
+++ b/drivers/input/keyboard/Kconfig	2004-06-07 13:11:23 +02:00
@@ -62,7 +62,7 @@
 	  Say Y here if you want to use the old IBM PC/XT keyboard (or
 	  compatible) on your system. This is only possible with a
 	  parallel port keyboard adapter, you cannot connect it to the
-	  keyboard port on a PC that runs Linux. 
+	  keyboard port on a PC that runs Linux.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.
@@ -92,7 +92,7 @@
 	depends on AMIGA && INPUT && INPUT_KEYBOARD
 	help
 	  Say Y here if you are running Linux on any AMIGA and have a keyboard
-	  attached.	
+	  attached.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called amikbd.
@@ -103,7 +103,7 @@
 	select SERIO
 	help
 	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
-	  compatible) on your system. 
+	  compatible) on your system.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called 98kbd.
diff -Nru a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
--- a/drivers/input/keyboard/maple_keyb.c	2004-06-07 13:11:23 +02:00
+++ b/drivers/input/keyboard/maple_keyb.c	2004-06-07 13:11:23 +02:00
@@ -139,7 +139,7 @@
 
 	kbd->dev.name = dev->product_name;
 	kbd->dev.id.bustype = BUS_MAPLE;
-	
+
 	input_register_device(&kbd->dev);
 
 	maple_getcond_callback(dev, dc_kbd_callback, 1, MAPLE_FUNC_KEYBOARD);
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-06-07 13:11:23 +02:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-06-07 13:11:23 +02:00
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
@@ -148,7 +148,7 @@
 		case EV_LED:
 
 			sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_SETLED);
-			sunkbd->serio->write(sunkbd->serio, 
+			sunkbd->serio->write(sunkbd->serio,
 				(!!test_bit(LED_CAPSL, dev->led) << 3) | (!!test_bit(LED_SCROLLL, dev->led) << 2) |
 				(!!test_bit(LED_COMPOSE, dev->led) << 1) | !!test_bit(LED_NUML, dev->led));
 			return 0;
@@ -160,7 +160,7 @@
 				case SND_CLICK:
 					sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_NOCLICK - value);
 					return 0;
-	
+
 				case SND_BELL:
 					sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_BELLOFF - value);
 					return 0;
@@ -210,7 +210,7 @@
 	wait_event_interruptible_timeout(sunkbd->wait, sunkbd->reset >= 0, HZ);
 
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_SETLED);
-	sunkbd->serio->write(sunkbd->serio, 
+	sunkbd->serio->write(sunkbd->serio,
 		(!!test_bit(LED_CAPSL, sunkbd->dev.led) << 3) | (!!test_bit(LED_SCROLLL, sunkbd->dev.led) << 2) |
 		(!!test_bit(LED_COMPOSE, sunkbd->dev.led) << 1) | !!test_bit(LED_NUML, sunkbd->dev.led));
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_NOCLICK - !!test_bit(SND_CLICK, sunkbd->dev.snd));
@@ -231,7 +231,7 @@
 
 	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
 		return;
-	
+
 	if (!(sunkbd = kmalloc(sizeof(struct sunkbd), GFP_KERNEL)))
 		return;
 
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-06-07 13:11:23 +02:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-06-07 13:11:23 +02:00
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
@@ -43,7 +43,7 @@
 #define XTKBD_KEY	0x7f
 #define XTKBD_RELEASE	0x80
 
-static unsigned char xtkbd_keycode[256] = {	 
+static unsigned char xtkbd_keycode[256] = {
 	  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
 	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
@@ -98,7 +98,7 @@
 		return;
 
 	memset(xtkbd, 0, sizeof(struct xtkbd));
-	
+
 	xtkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 
 	xtkbd->serio = serio;

