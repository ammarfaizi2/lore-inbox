Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbTA0IJ3>; Mon, 27 Jan 2003 03:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTA0IJ3>; Mon, 27 Jan 2003 03:09:29 -0500
Received: from main.gmane.org ([80.91.224.249]:53223 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267143AbTA0IJ1>;
	Mon, 27 Jan 2003 03:09:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andres Salomon" <dilinger@voxel.net>
Subject: Re: 2.5.59-mm6
Date: Mon, 27 Jan 2003 03:17:54 -0500
Message-ID: <pan.2003.01.27.08.17.50.697367@voxel.net>
References: <20030126231015.6ad982e4.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one boots for me (with devfs enabled).  I got some rather interesting
stack dumps, however, during boot.


Linux version 2.5.59 (dilinger@pea) (gcc version 3.2.2 20030124 (Debian prerelease)) #4 Mon Jan 27 03:02:50 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013fec000 (usable)
 BIOS-e820: 0000000013fec000 - 0000000013ff0000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81900
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77804 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux-2.5 ro root=302 devfs=mount gdb gdbttyS=1 gdbbaud=115200
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 498.395 MHz processor.
Console: colour VGA+ 80x25
 
Warning! Detected 2173 micro-second gap between interrupts.
  Compensating for 1 lost ticks.
Call Trace:
 [<c010b8a8>] handle_IRQ_event+0x38/0x60
 [<c010bade>] do_IRQ+0xae/0x160
 [<c0105000>] _stext+0x0/0x30
 [<c010a150>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x30
 
Calibrating delay loop... 985.08 BogoMIPS
Memory: 321540k/327600k available (1328k kernel code, 5320k reserved, 396k data, 120k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
Waiting for connection from remote gdb... <4>
Warning! Detected 6839271 micro-second gap between interrupts.
  Compensating for 6838 lost ticks.
Call Trace:
 [<c010b8a8>] handle_IRQ_event+0x38/0x60
 [<c010bade>] do_IRQ+0xae/0x160
 [<c010a850>] do_int3+0x0/0x80
 [<c010a150>] common_interrupt+0x18/0x20
 [<c010a850>] do_int3+0x0/0x80
 [<c0115df8>] handle_exception+0x7a8/0x7f0
 [<c01c905f>] vt_console_print+0x21f/0x310
 [<c0105000>] _stext+0x0/0x30
 [<c0115e7d>] breakpoint+0xd/0x10
 [<c010a850>] do_int3+0x0/0x80
 [<c010a8c9>] do_int3+0x79/0x80
 [<c011e2d8>] release_console_sem+0xd8/0xe0
 [<c010a1ed>] error_code+0x2d/0x38
 [<c0105000>] _stext+0x0/0x30
 [<c0115e7d>] breakpoint+0xd/0x10
 [<c01cafb2>] gdb_hook+0xa2/0xf0
 [<c01cae80>] gdb_interrupt+0x0/0x80
 
Connected.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)

...and so on


On Sun, 26 Jan 2003 23:10:15 -0800, Andrew Morton wrote:

> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm6/
>
[...]
> 
> antsched-update-1.patch
>   Subject: [PATCH] 2.5.59-snap2 updates


