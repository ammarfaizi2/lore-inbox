Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTIDSDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTIDSB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:01:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7041 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265375AbTIDSAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:00:46 -0400
Date: Thu, 4 Sep 2003 14:03:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Lang <david.lang@digitalinsight.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: serial console on x86
In-Reply-To: <Pine.LNX.4.44.0309041023010.18624-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.53.0309041349140.7036@chaos>
References: <Pine.LNX.4.44.0309041023010.18624-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, David Lang wrote:

> On Thu, 4 Sep 2003, Richard B. Johnson wrote:
>
> > On Thu, 4 Sep 2003, David Lang wrote:
> >
> > > I am attempting to install linux (debian 3 based) on some dual athlon
> > > boxes with no video card. The BIOS does include serial console
> > > capabilities
> > >
> > > once the system is installed I have no problem booting from the hard
> > > drive, but when I attempt to boot from a CD to install (ISOLINUX custom
> > > boot disk) I see the lilo prompt, the loading kernel message, the loading
> > > initrd.gz message and then it prints 'Ready.' and reboots the same
> > > bootdisk will work just fine if I install a video card in the machine (and
> > > the same kernel with lilo boots just fine without a video card after it
> > > gets installed)
> > >
> > > any ideas why the kernel may crash before printing any messages in this
> > > situation? I've tried this with 2.4.17 and 2.4.22 with the exact same
> > > results.
> > >
> > > David Lang
> >
> > 	append="console=ttyS0,9600"
> > ... in the lilo configuration works fine in the exact same kernels
> > you cite. However, the CD install does not have the console changed
> > so it will probably not work. The BIOS is never used past the point
> > where the OS is physically loaded so it makes no difference
> > if you have "serial console capabilities" in the BIOS.
>
> I have a similar line in the lilo configuration. if there is a video card
> in the system this works and I see the kernel boot over the serial port,
> if there is not a video card it reboots instead of running the kernel.
>
> David Lang

Well I have a system sitting in the lab. On one machine that
was already up, I did cat /dev/ttyS0 >xxx.xxx.  The other machine,
which was connected to the serial port, I booted without a screen
card. This system boots off a NVRAM disk, which is installed
by the BIOS as a floppy drive so the machine "thinks" it's booting
a floppy.

                        Analogic AMD-SC520 BIOS
                  Copyright(c) 2000-2003 Analogic Corporation

Check screen memory.... failed
Check ROM checksum .... okay 001C3E00
Checking CMOS timer ... okay 01
Checking main timer ... okay 3578
Checking timer 2 ...... okay A804
Check PCI devices ..... 30001022 000010E3 8000104C 20001022
Check FDC operation ... okay 0000
Check virtual mode .... okay 0000
Check extended RAM .... okay 32505856 bytes
System RAM found ...... 640 Kilobytes
Extended RAM found .... 31744 Kilobytes
Printer ports found ... 0278
RS-232C ports found ... 03F8 02F8 03E8 02E8
CMOS time ............. 13:36:32 09-04-2003
Math coprocessor ...... found
ROM module scan ....... D000 Copyright(c) 1999 - 2003, Analogic Corporation.
All rights reserved worldwide.
NVRAM Ramdisk driver, version 1.2
okay
Booting .....

LILO Loading Message-Based

Linux version 2.4.22 (root@chaos) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #7 SMP Fri Aug 29 08:24:45 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000002000000 (usable)
32MB LOWMEM available.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
DMI not present.
Kernel command line: auto BOOT_IMAGE=Message-Based root=100
No local APIC present or hardware disabled
Initializing CPU#0
Calibrating delay loop... 66.90 BogoMIPS
Memory: 30064k/32768k available (899k kernel code, 2316k reserved, 211k data, 88k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD 486 DX/4-WB stepping 04
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 217k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 88k freed
Warning: unable to open an initial console.

Analogic(tm) VXI/Bus Driver : initialization complete
[SNIPPED...]
My 'init' gets control and loads modules.....

The message from the BIOS states that there was no screen memory
so the BIOS automatically uses the RS-232C port(s) for messages.
You can see the message from the kernel that it failed to
open an initial console. My init closes 0, 1, and 2 then tries
to open the console. If that fails, it opens ttyS0 instead and
dups() the fds. That way, it doesn't rely upon the lilo commands.

You can see all this working with linux-2.4.22. It it doesn't
work on your system, something else is broken. I would turn
OFF the BIOS screen emulation first and see if that fixes it.
You won't see the BIOS messages, but you should see the kernel
messages once it starts.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


