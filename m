Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTG1X4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTG1X4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:56:03 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:14980 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S270230AbTG1X4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:56:00 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Mon, 28 Jul 2003 20:55:56 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: PS/2 mouse and 2.6.0-test2
Message-ID: <Pine.LNX.4.56.0307282040000.193@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this should go in a separate e-mail (I sent another
about matroxfb).

2.6.0-test2 is the first 2.5.x I try, so I may be missing
something.

I have a Logitech PS/2 Wheel Optical (the blue, and probably
falsified) which works fine with 2.4.21. With 2.6.0-test2 I get
the following in the logs:

Jul 28 19:15:04 pervalidus /usr/sbin/gpm[83]: *** info [startup.c(150)]:
Jul 28 19:15:04 pervalidus /usr/sbin/gpm[83]: Started gpm successfully. Entered daemon mode.
Jul 28 19:15:04 pervalidus modprobe: FATAL: Module /dev/gpmctl not found.
Jul 28 19:15:04 pervalidus modprobe: FATAL: Module /dev/gpmctl not found.

Yes, /dev/gpmctl is missing. gpm is called with -m /dev/misc/psaux -t ps/2 -S "/sbin/shutdown -r -t30 +3:telinit 1:"

When I move it (I don't even press a button) it moves very fast
and may even execute the first -S command, what would require
pressing both buttons 3 times followed by the left. The same if
I killall gpm and use the mouse in XFree86. Then it starts rxvt
etc.

My .config and dmesg are at
http://www.pervalidus.net/tmp/.config-2.6.0-test2.txt
http://www.pervalidus.net/tmp/dmesg-2.6.0-test2.txt
http://www.pervalidus.net/tmp/dmesg-2.6.0-acpi=off+noapic-test2.txt

The relevant part:

mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
