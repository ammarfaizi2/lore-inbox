Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUDMIsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUDMIr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:47:56 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:41266 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263322AbUDMIib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:31 -0400
Date: Tue, 13 Apr 2004 10:38:13 +0200
Message-Id: <200404130838.i3D8cDmV018473@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 432] Amikbd C99 cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amikbd: Use C99 array initializers and standard key defines

--- linux-2.6.5-rc2/drivers/input/keyboard/amikbd.c	2004-01-27 21:52:26.000000000 +0100
+++ linux-m68k-2.6.5-rc2/drivers/input/keyboard/amikbd.c	2004-03-28 13:31:55.000000000 +0200
@@ -46,24 +46,113 @@
 MODULE_LICENSE("GPL");
 
 static unsigned char amikbd_keycode[0x78] = {
-	 41,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43,  0, 82,
-	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  0, 79, 80, 81,
-	 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 43,  0, 75, 76, 77,
-	 86, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,  0, 83, 71, 72, 73,
-	 57, 14, 15, 96, 28,  1,111,  0,  0,  0, 74,  0,103,108,106,105,
-	 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,179,180, 98, 55, 78,138,
-	 42, 54, 58, 29, 56,100,125,126
+	[0]	 = KEY_GRAVE,
+	[1]	 = KEY_1,
+	[2]	 = KEY_2,
+	[3]	 = KEY_3,
+	[4]	 = KEY_4,
+	[5]	 = KEY_5,
+	[6]	 = KEY_6,
+	[7]	 = KEY_7,
+	[8]	 = KEY_8,
+	[9]	 = KEY_9,
+	[10]	 = KEY_0,
+	[11]	 = KEY_MINUS,
+	[12]	 = KEY_EQUAL,
+	[13]	 = KEY_BACKSLASH,
+	[15]	 = KEY_KP0,
+	[16]	 = KEY_Q,
+	[17]	 = KEY_W,
+	[18]	 = KEY_E,
+	[19]	 = KEY_R,
+	[20]	 = KEY_T,
+	[21]	 = KEY_Y,
+	[22]	 = KEY_U,
+	[23]	 = KEY_I,
+	[24]	 = KEY_O,
+	[25]	 = KEY_P,
+	[26]	 = KEY_LEFTBRACE,
+	[27]	 = KEY_RIGHTBRACE,
+	[29]	 = KEY_KP1,
+	[30]	 = KEY_KP2,
+	[31]	 = KEY_KP3,
+	[32]	 = KEY_A,
+	[33]	 = KEY_S,
+	[34]	 = KEY_D,
+	[35]	 = KEY_F,
+	[36]	 = KEY_G,
+	[37]	 = KEY_H,
+	[38]	 = KEY_J,
+	[39]	 = KEY_K,
+	[40]	 = KEY_L,
+	[41]	 = KEY_SEMICOLON,
+	[42]	 = KEY_APOSTROPHE,
+	[43]	 = KEY_BACKSLASH,
+	[45]	 = KEY_KP4,
+	[46]	 = KEY_KP5,
+	[47]	 = KEY_KP6,
+	[48]	 = KEY_102ND,
+	[49]	 = KEY_Z,
+	[50]	 = KEY_X,
+	[51]	 = KEY_C,
+	[52]	 = KEY_V,
+	[53]	 = KEY_B,
+	[54]	 = KEY_N,
+	[55]	 = KEY_M,
+	[56]	 = KEY_COMMA,
+	[57]	 = KEY_DOT,
+	[58]	 = KEY_SLASH,
+	[60]	 = KEY_KPDOT,
+	[61]	 = KEY_KP7,
+	[62]	 = KEY_KP8,
+	[63]	 = KEY_KP9,
+	[64]	 = KEY_SPACE,
+	[65]	 = KEY_BACKSPACE,
+	[66]	 = KEY_TAB,
+	[67]	 = KEY_KPENTER,
+	[68]	 = KEY_ENTER,
+	[69]	 = KEY_ESC,
+	[70]	 = KEY_DELETE,
+	[74]	 = KEY_KPMINUS,
+	[76]	 = KEY_UP,
+	[77]	 = KEY_DOWN,
+	[78]	 = KEY_RIGHT,
+	[79]	 = KEY_LEFT,
+	[80]	 = KEY_F1,
+	[81]	 = KEY_F2,
+	[82]	 = KEY_F3,
+	[83]	 = KEY_F4,
+	[84]	 = KEY_F5,
+	[85]	 = KEY_F6,
+	[86]	 = KEY_F7,
+	[87]	 = KEY_F8,
+	[88]	 = KEY_F9,
+	[89]	 = KEY_F10,
+	[90]	 = KEY_KPLEFTPAREN,
+	[91]	 = KEY_KPRIGHTPAREN,
+	[92]	 = KEY_KPSLASH,
+	[93]	 = KEY_KPASTERISK,
+	[94]	 = KEY_KPPLUS,
+	[95]	 = KEY_HELP,
+	[96]	 = KEY_LEFTSHIFT,
+	[97]	 = KEY_RIGHTSHIFT,
+	[98]	 = KEY_CAPSLOCK,
+	[99]	 = KEY_LEFTCTRL,
+	[100]	 = KEY_LEFTALT,
+	[101]	 = KEY_RIGHTALT,
+	[102]	 = KEY_LEFTMETA,
+	[103]	 = KEY_RIGHTMETA
 };
 
 static const char *amikbd_messages[8] = {
-	KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
-	KERN_WARNING "amikbd: keyboard lost sync\n",
-	KERN_WARNING "amikbd: keyboard buffer overflow\n",
-	KERN_WARNING "amikbd: keyboard controller failure\n",
-	KERN_ERR "amikbd: keyboard selftest failure\n",
-	KERN_INFO "amikbd: initiate power-up key stream\n",
-	KERN_INFO "amikbd: terminate power-up key stream\n",
-	KERN_WARNING "amikbd: keyboard interrupt\n"
+	[0] = KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
+	[1] = KERN_WARNING "amikbd: keyboard lost sync\n",
+	[2] = KERN_WARNING "amikbd: keyboard buffer overflow\n",
+	[3] = KERN_WARNING "amikbd: keyboard controller failure\n",
+	[4] = KERN_ERR "amikbd: keyboard selftest failure\n",
+	[5] = KERN_INFO "amikbd: initiate power-up key stream\n",
+	[6] = KERN_INFO "amikbd: terminate power-up key stream\n",
+	[7] = KERN_WARNING "amikbd: keyboard interrupt\n"
 };
 
 static struct input_dev amikbd_dev;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
