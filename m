Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbTCIEK5>; Sat, 8 Mar 2003 23:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262417AbTCIEK5>; Sat, 8 Mar 2003 23:10:57 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:42112 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262410AbTCIEKu>; Sat, 8 Mar 2003 23:10:50 -0500
Date: Sun, 9 Mar 2003 13:20:57 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (8/20) input update
Message-ID: <20030309042057.GI1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (8/20)

Updates drivers for PC98 standard keyboard.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac1/drivers/input/keyboard/98kbd.c linux98-2.5.64/drivers/input/keyboard/98kbd.c
--- linux-2.5.64-ac1/drivers/input/keyboard/98kbd.c	2003-03-07 08:52:02.000000000 +0900
+++ linux98-2.5.64/drivers/input/keyboard/98kbd.c	2003-03-06 10:37:36.000000000 +0900
@@ -109,7 +109,8 @@
 	struct jis_kbd_conv jis[16];
 };
 
-void kbd98_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+void kbd98_interrupt(struct serio *serio, unsigned char data,
+			unsigned int flags, struct pt_regs *regs)
 {
 	struct kbd98 *kbd98 = serio->private;
 	unsigned char scancode, keycode;
