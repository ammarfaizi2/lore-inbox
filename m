Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSJVOGK>; Tue, 22 Oct 2002 10:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSJVOGK>; Tue, 22 Oct 2002 10:06:10 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:61312 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262617AbSJVOGI> convert rfc822-to-8bit; Tue, 22 Oct 2002 10:06:08 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Date: Tue, 22 Oct 2002 16:03:49 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221603.54816.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

kernel: linux-2.5.44
hardware:DELL Inspiron 8100
config:
                CONFIG_INPUT_MOUSEDEV
                CONFIG_INPUT_EVDEV
                CONFIG_SERIO
                CONFIG_SERIO_I8042
                CONFIG_INPUT_MOUSE
                CONFIG_MOUSE_PS2
                CONFIG_USB
                CONFIG_USB_HID
                CONFIG_USB_HIDINPUT


I just upgraded to 2.5.44 from 2.5.43.

In 2.5.43 I had a small PS/2 mouse problem, as it din't see my wart but only 
my scratch pad.

In 2.5.44 both my PS/2 mice are not available, neither is my keyboard, 
although after sufficient keystrokes, sometimes 5, sometimes more, the 
keyboard is found, this is with Xfree. 

Here is some relevant dmesg information.
	--snip--
	drivers/usb/core/usb.c: registered new driver hid
	drivers/usb/input/hid-core.c: v2.0:USB HID core driver
	drivers/usb/core/usb.c: registered new driver usbscanner
	drivers/usb/image/scanner.c: 0.4.6:USB Scanner Driver
	register interface 'mouse' with class 'input
	mice: PS/2 mouse device common for all mice
	register interface 'joystick' with class 'input
	register interface 'event' with class 'input
	serio: i8042 AUX port at 0x60,0x64 irq 12
	serio: i8042 KBD port at 0x60,0x64 irq 1
	--snip--
	MTRR: setting reg 3
	atkbd.c: Unknown key (set 0, scancode 0xf0, on isa0060/serio0) pressed.
	atkbd.c: Unknown key (set 0, scancode 0x4b, on isa0060/serio0) pressed.
	atkbd.c: Unknown key (set 0, scancode 0x43, on isa0060/serio0) pressed.
	atkbd.c: Unknown key (set 0, scancode 0xf0, on isa0060/serio0) pressed.
	atkbd.c: Unknown key (set 0, scancode 0x43, on isa0060/serio0) pressed.
	input: AT Set 2 keyboard on isa0060/serio0


The last time I booted in 2.5.44 the keyboard was found after about 20 
keystrokes but was useless as it produced weird escape sequences instead of 
normal characters, this was without XFree (to check if it had something to do 
with that).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tVrJMMlizP1UqoURAqITAJ9kCyLQ/uwafy7YfBvZ4ZVwlgJlgACfa1YD
7Uztmq/LJcnCZpKcFK7xnwQ=
=uKZw
-----END PGP SIGNATURE-----

