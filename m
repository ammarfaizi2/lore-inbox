Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRDYVpF>; Wed, 25 Apr 2001 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRDYVoz>; Wed, 25 Apr 2001 17:44:55 -0400
Received: from www.teaparty.net ([216.235.253.180]:16394 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132616AbRDYVol>;
	Wed, 25 Apr 2001 17:44:41 -0400
Date: Wed, 25 Apr 2001 22:44:37 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/usb/hid.c
Message-ID: <Pine.LNX.4.10.10104252235460.2687-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi: Been battling w. my new Gravis joystick [kernel 2.4.3-ac5] - the
driver wouldn't recognise it through the gameport, but would through the
USB port [the stick came with a converter]. I did have one problem though:
I had to apply the following one line patch to get the joystick hat to
work correctly: Don't know if this is generally correct, as I only have
one USB joystick with which to test it.

--- linux/drivers/usb/hid.c~	Sat Apr 21 20:34:33 2001
+++ linux/drivers/usb/hid.c	Sat Apr 21 20:38:51 2001
@@ -78,7 +78,7 @@
 static struct {
 	__s32 x;
 	__s32 y;
-}  hid_hat_to_axis[] = {{ 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}, { 0, 0}};
+}  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};


-- 
I've had a perfectly wonderful evening.  But this wasn't it.
                -- Groucho Marx


