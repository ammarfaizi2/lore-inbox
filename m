Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265658AbSJSSwg>; Sat, 19 Oct 2002 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265659AbSJSSwg>; Sat, 19 Oct 2002 14:52:36 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:48091 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265658AbSJSSwe>; Sat, 19 Oct 2002 14:52:34 -0400
Date: Sat, 19 Oct 2002 14:58:37 -0400
From: robert swan <rswan@sympatico.ca>
To: acher@in.tum.de, deti@fliegl.de
Cc: linux-kernel@vger.kernel.org
Subject: usb joystick causing kernel panic
Message-Id: <20021019145837.30bbc89b.rswan@sympatico.ca>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

I get a kernel panic when I "cat /dev/js0". The panic occurs using linux-2.4.19 only. 2.4.18 works fine. Further, it seems that the panic doesn't occur with certain sequences of unloading/loading the usb-uhci module and plugging/unplugging the joystick. I haven't recorded which sequences cause kernel panic but I can try to do so if it might help. The default sequence of having the joystick plugged in when the kernel boots, and the module getting loaded at boot time via the "hot-plug" scripts, causes the kernel panic.

Hardware
--------
 - Motherboard: Abit KG7 Motherboard, AMD761/VIA VT82C686B chipset
 - joystick: Logitech Wingman Rumblepad

Software
--------

In general, I'm running a Debian system. Output from linux-2.4.19/scripts/ver_linux:

Linux naws 2.4.19 #1 Sat Oct 19 12:46:52 EDT 2002 i686 AMD Athlon(tm) 4 processor AuthenticAMD GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.30-WIP
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.0.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         parport_pc lp parport binfmt_misc af_packet usb-uhci ospm_processor ospm_system ospm_button ospm_busmgr emu10k1 ac97_codec sound via-rhine mii rtc

Bug Occurrances
---------------
 - kernel panic happens only with kernel 2.4.19, kernel 2.4.18 is fine
 - kernel panic happens with either usb-uhci or uhci
 - kernel panic happens only with this particular joystick, I have another joystick which doesn't cause kp
 - kp happen immediately upon reading /dev/js0, i.e. cat /dev/js0 causes immediate panic.

Kernel Panic Message
--------------------

I wrote down some of the kernel panic message. I don't have the complete exact message. If I do a cat /dev/js0 in the console, the joystick spews out a few bytes (~80 characters worth), then the messages are: 
divide error 0000
CPU: 0
EIP: 0010:[<C01f3f127>] Not tainted
EFLAGS: 00010 286
eax 0000008, ebx 0 ecx 8 edx 0 
 . . .
<0> Kernel Panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Thats it. I just beeps after that. I'm not sure what else to say. Let me know if I should provide any other information.

Robert

