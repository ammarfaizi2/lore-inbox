Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbSJBRAo>; Wed, 2 Oct 2002 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbSJBRAn>; Wed, 2 Oct 2002 13:00:43 -0400
Received: from [212.18.235.100] ([212.18.235.100]:21170 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S263186AbSJBRAh>; Wed, 2 Oct 2002 13:00:37 -0400
From: kernel@street-vision.com
Message-Id: <200210021704.g92H4iv15803@tench.street-vision.com>
Subject: trivial 2.5.40 input patch
To: linuxconsole-dev@lists.sourceforge.net
Date: Wed, 2 Oct 2002 17:04:43 +0000 (GMT)
Cc: jsimmons@maxwell.earthlink.net.street-vision.com,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a very small patch for module license, Config.help and my email
address in drivers/input/keyboard in 2.5.40. Tested the newtonkbd driver
and it is fine.

diff -urN linux-2.5.40-orig/drivers/input/keyboard/Config.help linux-2.5.40/drivers/input/keyboard/Config.help
--- linux-2.5.40-orig/drivers/input/keyboard/Config.help	Tue Oct  1 07:06:27 2002
+++ linux-2.5.40/drivers/input/keyboard/Config.help	Wed Oct  2 16:19:26 2002
@@ -43,7 +43,7 @@
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will be called maple_keyb.o. If you want to compile it as a
+  The module will be called newtonkbd.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
 CONFIG_KEYBOARD_MAPLE  
diff -urN linux-2.5.40-orig/drivers/input/keyboard/maple_keyb.c linux-2.5.40/drivers/input/keyboard/maple_keyb.c
--- linux-2.5.40-orig/drivers/input/keyboard/maple_keyb.c	Tue Oct  1 07:06:29 2002
+++ linux-2.5.40/drivers/input/keyboard/maple_keyb.c	Wed Oct  2 17:00:07 2002
@@ -14,6 +14,7 @@
 
 MODULE_AUTHOR("YAEGASHI Takeshi <t@keshi.org>");
 MODULE_DESCRIPTION("SEGA Dreamcast keyboard driver");
+MODULE_LICENSE("GPL");
 
 static unsigned char dc_kbd_keycode[256] = {
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
diff -urN linux-2.5.40-orig/drivers/input/keyboard/newtonkbd.c linux-2.5.40/drivers/input/keyboard/newtonkbd.c
--- linux-2.5.40-orig/drivers/input/keyboard/newtonkbd.c	Tue Oct  1 07:05:46 2002
+++ linux-2.5.40/drivers/input/keyboard/newtonkbd.c	Wed Oct  2 16:24:37 2002
@@ -1,29 +1,10 @@
 /*
- *  Copyright (c) 2000 Justin Cormack
+ *  Copyright (c) 2000 Justin Cormack <justin@street-vision.com>
  */
 
 /*
- * Newton keyboard driver for Linux
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <j.cormack@doc.ic.ac.uk>, or by paper mail:
- * Justin Cormack, 68 Dartmouth Park Road, London NW5 1SN, UK.
+ * Apple Newton serial keyboard driver for Linux
+ * Also works for compatible serial keyboards eg KeySync
  */
 
 #include <linux/slab.h>
@@ -32,7 +13,9 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 
-MODULE_AUTHOR("Justin Cormack <j.cormack@doc.ic.ac.uk>");
+MODULE_AUTHOR("Justin Cormack <justin@street-vision.com>");
+MODULE_DESCRIPTION("Newton keyboard driver");
+MODULE_LICENSE("GPL");
 
 #define NKBD_KEY	0x7f
 #define NKBD_PRESS	0x80
