Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265539AbSJaXJw>; Thu, 31 Oct 2002 18:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSJaXJ0>; Thu, 31 Oct 2002 18:09:26 -0500
Received: from mail.scram.de ([195.226.127.117]:17350 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S265478AbSJaXHY>;
	Thu, 31 Oct 2002 18:07:24 -0500
Date: Fri, 1 Nov 2002 00:07:24 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops on bad floppy 2.5.44 / Alpha
Message-ID: <Pine.LNX.4.44.0211010004280.11487-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i did a dd to a bad floppy. When the dd hung, i removed the floppy from
the drive. The result is the following oops.

--jochen

ksymoops 2.4.6 on alpha 2.5.44.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /boot/System.map-2.5.44 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol snd_cards_count  , snd says fffffffc0039e150, /lib/modules/2.5.44/kernel/sound/core/snd.o says fffffffc00394030.  Ignoring /lib/modules/2.5.44/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says fffffffc0039e148, /lib/modules/2.5.44/kernel/sound/core/snd.o says fffffffc00394028.  Ignoring /lib/modules/2.5.44/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says fffffffc0039e168, /lib/modules/2.5.44/kernel/sound/core/snd.o says fffffffc00394048.  Ignoring /lib/modules/2.5.44/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_seq_root  , snd says fffffffc0039e180, /lib/modules/2.5.44/kernel/sound/core/snd.o says fffffffc00394060.  Ignoring /lib/modules/2.5.44/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says fffffffc0035c4d8, /lib/modules/2.5.44/kernel/fs/lockd/lockd.o says fffffffc0034a018.  Ignoring /lib/modules/2.5.44/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says fffffffc00341bd4, /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o says fffffffc0032802c.  Ignoring /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says fffffffc00341bd8, /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o says fffffffc00328030.  Ignoring /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says fffffffc00341bdc, /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o says fffffffc00328034.  Ignoring /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says fffffffc00341bd0, /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o says fffffffc00328028.  Ignoring /lib/modules/2.5.44/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says fffffffc002d4080, /lib/modules/2.5.44/kernel/drivers/usb/core/usbcore.o says fffffffc002bc028.  Ignoring /lib/modules/2.5.44/kernel/drivers/usb/core/usbcore.o entry
fffffc000184f9b8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f6c4 0000000000000000 fffffc000036f74c 0000000000000000
       fffffc000036f8bc fffffc00006fbbf0 0000000000000001 0000000000000001
       fffffc0000ee35a8 fffffffc0040e5e0 fffffc000036d328 fffffc00006fbbf0
       0000000000000001 0000000060000000 0000000000000000 fffffc000184fa98
       fffffc000036665c fffffc000bde2640 fffffc000036bb4c fffffc000bde2640
Trace:fffffc000036ae04 fffffc000036f6c4 fffffc000036f74c fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9c8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f794 0000000000000000 fffffc000036f8bc fffffc00006fbbf0
       0000000000000001 0000000000000001 fffffc0000ee35a8 fffffffc0040e5e0
       fffffc000036d328 fffffc00006fbbf0 0000000000000001 0000000060000000
       0000000000000000 fffffc000184fa98 fffffc000036665c fffffc000bde2640
       fffffc000036bb4c fffffc000bde2640 fffffc000bde2640 0000000000000000
Trace:fffffc000036ae04 fffffc000036f794 fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9b8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f6c4 fffffc0005e4bb00 fffffc000036f74c 0000000000000000
       fffffc000036f8bc fffffc0000812a20 0000000000000002 0000000000000002
       fffffc0000ee35a8 fffffffc0040e5e0 fffffc000036d328 fffffc0000812a20
       0000000000000002 0000000060000000 0000000000000000 fffffc000184fa98
       fffffc000036665c fffffc00006fbbf0 fffffc000036bb4c fffffc000bde2640
Trace:fffffc000036ae04 fffffc000036f6c4 fffffc000036f74c fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9c8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f794 0000000000000000 fffffc000036f8bc fffffc0000812a20
       0000000000000002 0000000000000002 fffffc0000ee35a8 fffffffc0040e5e0
       fffffc000036d328 fffffc0000812a20 0000000000000002 0000000060000000
       0000000000000000 fffffc000184fa98 fffffc000036665c fffffc00006fbbf0
       fffffc000036bb4c fffffc000bde2640 fffffc000bde2640 0000000000000000
Trace:fffffc000036ae04 fffffc000036f794 fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9b8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f6c4 fffffc00016ea180 fffffc000036f74c 0000000000000000
       fffffc000036f8bc fffffc00008648c0 0000000000000003 0000000000000003
       fffffc0000ee35a8 fffffffc0040e5e0 fffffc000036d328 fffffc00008648c0
       0000000000000003 0000000060000000 0000000000000000 fffffc000184fa98
       fffffc000036665c fffffc0000812a20 fffffc000036bb4c fffffc000bde2640
Trace:fffffc000036ae04 fffffc000036f6c4 fffffc000036f74c fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9c8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f794 0000000000000000 fffffc000036f8bc fffffc00008648c0
       0000000000000003 0000000000000003 fffffc0000ee35a8 fffffffc0040e5e0
       fffffc000036d328 fffffc00008648c0 0000000000000003 0000000060000000
       0000000000000000 fffffc000184fa98 fffffc000036665c fffffc0000812a20
       fffffc000036bb4c fffffc000bde2640 fffffc000bde2640 0000000000000000
Trace:fffffc000036ae04 fffffc000036f794 fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9b8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f6c4 fffffc00016ebbc0 fffffc000036f74c 0000000000000000
       fffffc000036f8bc fffffc00007bac80 0000000000000004 0000000000000004
       fffffc0000ee35a8 fffffffc0040e5e0 fffffc000036d328 fffffc00007bac80
       0000000000000004 0000000060000000 0000000000000000 fffffc000184fa98
       fffffc000036665c fffffc00008648c0 fffffc000036bb4c fffffc000bde2640
Trace:fffffc000036ae04 fffffc000036f6c4 fffffc000036f74c fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9c8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f794 0000000000000000 fffffc000036f8bc fffffc00007bac80
       0000000000000004 0000000000000004 fffffc0000ee35a8 fffffffc0040e5e0
       fffffc000036d328 fffffc00007bac80 0000000000000004 0000000060000000
       0000000000000000 fffffc000184fa98 fffffc000036665c fffffc00008648c0
       fffffc000036bb4c fffffc000bde2640 fffffc000bde2640 0000000000000000
Trace:fffffc000036ae04 fffffc000036f794 fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9b8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f6c4 fffffc00016eb680 fffffc000036f74c 0000000000000000
       fffffc000036f8bc fffffc00008062c0 0000000000000005 0000000000000005
       fffffc0000ee35a8 fffffffc0040e5e0 fffffc000036d328 fffffc00008062c0
       0000000000000005 0000000060000000 0000000000000000 fffffc000184fa98
       fffffc000036665c fffffc00007bac80 fffffc000036bb4c fffffc000bde2640
Trace:fffffc000036ae04 fffffc000036f6c4 fffffc000036f74c fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
fffffc000184f9c8 0000000000000000 fffffc000036ae04 0000000000000003
       fffffc000036f794 0000000000000000 fffffc000036f8bc fffffc00008062c0
       0000000000000005 0000000000000005 fffffc0000ee35a8 fffffffc0040e5e0
       fffffc000036d328 fffffc00008062c0 0000000000000005 0000000060000000
       0000000000000000 fffffc000184fa98 fffffc000036665c fffffc00007bac80
       fffffc000036bb4c fffffc000bde2640 fffffc000bde2640 0000000000000000
Trace:fffffc000036ae04 fffffc000036f794 fffffc000036f8bc fffffc000036d328 fffffc000036665c fffffc000036bb4c fffffc0000345590 fffffc000036d1cc fffffc000036d218 fffffc000036bb3c fffffc0000388530 fffffc0000373780 fffffc0000373d04 fffffc000037410c fffffc0000373c68 fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
Unable to handle kernel paging request at virtual address 00000000000004e8
fdformat(1723): Oops 0
pc = [<fffffc0000373e00>]  ra = [<fffffc0000373c68>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000010  t1 = fffffc0000ee3040
t2 = fffffffc0040e798  t3 = 0000000000000500  t4 = fffffc0000ee34c0
t5 = 00000000000004e0  t6 = fffffc00006278e8  t7 = fffffc000b4cc000
s0 = fffffc000bde2640  s1 = fffffc000bde2700  s2 = fffffffc003fe000
s3 = fffffc000606f740  s4 = 0000000000000000  s5 = 0000000000000228
s6 = fffffc0001938640
a0 = fffffc000bde2738  a1 = 0000000000168000  a2 = fffffc000aed2d40
a3 = fffffc0000698000  a4 = fffffc000057cf68  a5 = ffffffffffffffff
t8 = 0000000000000000  t9 = fffffc0000627b90  t10= fffffc000057d778
t11= cccccccccccccccd  pv = fffffc0000415a60  at = 0000000000002729
gp = fffffc0000621770  sp = fffffc000b4cfde8
Trace:fffffc0000374184 fffffc0000368094 fffffc0000367f64 fffffc00003685d8 fffffc00003685a0 fffffc0000310ce4
Code: a4620190  40841526  b4650190  a02c0068  44221001  e4200002 <a4260008> f420001a


Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f6c4 <check_ttfb_buffer+64/80>
Trace; fffffc000036f74c <drop_buffers+6c/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f794 <drop_buffers+b4/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f6c4 <check_ttfb_buffer+64/80>
Trace; fffffc000036f74c <drop_buffers+6c/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f794 <drop_buffers+b4/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f6c4 <check_ttfb_buffer+64/80>
Trace; fffffc000036f74c <drop_buffers+6c/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f794 <drop_buffers+b4/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f6c4 <check_ttfb_buffer+64/80>
Trace; fffffc000036f74c <drop_buffers+6c/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f794 <drop_buffers+b4/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f6c4 <check_ttfb_buffer+64/80>
Trace; fffffc000036f74c <drop_buffers+6c/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>
Trace; fffffc000036ae04 <__buffer_error+64/80>
Trace; fffffc000036f794 <drop_buffers+b4/160>
Trace; fffffc000036f8bc <try_to_free_buffers+7c/120>
Trace; fffffc000036d328 <try_to_release_page+68/80>
Trace; fffffc000036665c <invalidate_inode_pages+bc/180>
Trace; fffffc000036bb4c <invalidate_bdev+2c/60>
Trace; fffffc0000345590 <queue_work+b0/e0>
Trace; fffffc000036d1cc <invalidate_bh_lru+2c/60>
Trace; fffffc000036d218 <invalidate_bh_lrus+18/40>
Trace; fffffc000036bb3c <invalidate_bdev+1c/60>
Trace; fffffc0000388530 <invalidate_device+d0/120>
Trace; fffffc0000373780 <check_disk_change+80/100>
Trace; fffffc0000373d04 <do_open+264/5e0>
Trace; fffffc000037410c <blkdev_get+8c/c0>
Trace; fffffc0000373c68 <do_open+1c8/5e0>
Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>

>>RA;  fffffc0000373c68 <do_open+1c8/5e0>

>>PC;  fffffc0000373e00 <do_open+360/5e0>   <=====

Trace; fffffc0000374184 <blkdev_open+44/60>
Trace; fffffc0000368094 <dentry_open+114/280>
Trace; fffffc0000367f64 <filp_open+64/80>
Trace; fffffc00003685d8 <sys_open+78/100>
Trace; fffffc00003685a0 <sys_open+40/100>
Trace; fffffc0000310ce4 <entSys+a4/b8>

Code;  fffffc0000373de8 <do_open+348/5e0>
0000000000000000 <_PC>:
Code;  fffffc0000373de8 <do_open+348/5e0>
   0:   90 01 62 a4       ldq  t2,400(t1)
Code;  fffffc0000373dec <do_open+34c/5e0>
   4:   26 15 84 40       subq t3,0x20,t5
Code;  fffffc0000373df0 <do_open+350/5e0>
   8:   90 01 65 b4       stq  t2,400(t4)
Code;  fffffc0000373df4 <do_open+354/5e0>
   c:   68 00 2c a0       ldl  t0,104(s3)
Code;  fffffc0000373df8 <do_open+358/5e0>
  10:   01 10 22 44       and  t0,0x10,t0
Code;  fffffc0000373dfc <do_open+35c/5e0>
  14:   02 00 20 e4       beq  t0,20 <_PC+0x20> fffffc0000373e08 <do_open+368/5e0>
Code;  fffffc0000373e00 <do_open+360/5e0>   <=====
  18:   08 00 26 a4       ldq  t0,8(t5)   <=====
Code;  fffffc0000373e04 <do_open+364/5e0>
  1c:   1a 00 20 f4       bne  t0,88 <_PC+0x88> fffffc0000373e70 <do_open+3d0/5e0>


11 warnings issued.  Results may not be reliable.

