Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTHGSof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHGSof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:44:35 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:51133 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S270483AbTHGSob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:44:31 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Kernel 2.6.0-test2 vs 2.2.12 -- Some observations
Date: Thu, 7 Aug 2003 14:44:30 -0400
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk> <200308071323.44884.jcwren@jcwren.com> <20030807103413.5625235e.akpm@osdl.org>
In-Reply-To: <20030807103413.5625235e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071444.30111.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the output of the system coming up, and 'free' and 'cat /proc/meminfo'.  Don't have a version of top currently compiled for it, but 'uptime' says 0.00 0.00 0.00 after it's sitting idle a bit.

Linux version 2.6.0-slimedr (root@linux.private.com) (gcc version 2.96 20000731
(Red Hat Linux 7.3 2.96-113)) #31 Thu Aug 7 00:22:22 EDT 2003
Video mode to be used for restore is 3e0
BIOS-provided physical RAM map:
 PROM: 0000000000000000 - 000000000009f000 (usable)
 PROM: 0000000000100000 - 00000000040ffc00 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009f000 (usable)
 user: 0000000000100000 - 00000000007f1000 (usable)
7MB LOWMEM available.
On node 0 totalpages: 2033
  DMA zone: 2033 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 hdb=none ide0=0x1f0,0x3f6,0x09 ide0=noautotune hda=notremovable console=ttyS0,57600 mem=7744k
ide_setup: hdb=none -- BAD OPTION
ide_setup: ide0=0x1f0,0x3f6,0x09

ide_setup: ide0=noautotune
ide_setup: hda=notremovable
Initializing CPU#0
PID hash table entries: 32 (order 5: 256 bytes)
Calibrating delay loop... 4.14 BogoMIPS
Memory: 6296k/8132k available (932k kernel code, 1424k reserved, 239k data, 68k
init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... No.
Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: 386
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs:   5 entries (12 bytes)
biovec pool[1]:   4 bvecs:   2 entries (48 bytes)
biovec pool[2]:  16 bvecs:   1 entries (192 bytes)
biovec pool[3]:  64 bvecs:   0 entries (768 bytes)
biovec pool[4]: 128 bvecs:   0 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   0 entries (3072 bytes)
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
ttyS1 at I/O 0x2f8 (irq = 3) is a 16450
ttyS2 at I/O 0x300 (irq = 12) is a ST16654
ttyS3 at I/O 0x310 (irq = 14) is a ST16654
ttyS4 at I/O 0x320 (irq = 5) is a ST16654
ttyS5 at I/O 0x330 (irq = 6) is a ST16654
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: 32MB CTS, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 9
hda: max request size: 128KiB
hda: 64000 sectors (33 MB) w/4KiB Cache, CHS=500/4/32
 hda: hda1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed

bash# free
             total       used       free     shared    buffers     cached
Mem:          6388       3252       3136          0        260       1960
-/+ buffers/cache:       1032       5356
Swap:            0          0          0
bash# cat /proc/meminfo
MemTotal:         6388 kB
MemFree:          3148 kB
Buffers:           260 kB
Cached:           1972 kB
SwapCached:          0 kB
Active:           1728 kB
Inactive:          816 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         6388 kB
LowFree:          3148 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              32 kB
Writeback:           0 kB
Mapped:           1120 kB
Slab:              552 kB
Committed_AS:     4052 kB
PageTables:         48 kB
VmallocTotal:  1032168 kB
VmallocUsed:         0 kB
VmallocChunk:  1032168 kB
bash#

	--John

On Thursday 07 August 2003 13:34 pm, Andrew Morton wrote:
> "J.C. Wren" <jcwren@jcwren.com> wrote:
> > Interactive performance is an atrocity with 2.6.0-test2.  Something as
> > simple as backspacing though a command line can cause overrun errors. 
> > Whereas before zmodeming a file down was not an issue with 2.2.12 (this,
> > in fact, is how software is applied to the CF card), it fails completely
> > under 2.6.0-test2.
>
> It sounds like something is spinning in-kernel.
>
> What do `free' and `cat /proc/meminfo' and `top' say?
>
> The next step would be to generate a kernel profile.

