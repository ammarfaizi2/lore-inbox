Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130176AbRBOU6N>; Thu, 15 Feb 2001 15:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130178AbRBOU6D>; Thu, 15 Feb 2001 15:58:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60090 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S130176AbRBOU5s>;
	Thu, 15 Feb 2001 15:57:48 -0500
Date: Thu, 15 Feb 2001 15:57:09 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.1-ac$x and timer oddities
Message-ID: <Pine.LNX.4.33.0102151510010.2238-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine boots and runs for some time without problems, but then
something makes the clock *very* jittery:

*  xscreensaver kicks in after almost no time (even betwixt quick
   keystrokes and in the middle of mouse movement), and the password prompt
   timer zips down to nothing post haste
*  neworking apps gets a time-out on almost all connections (netscape, ftp, etc)
*  It can take quite a while for focus to change after moving the mouse
*  The machine will hang (hard - CAD or SYSREQ B do nothing) after a
   variable amount of time (>8 hours)

I think this may've even started at 2.4.0, but seems to have gotten
worse recently.

Linux badlands.lexington.ibm.com 2.4.1-ac13 #7 Wed Feb 14 11:41:50 EST
2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10q
modutils               2.4.1
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc ipx af_packet netlink_dev
softdog olympic dummy0 usbcore maestro3 soundcore ac97_codec ipchains
eeprom sensors i2c-viapro i2c-core agpgart ipv6 unix

I have apm and acpi compiled in, but turned off:

Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=308 reboot=w apm=off acpi=off console=ttyS0,9600 console=tty0
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
enabled ExtINT on CPU#0
PCI: PCI BIOS revision 2.10 entry at 0xfd7ec, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0596] at 00:02.0
Activating ISA DMA hang workarounds
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
apm: disabled on user request.
VP_IDE: IDE controller on PCI bus 00 dev 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:02.1
ACPI: Disabled

$ /lib/libc.so.6
GNU C Library stable release version 2.2.2, by Roland McGrath et al.
Copyright (C) 1992-1999, 2000, 2001 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 2.95.3 20010125 (prerelease).
Compiled on a Linux 2.4.2-pre2 system on 2001-02-12.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others
        linuxthreads-0.9 by Xavier Leroy
        BIND-8.2.3-T5B
        libthread_db work sponsored by Alpha Processor Inc
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
Report bugs using the `glibcbug' script to <bugs@gnu.org>.

XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 18 December 2000
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

