Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUAUELm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265988AbUAUELm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:11:42 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:33119 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265984AbUAUELY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:11:24 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: [keyboard] current 2.6.1-bk6 yet not merged kbd.patch
Date: Wed, 21 Jan 2004 01:11:38 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KHdDAlNlsdjQEfS"
Message-Id: <200401210111.39050.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KHdDAlNlsdjQEfS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I upgrade my 2.6.1 to 2.6.1-bk6,

I found in diffview on kernel.org
------------------------------------------------------------------------------------
 drivers/input/keyboard/atkbd.c                        10 +      28 -       0 !
 drivers/input/keyboard/maple_keyb.c                    1 +       0 -       0 !
 drivers/input/keyboard/newtonkbd.c                     2 +       0 -       0 !
-----------------------------------------------------------------------------------

But attached patch yet not merged......    without this, abnt2 keyboard not work "/" and "?".

Please merge this before 2.6.2 :)

Thanks

--Boundary-00=_KHdDAlNlsdjQEfS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kbd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kbd.patch"

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/char/keyboard.c	Thu Jan 15 00:16:47 2004
@@ -941,14 +941,14 @@
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
 	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
+	 80, 81, 82, 83, 84,118, 86, 87, 88,115,120,119,121,112,123, 92,
+	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
+	367,288,302,304,350, 89,334,326,267,126,268,269,125,347,348,349,
 	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
 	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,113,114,
-	264,117,271,374,379,115,125,273,121,123, 92,265,266,267,268,269,
-	120,119,118,277,278,282,283,295,296,297,299,300,301,293,303,307,
+	264,117,271,374,379,265,266, 93, 94, 95, 85,259,375,260, 90,116,
+	377,109,111,277,278,282,283,295,296,297,299,300,301,293,303,307,
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
 
@@ -978,10 +978,10 @@
 			put_queue(vc, 0x1d | up_flag);
 			put_queue(vc, 0x45 | up_flag);
 			return 0;
-		case KEY_LANG1:
+		case KEY_HANGUEL:
 			if (!up_flag) put_queue(vc, 0xf1);
 			return 0;
-		case KEY_LANG2:
+		case KEY_HANJA:
 			if (!up_flag) put_queue(vc, 0xf2);
 			return 0;
 	} 
diff -Nru a/drivers/input/keyboard/98kbd.c b/drivers/input/keyboard/98kbd.c
--- a/drivers/input/keyboard/98kbd.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/input/keyboard/98kbd.c	Thu Jan 15 00:16:47 2004
@@ -47,9 +47,9 @@
 	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
 	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 41, 26, 28, 30, 31, 32,
 	 33, 34, 35, 36, 37, 38, 39, 40, 27, 44, 45, 46, 47, 48, 49, 50,
-	 51, 52, 53, 12, 57,184,109,104,110,111,103,105,106,108,102,107,
-	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,124,
-	 83,185, 87, 88, 85, 89, 90,  0,  0,  0,  0,  0,  0,  0,102,  0,
+	 51, 52, 53, 12, 57, 92,109,104,110,111,103,105,106,108,102,107,
+	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,121,
+	 83, 94, 87, 88,183,184,185,  0,  0,  0,  0,  0,  0,  0,102,  0,
 	 99,133, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,  0,  0,  0,  0,
 	 54, 58, 42, 56, 29
 };
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jan 15 00:16:47 2004
@@ -50,12 +50,12 @@
 static unsigned char atkbd_set2_keycode[512] = {
 
 	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
-	  0, 56, 42,182, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
-	  0, 46, 45, 32, 18,  5,  4,186,  0, 57, 47, 33, 20, 19,  6, 85,
-	  0, 49, 48, 35, 34, 21,  7, 89,  0,  0, 50, 36, 22,  8,  9, 90,
+	  0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
+	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
+	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-	  0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
-	  0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
+	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
+	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
@@ -77,11 +77,11 @@
 	134, 46, 45, 32, 18,  5,  4, 63,135, 57, 47, 33, 20, 19,  6, 64,
 	136, 49, 48, 35, 34, 21,  7, 65,137,100, 50, 36, 22,  8,  9, 66,
 	125, 51, 37, 23, 24, 11, 10, 67,126, 52, 53, 38, 39, 25, 12, 68,
-	113,114, 40, 84, 26, 13, 87, 99, 97, 54, 28, 27, 43, 84, 88, 70,
+	113,114, 40, 43, 26, 13, 87, 99, 97, 54, 28, 27, 43, 43, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
-	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
+	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55,183,
 
-	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
+	184,185,186,187, 74, 94, 92, 93,  0,  0,  0,125,126,127,112,  0,
 	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
 	148,149,147,140
 };
@@ -236,10 +236,10 @@
 			atkbd->release = 1;
 			goto out;
 		case ATKBD_RET_HANGUEL:
-			atkbd_report_key(&atkbd->dev, regs, KEY_LANG1, 3);
+			atkbd_report_key(&atkbd->dev, regs, KEY_HANGUEL, 3);
 			goto out;
 		case ATKBD_RET_HANJA:
-			atkbd_report_key(&atkbd->dev, regs, KEY_LANG2, 3);
+			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
 			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
diff -Nru a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
--- a/drivers/input/keyboard/maple_keyb.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/input/keyboard/maple_keyb.c	Thu Jan 15 00:16:47 2004
@@ -19,13 +19,13 @@
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
 	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
 	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 84, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
 	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
 	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
-	 72, 73, 82, 83, 86,127,116,117, 85, 89, 90, 91, 92, 93, 94, 95,
-	120,121,122,123,134,138,130,132,128,129,131,137,133,135,136,113,
-	115,114,  0,  0,  0,124,  0,181,182,183,184,185,186,187,188,189,
-	190,191,192,193,194,195,196,197,198,  0,  0,  0,  0,  0,  0,  0,
+	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
+	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
+	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
+	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
diff -Nru a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/macintosh/adbhid.c	Thu Jan 15 00:16:47 2004
@@ -69,8 +69,8 @@
 	 22, 26, 23, 25, 28, 38, 36, 40, 37, 39, 43, 51, 53, 49, 50, 52,
 	 15, 57, 41, 14, 96,  1, 29,125, 42, 58, 56,105,106,108,103,  0,
 	  0, 83,  0, 55,  0, 78,  0, 69,  0,  0,  0, 98, 96,  0, 74,  0,
-	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,183,181,124,
-	 63, 64, 65, 61, 66, 67,191, 87,190, 99,  0, 70,  0, 68,101, 88,
+	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,124, 89,121,
+	 63, 64, 65, 61, 66, 67,123, 87,122, 99,  0, 70,  0, 68,101, 88,
 	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,126,116
 };
 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/usb/input/hid-input.c	Thu Jan 15 00:16:47 2004
@@ -40,13 +40,13 @@
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
 	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
 	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 84, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
 	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
 	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
-	 72, 73, 82, 83, 86,127,116,117, 85, 89, 90, 91, 92, 93, 94, 95,
-	120,121,122,123,134,138,130,132,128,129,131,137,133,135,136,113,
-	115,114,unk,unk,unk,124,unk,181,182,183,184,185,186,187,188,189,
-	190,191,192,193,194,195,196,197,198,unk,unk,unk,unk,unk,unk,unk,
+	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
+	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
+	115,114,unk,unk,unk,121,unk, 89, 93,124, 92, 94, 95,unk,unk,unk,
+	122,123, 90, 91, 85,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
diff -Nru a/drivers/usb/input/usbkbd.c b/drivers/usb/input/usbkbd.c
--- a/drivers/usb/input/usbkbd.c	Thu Jan 15 00:16:47 2004
+++ b/drivers/usb/input/usbkbd.c	Thu Jan 15 00:16:47 2004
@@ -49,13 +49,13 @@
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
 	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
 	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 84, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
 	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
 	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
-	 72, 73, 82, 83, 86,127,116,117, 85, 89, 90, 91, 92, 93, 94, 95,
-	120,121,122,123,134,138,130,132,128,129,131,137,133,135,136,113,
-	115,114,  0,  0,  0,124,  0,181,182,183,184,185,186,187,188,189,
-	190,191,192,193,194,195,196,197,198,  0,  0,  0,  0,  0,  0,  0,
+	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
+	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
+	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
+	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Jan 15 00:16:47 2004
+++ b/include/linux/input.h	Thu Jan 15 00:16:47 2004
@@ -189,18 +189,18 @@
 #define KEY_KP3			81
 #define KEY_KP0			82
 #define KEY_KPDOT		83
-#define KEY_103RD		84
-#define KEY_F13			85
+
+#define KEY_ZENKAKUHANKAKU	85
 #define KEY_102ND		86
 #define KEY_F11			87
 #define KEY_F12			88
-#define KEY_F14			89
-#define KEY_F15			90
-#define KEY_F16			91
-#define KEY_F17			92
-#define KEY_F18			93
-#define KEY_F19			94
-#define KEY_F20			95
+#define KEY_ROMAJI		89
+#define KEY_KATAKANA		90
+#define KEY_HIRAGANA		91
+#define KEY_HENKAN		92
+#define KEY_KATAKANAHIRAGANA	93
+#define KEY_MUHENKAN		94
+#define KEY_KPJPCOMMA		95
 #define KEY_KPENTER		96
 #define KEY_RIGHTCTRL		97
 #define KEY_KPSLASH		98
@@ -225,11 +225,11 @@
 #define KEY_KPEQUAL		117
 #define KEY_KPPLUSMINUS		118
 #define KEY_PAUSE		119
-#define KEY_F21			120
-#define KEY_F22			121
-#define KEY_F23			122
-#define KEY_F24			123
-#define KEY_KPCOMMA		124
+
+#define KEY_KPCOMMA		121
+#define KEY_HANGUEL		122
+#define KEY_HANJA		123
+#define KEY_YEN			124
 #define KEY_LEFTMETA		125
 #define KEY_RIGHTMETA		126
 #define KEY_COMPOSE		127
@@ -288,24 +288,18 @@
 #define KEY_KPLEFTPAREN		179
 #define KEY_KPRIGHTPAREN	180
 
-#define KEY_INTL1		181
-#define KEY_INTL2		182
-#define KEY_INTL3		183
-#define KEY_INTL4		184
-#define KEY_INTL5		185
-#define KEY_INTL6		186
-#define KEY_INTL7		187
-#define KEY_INTL8		188
-#define KEY_INTL9		189
-#define KEY_LANG1		190
-#define KEY_LANG2		191
-#define KEY_LANG3		192
-#define KEY_LANG4		193
-#define KEY_LANG5		194
-#define KEY_LANG6		195
-#define KEY_LANG7		196
-#define KEY_LANG8		197
-#define KEY_LANG9		198
+#define KEY_F13			183
+#define KEY_F14			184
+#define KEY_F15			185
+#define KEY_F16			186
+#define KEY_F17			187
+#define KEY_F18			188
+#define KEY_F19			189
+#define KEY_F20			190
+#define KEY_F21			191
+#define KEY_F22			192
+#define KEY_F23			193
+#define KEY_F24			194
 
 #define KEY_PLAYCD		200
 #define KEY_PAUSECD		201

--Boundary-00=_KHdDAlNlsdjQEfS--
