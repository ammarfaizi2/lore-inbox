Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUCWXQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUCWXQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:16:09 -0500
Received: from havoc.gtf.org ([216.162.42.101]:30620 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262914AbUCWXP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:15:28 -0500
Date: Tue, 23 Mar 2004 18:15:27 -0500
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] UTF-8ifying the kernel sources
Message-ID: <20040323231527.GD25510@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ur linux-2.6.4/Documentation/i2c/i2c-protocol linux-utf8-wrong/Documentation/i2c/i2c-protocol
--- linux-2.6.4/Documentation/i2c/i2c-protocol	2003-07-14 05:38:06.000000000 +0200
+++ linux-utf8-wrong/Documentation/i2c/i2c-protocol	2004-03-04 11:49:41.000000000 +0100
@@ -68,7 +68,7 @@
 
   Flags I2C_M_IGNORE_NAK
     Normally message is interrupted immediately if there is [NA] from the
-    client. Setting this flag treats any [NA] as�[A], and all of
+    client. Setting this flag treats any [NA] as [A], and all of
     message is sent.
     These messages may still fail to SCL lo->hi timeout.
 
diff -ur linux-2.6.4/arch/arm/nwfpe/fpopcode.h linux-utf8-wrong/arch/arm/nwfpe/fpopcode.h
--- linux-2.6.4/arch/arm/nwfpe/fpopcode.h	2004-02-16 01:00:09.000000000 +0100
+++ linux-utf8-wrong/arch/arm/nwfpe/fpopcode.h	2004-03-05 23:19:03.000000000 +0100
@@ -79,11 +79,11 @@
 +-------------------------+---+---+---------+---------+
 |  Precision              | u | v | FPSR.EP | length  |
 +-------------------------+---+---+---------+---------+
-| Single                  | 0 � 0 |    x    | 1 words |
-| Double                  | 1 � 1 |    x    | 2 words |
-| Extended                | 1 � 1 |    x    | 3 words |
-| Packed decimal          | 1 � 1 |    0    | 3 words |
-| Expanded packed decimal | 1 � 1 |    1    | 4 words |
+| Single                  | 0 | 0 |    x    | 1 words |
+| Double                  | 1 | 1 |    x    | 2 words |
+| Extended                | 1 | 1 |    x    | 3 words |
+| Packed decimal          | 1 | 1 |    0    | 3 words |
+| Expanded packed decimal | 1 | 1 |    1    | 4 words |
 +-------------------------+---+---+---------+---------+
 Note: x = don't care
 */
@@ -93,10 +93,10 @@
 +---+---+---------------------------------+
 | w | x | Number of registers to transfer |
 +---+---+---------------------------------+
-| 0 � 1 |  1                              |
-| 1 � 0 |  2                              |
-| 1 � 1 |  3                              |
-| 0 � 0 |  4                              |
+| 0 | 1 |  1                              |
+| 1 | 0 |  2                              |
+| 1 | 1 |  3                              |
+| 0 | 0 |  4                              |
 +---+---+---------------------------------+
 */
 
@@ -157,10 +157,10 @@
 +-------------------------+---+---+
 |  Rounding Precision     | e | f |
 +-------------------------+---+---+
-| IEEE Single precision   | 0 � 0 |
-| IEEE Double precision   | 0 � 1 |
-| IEEE Extended precision | 1 � 0 |
-| undefined (trap)        | 1 � 1 |
+| IEEE Single precision   | 0 | 0 |
+| IEEE Double precision   | 0 | 1 |
+| IEEE Extended precision | 1 | 0 |
+| undefined (trap)        | 1 | 1 |
 +-------------------------+---+---+
 */
 
@@ -169,10 +169,10 @@
 +---------------------------------+---+---+
 |  Rounding Mode                  | g | h |
 +---------------------------------+---+---+
-| Round to nearest (default)      | 0 � 0 |
-| Round toward plus infinity      | 0 � 1 |
-| Round toward negative infinity  | 1 � 0 |
-| Round toward zero               | 1 � 1 |
+| Round to nearest (default)      | 0 | 0 |
+| Round toward plus infinity      | 0 | 1 |
+| Round toward negative infinity  | 1 | 0 |
+| Round toward zero               | 1 | 1 |
 +---------------------------------+---+---+
 */
 
diff -ur linux-2.6.4/arch/i386/kernel/cpu/cyrix.c linux-utf8-wrong/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.4/arch/i386/kernel/cpu/cyrix.c	2004-02-16 00:59:04.000000000 +0100
+++ linux-utf8-wrong/arch/i386/kernel/cpu/cyrix.c	2004-03-04 11:50:59.000000000 +0100
@@ -113,9 +113,9 @@
 
 	printk(KERN_INFO "Enable Memory access reorder on Cyrix/NSC processor.\n");
 	ccr3 = getCx86(CX86_CCR3);
-	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN� */
+	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
 
-	/* Load/Store Serialize to mem access disable (=reorder it)� */
+	/* Load/Store Serialize to mem access disable (=reorder it)  */
 	setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
 	/* set load/store serialize from 1GB to 4GB */
 	ccr3 |= 0xe0;
@@ -148,7 +148,7 @@
 	printk(KERN_INFO "Enable Incrementor on Cyrix/NSC processor.\n");
 
 	ccr3 = getCx86(CX86_CCR3);
-	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN� */
+	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
 	/* PCR1 -- Performance Control */
 	/* Incrementor on, whatever that is */
 	setCx86(CX86_PCR1, getCx86(CX86_PCR1) | 0x02);
diff -ur linux-2.6.4/drivers/video/amifb.c linux-utf8-wrong/drivers/video/amifb.c
--- linux-2.6.4/drivers/video/amifb.c	2004-03-22 14:19:24.000000000 +0100
+++ linux-utf8-wrong/drivers/video/amifb.c	2004-03-23 15:56:17.097431712 +0100
@@ -114,7 +114,7 @@
    +----------+---------------------------------------------+----------+-------+
    |          |                ^                            |          |       |
    |          |                |upper_margin                |          |       |
-   |          |                �                            |          |       |
+   |          |                ¥                            |          |       |
    +----------###############################################----------+-------+
    |          #                ^                            #          |       |
    |          #                |                            #          |       |
@@ -135,15 +135,15 @@
    |          #                |                            #          |       |
    |          #                |                            #          |       |
    |          #                |                            #          |       |
-   |          #                �                            #          |       |
+   |          #                ¥                            #          |       |
    +----------###############################################----------+-------+
    |          |                ^                            |          |       |
    |          |                |lower_margin                |          |       |
-   |          |                �                            |          |       |
+   |          |                ¥                            |          |       |
    +----------+---------------------------------------------+----------+-------+
    |          |                ^                            |          |       |
    |          |                |vsync_len                   |          |       |
-   |          |                �                            |          |       |
+   |          |                ¥                            |          |       |
    +----------+---------------------------------------------+----------+-------+
 
 
@@ -327,7 +327,7 @@
    CCIR -> PAL
    -----------
 
-      - a scanline is 64 �s long, of which 52.48 �s are visible. This is about
+      - a scanline is 64 µs long, of which 52.48 µs are visible. This is about
         736 visible 70 ns pixels per line.
       - we have 625 scanlines, of which 575 are visible (interlaced); after
         rounding this becomes 576.
@@ -335,7 +335,7 @@
    RETMA -> NTSC
    -------------
 
-      - a scanline is 63.5 �s long, of which 53.5 �s are visible.  This is about
+      - a scanline is 63.5 µs long, of which 53.5 µs are visible.  This is about
         736 visible 70 ns pixels per line.
       - we have 525 scanlines, of which 485 are visible (interlaced); after
         rounding this becomes 484.
@@ -802,7 +802,7 @@
 
 static u_short do_vmode_full = 0;	/* Change the Video Mode */
 static u_short do_vmode_pan = 0;	/* Update the Video Mode */
-static short do_blank = 0;		/* (Un)Blank the Screen (�1) */
+static short do_blank = 0;		/* (Un)Blank the Screen (±1) */
 static u_short do_cursor = 0;		/* Move the Cursor */
 
 
diff -ur linux-2.6.4/fs/ext2/xattr.c linux-utf8-wrong/fs/ext2/xattr.c
--- linux-2.6.4/fs/ext2/xattr.c	2004-02-16 02:55:14.000000000 +0100
+++ linux-utf8-wrong/fs/ext2/xattr.c	2004-03-04 11:58:40.000000000 +0100
@@ -21,7 +21,7 @@
  *
  *   +------------------+
  *   | header           |
- *   � entry 1          | |
+ *   | entry 1          | |
  *   | entry 2          | | growing downwards
  *   | entry 3          | v
  *   | four null bytes  |
diff -ur linux-2.6.4/fs/ext3/xattr.c linux-utf8-wrong/fs/ext3/xattr.c
--- linux-2.6.4/fs/ext3/xattr.c	2004-02-16 02:55:14.000000000 +0100
+++ linux-utf8-wrong/fs/ext3/xattr.c	2004-03-04 11:58:59.000000000 +0100
@@ -22,7 +22,7 @@
  *
  *   +------------------+
  *   | header           |
- *   � entry 1          | |
+ *   | entry 1          | |
  *   | entry 2          | | growing downwards
  *   | entry 3          | v
  *   | four null bytes  |
diff -ur linux-2.6.4/include/asm-m68k/atarihw.h linux-utf8-wrong/include/asm-m68k/atarihw.h
--- linux-2.6.4/include/asm-m68k/atarihw.h	2004-03-22 14:19:32.000000000 +0100
+++ linux-utf8-wrong/include/asm-m68k/atarihw.h	2004-03-23 15:58:35.562381840 +0100
@@ -2,7 +2,7 @@
 ** linux/atarihw.h -- This header defines some macros and pointers for
 **                    the various Atari custom hardware registers.
 **
-** Copyright 1994 by Bj�rn Brauel
+** Copyright 1994 by Björn Brauel
 **
 ** 5/1/94 Roman Hodek:
 **   Added definitions for TT specific chips.
diff -ur linux-2.6.4/include/asm-m68k/atariints.h linux-utf8-wrong/include/asm-m68k/atariints.h
--- linux-2.6.4/include/asm-m68k/atariints.h	2004-02-16 02:13:00.000000000 +0100
+++ linux-utf8-wrong/include/asm-m68k/atariints.h	2004-03-05 23:46:48.000000000 +0100
@@ -1,7 +1,7 @@
 /*
 ** atariints.h -- Atari Linux interrupt handling structs and prototypes
 **
-** Copyright 1994 by Bj�rn Brauel
+** Copyright 1994 by Björn Brauel
 **
 ** 5/2/94 Roman Hodek:
 **   TT interrupt definitions added.
diff -ur linux-2.6.4/include/linux/802_11.h linux-utf8-wrong/include/linux/802_11.h
--- linux-2.6.4/include/linux/802_11.h	2003-07-14 05:34:31.000000000 +0200
+++ linux-utf8-wrong/include/linux/802_11.h	2004-03-04 11:57:02.000000000 +0100
@@ -24,7 +24,7 @@
         {Due_Inactivity,	0xff," Disassociated due to inactivity "},\
         {AP_Overload,		0xff," Disassociated because AP is unable to handle all currently associated stations "},\
         {Class_2_from_NonAuth,	0xff," Class 2 frame received from non-Authenticated station"},\
-        {Class_3_from_NonAuth,	0xff," Class 3 frame received from non�Associated station"},\
+        {Class_3_from_NonAuth,	0xff," Class 3 frame received from non-Associated station"},\
         {Sender_Quits_BSS,	0xff," Disassociated because sending station is leaving (has left) BSS"},\
         {Association_requester_not_authenticated,0xff," Station requesting (Re)Association is not Authenticated with responding station"},\
         {Reserved10,		0xff," Reserved"},\
diff -ur linux-2.6.4/scripts/docproc.c linux-utf8-wrong/scripts/docproc.c
--- linux-2.6.4/scripts/docproc.c	2003-07-14 05:30:42.000000000 +0200
+++ linux-utf8-wrong/scripts/docproc.c	2004-03-04 11:57:37.000000000 +0100
@@ -238,7 +238,7 @@
 void extfunc(char * filename) { docfunctions(filename, FUNCTION);   }
 
 /*
- * Document sp�ecific function(s) in a file.
+ * Document specific function(s) in a file.
  * Call kernel-doc with the following parameters:
  * kernel-doc -docbook -function function1 [-function function2]
  */
