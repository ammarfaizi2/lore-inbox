Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSJVO2t>; Tue, 22 Oct 2002 10:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJVO2t>; Tue, 22 Oct 2002 10:28:49 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36072 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262580AbSJVO2s>;
	Tue, 22 Oct 2002 10:28:48 -0400
Date: Tue, 22 Oct 2002 16:34:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Take Vos <Take.Vos@binary-magic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Message-ID: <20021022163453.A22665@ucw.cz>
References: <200210221603.54816.Take.Vos@binary-magic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210221603.54816.Take.Vos@binary-magic.com>; from Take.Vos@binary-magic.com on Tue, Oct 22, 2002 at 04:03:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:03:49PM +0200, Take Vos wrote:

> I just upgraded to 2.5.44 from 2.5.43.
> 
> In 2.5.43 I had a small PS/2 mouse problem, as it din't see my wart but only 
> my scratch pad.

Known bug, still trying to find out why this happens. Any chance your
notebook has an IBM touchpad?

> In 2.5.44 both my PS/2 mice are not available, neither is my keyboard, 
> although after sufficient keystrokes, sometimes 5, sometimes more, the 
> keyboard is found, this is with Xfree. 

Interesting.

> Here is some relevant dmesg information.
> 	--snip--
> 	drivers/usb/core/usb.c: registered new driver hid
> 	drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> 	drivers/usb/core/usb.c: registered new driver usbscanner
> 	drivers/usb/image/scanner.c: 0.4.6:USB Scanner Driver
> 	register interface 'mouse' with class 'input
> 	mice: PS/2 mouse device common for all mice
> 	register interface 'joystick' with class 'input
> 	register interface 'event' with class 'input
> 	serio: i8042 AUX port at 0x60,0x64 irq 12
> 	serio: i8042 KBD port at 0x60,0x64 irq 1
> 	--snip--
> 	MTRR: setting reg 3
> 	atkbd.c: Unknown key (set 0, scancode 0xf0, on isa0060/serio0) pressed.
> 	atkbd.c: Unknown key (set 0, scancode 0x4b, on isa0060/serio0) pressed.
> 	atkbd.c: Unknown key (set 0, scancode 0x43, on isa0060/serio0) pressed.
> 	atkbd.c: Unknown key (set 0, scancode 0xf0, on isa0060/serio0) pressed.
> 	atkbd.c: Unknown key (set 0, scancode 0x43, on isa0060/serio0) pressed.
> 	input: AT Set 2 keyboard on isa0060/serio0
> 

Very interesting.

> The last time I booted in 2.5.44 the keyboard was found after about 20 
> keystrokes but was useless as it produced weird escape sequences instead of 
> normal characters, this was without XFree (to check if it had something to do 
> with that).

Can you try with #define DEBUG in i8042.c?

-- 
Vojtech Pavlik
SuSE Labs
