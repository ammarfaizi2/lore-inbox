Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUATBUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUATBTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:19:37 -0500
Received: from dsl-hkigw4j21.dial.inet.fi ([80.222.57.33]:17280 "EHLO
	dsl-hkigw4j21.dial.inet.fi") by vger.kernel.org with ESMTP
	id S264452AbUATBQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:16:19 -0500
Date: Tue, 20 Jan 2004 03:16:17 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4j21.dial.inet.fi
To: sct@redhat.com, akpm@digeo.com, adilger@clusterfs.com,
       hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.1 perhaps ext3 or fat releated crash
Message-ID: <Pine.LNX.4.58.0401200259140.982@dsl-hkigw4j21.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel crashed (jammed) and I had to reboot manually. I had digital camera
attached when booting. Camera has vfat filesystem on MMC card. (/dev/sda1
on /mnt/camera type vfat (rw,noexec,nosuid,nodev,user=petri)

More info on (System.map-2.6.1, config-2.6.1, kern.log, ksymoops.txt,
vmlinuz-2.6.1): http://iki.fi/petri.koistinen/kernel-oops-2004-01-20/

Petri

ksymoops 2.4.9 on i686 2.6.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.1/ (default)
     -m /boot/System.map-2.6.1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan 20 02:22:40 dsl-hkigw4j21 kernel: Unable to handle kernel paging request at virtual address 0083f9ff
Jan 20 02:22:40 dsl-hkigw4j21 kernel: c01893e6
Jan 20 02:22:40 dsl-hkigw4j21 kernel: *pde = 00000000
Jan 20 02:22:40 dsl-hkigw4j21 kernel: Oops: 0000 [#1]
Jan 20 02:22:40 dsl-hkigw4j21 kernel: CPU:    0
Jan 20 02:22:40 dsl-hkigw4j21 kernel: EIP:    0060:[<c01893e6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 20 02:22:40 dsl-hkigw4j21 kernel: EFLAGS: 00010203
Jan 20 02:22:40 dsl-hkigw4j21 kernel: eax: 0083f9f7   ebx: 00003000   ecx: 00000000   edx: 00002000
Jan 20 02:22:40 dsl-hkigw4j21 kernel: esi: 0083f9f7   edi: 00000000   ebp: 00001000   esp: c13c9ddc
Jan 20 02:22:40 dsl-hkigw4j21 kernel: ds: 007b   es: 007b   ss: 0068
Jan 20 02:22:40 dsl-hkigw4j21 kernel: Stack: cf9c33e4 c2fbd3f0 c113f3d0 cf9c33e4 c2fbd3f0 cf9c33e4 c0189af3 cf9c33e4
Jan 20 02:22:40 dsl-hkigw4j21 kernel:        c2fbd3f0 00000000 00001000 00000000 c01899e0 c113f3d0 c6400c8c c13c8000
Jan 20 02:22:40 dsl-hkigw4j21 kernel:        c13c9f04 c016e9a6 c113f3d0 c13c9f04 cffed840 cffed838 c01550e0 00000000
Jan 20 02:22:40 dsl-hkigw4j21 kernel: Call Trace:
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0189af3>] ext3_ordered_writepage+0xd3/0x1c0
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c01899e0>] bget_one+0x0/0x10
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c016e9a6>] mpage_writepages+0x216/0x2f0
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c01550e0>] blkdev_writepage+0x0/0x30
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0189a20>] ext3_ordered_writepage+0x0/0x1c0
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0137d46>] do_writepages+0x36/0x40
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c016d0d4>] __sync_single_inode+0xd4/0x230
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c016d47e>] sync_sb_inodes+0x19e/0x260
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c016d58d>] writeback_inodes+0x4d/0xa0
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0137b8c>] wb_kupdate+0x9c/0x120
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0138152>] __pdflush+0xd2/0x1d0
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0138250>] pdflush+0x0/0x20
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c013825f>] pdflush+0xf/0x20
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0137af0>] wb_kupdate+0x0/0x120
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0106e44>] kernel_thread_helper+0x0/0xc
Jan 20 02:22:40 dsl-hkigw4j21 kernel:  [<c0106e49>] kernel_thread_helper+0x5/0xc
Jan 20 02:22:40 dsl-hkigw4j21 kernel: Code: 8b 70 08 3b 5c 24 24 77 34 8b 54 24 2c 85 d2 74 10 8b 00 a8


>>EIP; c01893e6 <walk_page_buffers+16/70>   <=====

>>esp; c13c9ddc <_end+ec4ff4/3faf9218>

Trace; c0189af3 <ext3_ordered_writepage+d3/1c0>
Trace; c01899e0 <bget_one+0/10>
Trace; c016e9a6 <mpage_writepages+216/2f0>
Trace; c01550e0 <blkdev_writepage+0/30>
Trace; c0189a20 <ext3_ordered_writepage+0/1c0>
Trace; c0137d46 <do_writepages+36/40>
Trace; c016d0d4 <__sync_single_inode+d4/230>
Trace; c016d47e <sync_sb_inodes+19e/260>
Trace; c016d58d <writeback_inodes+4d/a0>
Trace; c0137b8c <wb_kupdate+9c/120>
Trace; c0138152 <__pdflush+d2/1d0>
Trace; c0138250 <pdflush+0/20>
Trace; c013825f <pdflush+f/20>
Trace; c0137af0 <wb_kupdate+0/120>
Trace; c0106e44 <kernel_thread_helper+0/c>
Trace; c0106e49 <kernel_thread_helper+5/c>

Code;  c01893e6 <walk_page_buffers+16/70>
00000000 <_EIP>:
Code;  c01893e6 <walk_page_buffers+16/70>   <=====
   0:   8b 70 08                  mov    0x8(%eax),%esi   <=====
Code;  c01893e9 <walk_page_buffers+19/70>
   3:   3b 5c 24 24               cmp    0x24(%esp,1),%ebx
Code;  c01893ed <walk_page_buffers+1d/70>
   7:   77 34                     ja     3d <_EIP+0x3d>
Code;  c01893ef <walk_page_buffers+1f/70>
   9:   8b 54 24 2c               mov    0x2c(%esp,1),%edx
Code;  c01893f3 <walk_page_buffers+23/70>
   d:   85 d2                     test   %edx,%edx
Code;  c01893f5 <walk_page_buffers+25/70>
   f:   74 10                     je     21 <_EIP+0x21>
Code;  c01893f7 <walk_page_buffers+27/70>
  11:   8b 00                     mov    (%eax),%eax
Code;  c01893f9 <walk_page_buffers+29/70>
  13:   a8 00                     test   $0x0,%al


1 warning and 1 error issued.  Results may not be reliable.
