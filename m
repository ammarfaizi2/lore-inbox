Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263483AbUJ2Scd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUJ2Scd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbUJ2S3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:29:03 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:42503 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S263466AbUJ2SXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:23:07 -0400
Date: Fri, 29 Oct 2004 19:22:11 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org
cc: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Help re Frame Buffer/Console Problems
Message-ID: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been trying to get a CG3 sparc clone up and running with linux.
Under 2.2.26, the console is fine. During the development of the
2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
to track done one of the problems (the blanking code had some typing
errors in it) and this gave me a logo + black screen and cursor using a
linux-2.2.8.1 kernel. Still no console text.

Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
appropriate patches and made some additional mods to keep the
compiler/linker happy. Now I have a black console, no text, logo or cursor
and if I redirect the console output to a serial port I get the following:
-------------------------------------------------------------------------
b vmlinux.sun4c
Probing Memory Bank #: 1 2 3 4 5 
Booting from: sd(0,0,0)vmlinux.sun4c 
root on sd0a fstype 4.2
Size: 1990912+0+117384 bytes
PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 2.6.10-MTF (mark@fw) (gcc version 3.4.2) #3 Fri Oct 29
18:04:22 BST 2004
ARCH: SUN4C
TYPE: Sun4c SparcStation 1
Ethernet address: 0:80:f1:0:5:89
Loading sun4c MMU routines
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching
kernel for sun4c
SUN4C: 79 mmu entries for the kernel
Booting Linux...
auxio register: 0xffd0e000
Built 1 zonelists
Kernel command line: -p
ip=10.1.1.3:10.1.1.4:10.1.1.3:255.255.255.0:sparc3::off root=/dev/sda4
rootfstype=ufs rootflags=ufstype=sunos 
PID hash table entries: 64 (order: 6, 1024 bytes)
time_init: reg address: fe001000
Console: mono PROM 80x34
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 14084k/16332k available (1440k kernel code, 2224k reserved, 376k
data, 120k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
SCSI subsystem initialized
sbus0: Clock 20.0 MHz
dma0 register address at 0xfe002000
dma0: Revision 1 
CG3 Register Base Address: fe003000
CG3 Screen Base Address: ffd80000
Console: switching to colour frame buffer device 80x34
cg3: cgthree at 1:fe000000
Zilog Serial 0 @ 0xffd02000
Zilog Serial 1 @ 0xffd00000
zs2 at 0xffd00004 (irq = 12) is a SunZilog
zs3 at 0xffd00000 (irq = 12) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 12) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 12) is a SunZilog
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
Floppy Address: 0xffd18000
Sparc FDC is 82077
FDC 0 is a pre-1991 82077
sunlance.c:v2.02 24/Aug/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
SunLance at register address fe004000
eth0: LANCE 00:80:f1:00:05:89 
ESP registers at fe005000
esp0: IRQ 3 SCSI ID 7 Clk 20MHz CCYC=50000 CCF=4 TOut 167
NCR53C90A(esp100a)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A (NCR53C90A)
  Vendor: IBM       Model: DORS-32160        Rev: S82C
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 sda5 sda7 sda8
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
mice: PS/2 mouse device common for all mice
input: Sun Type 4 keyboard on zs/serio0
input: Sun Mouse on zs/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET: Registered protocol family 1
IP-Config: Complete:
      device=eth0, addr=10.1.1.3, mask=255.255.255.0, gw=10.1.1.3,
     host=sparc3, domain=, nis-domain=(none),
     bootserver=10.1.1.4, rootserver=10.1.1.4, rootpath=
ufs_read_super: fs needs fsck
VFS: Mounted root (ufs filesystem) readonly.
Freeing unused kernel memory: 120k freed
Warning: unable to open an initial console.
Kernel panic - not syncing: Attempted to kill init!
 <0>Press L1-A to return to the boot prom

-------------------------------------------------------------------------
The questions are:

1) How do a force the frame buffer system to initialise the colour pallet
on CG3 initialisation (PROM uses black on white, linux uses white on
black).

2) What command line options are required to use a prom console, followed
by a CG3 console (as soon as the CG3 is available) and have a logo on the 
CG3 console.

3) Is there any documentation for this as I have not been able to find
anything appropriate and the code is far from easy to decipher.

Please note, my kernel has been tweeked to:
a) To have a default command line as the SunOS boot code does not apear
to be passing command line parameters in a compatible way and it saves on
the typing.
b) Use PROM addresses were available to help me with the debugging.
c) To fix 82077 FDC detection for sun4c.
d) To fix CG3 blanking code errors.
e) To get around incorrect compilation (or a bug in printk) of %llu
parameters to printk in sd.c. (I use %lu with unsigned long ards instead).
f) To have a SunOS 4.1.1 compatible partition detection system.

Thank you to thoes who have helped me so far. I am slowly making progress.

Regards
	Mark Fortescue.

