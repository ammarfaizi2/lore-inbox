Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbSJJXaV>; Thu, 10 Oct 2002 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbSJJXaV>; Thu, 10 Oct 2002 19:30:21 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:20696 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262176AbSJJXaU>; Thu, 10 Oct 2002 19:30:20 -0400
Message-Id: <5.1.0.14.2.20021010161714.05a06c30@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 16:36:01 -0700
To: linux-kernel@vger.kernel.org
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Armada M700 keyboard and mouse not working with latest BK 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I've got Compaq Armada M700 laptop here. Keyboard and mouse(touch point 
actually)
are acting pretty strange with latest BK 2.5. I tried 2.5.40 and 41, 
results are
the same. 2.4.x has absolutely no problems.

Basically, mouse doesn't move at all, both with X and gpm. And keyboard 
generates
completely wrong codes. I press 'Ctrl' and get 't' instead, 'Alt' -> 'w', etc
most of the alpha keys generate total crap (non printable).

Here is what dmesg has to say about input devices

register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev-15.0.
serio: i8042  port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

And sometimes I get this

atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x18, on isa0060/serio0) released.

And here is input section of my .config

# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

Machine is ok otherwise (telnet and stuff).

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

