Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSKKDl4>; Sun, 10 Nov 2002 22:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSKKDl4>; Sun, 10 Nov 2002 22:41:56 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:2176 "EHLO
	ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265402AbSKKDly>; Sun, 10 Nov 2002 22:41:54 -0500
Date: Sun, 10 Nov 2002 22:49:37 -0500
From: Eric Buddington <eric@ma-northadams1b-126.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.46: Oops/panic in ide_init_queue
Message-ID: <20021110224937.A219@ma-northadams1b-126.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 945.792

kernel 2.5.46, most everything compiled as modules.

Here is the console output (ksymoops seems to be redundant with the
rather nifty "verbose-oops" option). I may have missed some off the
top of the screen.

-Eric

--------------------------------- 
VFS: Disk quotas vdquot_6.5.1
Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c013d554>] kmem_flagcheck+0x64/0x70
 [<c013dc06>] kmalloc+0x56/0xb0
 [<c013f75f>] set_shrinker+0x1f/0xa0
 [<c0173461>] mb_cache_create+0x1a1/0x250
 [<c0173180>] mb_cache_shrink_fn+0x0/0x140
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c010717d>] kernel_thread_helper+0x5/0x18

Journalled Block Device driver loaded
devfs: v1.21 (20020820) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Capability LSM initialized
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ytts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hdc: _NEC CD-RW NR-7800A, ATAPI CD/DVD-ROM drive
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010282
eax: c04c6b90   ebx: c04c6c3c   ecx: 00000000   edx: 00000000
esi: c04c6c4c   edi: c04c6b90   ebp: c126c000   esp: c126def4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c126c000 task=c126a040)
Stack: c024bd6f c04c6c3c 00000001 c0444c80 c04c6c3c c12ecce4 c024bf65 c04c6c3c 
       c0253b10 20000000 c04c6ba0 c12ecce4 c024c210 c04c6ba0 c126c000 00000000 
       00000296 00000000 00000001 c04c6b90 00000000 c04c6ba0 c024c4e4 c04c6b90 
Call Trace:
 [<c024bd6f>] ide_init_queue+0x9f/0xb0
 [<c024bf65>] init_irq+0x1e5/0x3c0
 [<c0253b10>] ide_intr+0x0/0x180
 [<c024c210>] alloc_disks+0x70/0xd0
 [<c024c4e4>] hwif_init+0xf4/0x2a0
 [<c024c7ae>] ideprobe_init+0xee/0x100
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c010717d>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!
