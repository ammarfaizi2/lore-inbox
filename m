Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263627AbTCUOaA>; Fri, 21 Mar 2003 09:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263628AbTCUOaA>; Fri, 21 Mar 2003 09:30:00 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:14427 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263627AbTCUO35>;
	Fri, 21 Mar 2003 09:29:57 -0500
Date: Fri, 21 Mar 2003 09:38:35 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: 2.5.65 jaz drive devfs oops
In-reply-to: <20030321090510.A28886@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1048689518.1e1d75@bittwiddlers.com>
Message-id: <20030321143835.GA6748@bittwiddlers.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_907Xx7zCD7/UuxMyAg5LzA)"
User-Agent: Mutt/1.5.3i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <20030319191450.GA23769@bittwiddlers.com>
 <20030319193431.A28725@infradead.org> <20030319214522.GA7397@bittwiddlers.com>
 <20030319235752.GA18086@bittwiddlers.com>
 <20030321025300.GA13772@bittwiddlers.com> <20030321090510.A28886@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_907Xx7zCD7/UuxMyAg5LzA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

: Is the OOPS with devfs=nomount exactly the same?  If no or you're
: unsure please post it, too.

I misread this the first time.  It looks different but I'm not sure I got
good output from ksymoops.  I attached the raw oops and the procesed oops
below.  This is with kernel 2.5.65-bk1 SMP with that devfs patch

-- 
  Matthew Harrell                          Do not meddle in the affairs of cats
  Bit Twiddlers, Inc.                       for they are subtle and will piss
  mharrell@bittwiddlers.com                 on your computer

--Boundary_(ID_907Xx7zCD7/UuxMyAg5LzA)
Content-type: text/plain; charset=us-ascii; NAME=oops.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops.txt

Unable to handle kernel paging request at virtual address 6f6c2e6d
c01ab313
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[devfs_unregister+35/80]    Not tainted
EFLAGS: 00010202
eax: 6f6c2e6d   ebx: c15f6240   ecx: c15740fc   edx: 00000000
esi: 001fe7e0   edi: c1571720   ebp: 00000001   esp: c1b19b58
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c017136e c1574150 c0187ad3 c15f6240 00000005 c1571720 c0187ef1 
       d7e08740 00000004 0000001e 00000001 fffffffa c15f2c00 fffffffa c028070c 
       00000000 00000001 00000000 d7e08740 c1571720 00000001 c016070c d7e08740 
Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 6f6c2e6d <__crc_xfrm_policy_insert+1d29de/ac2af0>
>>ebx; c15f6240 <__crc_global_cache_flush+72dda/1b3b85>
>>ecx; c15740fc <__crc_memcpy_tokerneliovec+316074/3253de>
>>esi; 001fe7e0 <__crc_smp_call_function+b280f/25f714>
>>edi; c1571720 <__crc_memcpy_tokerneliovec+313698/3253de>
>>esp; c1b19b58 <__crc_unregister_chrdev+1ec6c7/2f9bc8>

Code: f0 81 28 00 00 00 01 0f 85 fb 20 00 00 89 5c 24 04 8b 43 20 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)
Code;  00000007 Before first symbol
   7:   0f 85 fb 20 00 00         jne    2108 <_EIP+0x2108>
Code;  0000000d Before first symbol
   d:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  00000011 Before first symbol
  11:   8b 43 20                  mov    0x20(%ebx),%eax


--Boundary_(ID_907Xx7zCD7/UuxMyAg5LzA)
Content-type: text/plain; charset=us-ascii; NAME=oops-raw.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops-raw.txt

sdb: Spinning up disk...........ready
SCSI device sdb: 2091050 512-byte hdwr sectors (1071 MB)
sdb: Write Protect is off
sdb: Mode Sense: 39 00 10 08
SCSI device sdb: drive cache: write back
Unable to handle kernel paging request at virtual address 6f6c2e6d
 printing eip:
c01ab313
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[devfs_unregister+35/80]    Not tainted
EFLAGS: 00010202
EIP is at devfs_unregister+0x23/0x50
eax: 6f6c2e6d   ebx: c15f6240   ecx: c15740fc   edx: 00000000
esi: 001fe7e0   edi: c1571720   ebp: 00000001   esp: c1b19b58
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 13732, threadinfo=c1b18000 task=d2efd960)
Stack: 00000000 c017136e c1574150 c0187ad3 c15f6240 00000005 c1571720 c0187ef1 
       d7e08740 00000004 0000001e 00000001 fffffffa c15f2c00 fffffffa c028070c 
       00000000 00000001 00000000 d7e08740 c1571720 00000001 c016070c d7e08740 
Call Trace:
 [invalidate_device+110/144] invalidate_device+0x6e/0x90
 [delete_partition+131/160] delete_partition+0x83/0xa0
 [rescan_partitions+337/352] rescan_partitions+0x151/0x160
 [sd_open+172/288] sd_open+0xac/0x120
 [do_open+252/1040] do_open+0xfc/0x410
 [do_page_fault+316/1151] do_page_fault+0x13c/0x47f
 [blkdev_get+126/160] blkdev_get+0x7e/0xa0
 [do_open+619/1040] do_open+0x26b/0x410
 [blkdev_get+126/160] blkdev_get+0x7e/0xa0
 [open_bdev_excl+103/176] open_bdev_excl+0x67/0xb0
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [get_sb_bdev+55/352] get_sb_bdev+0x37/0x160
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [__crc_device_add+1467694/1798932] get_super_block+0x2f/0x33 [reiserfs]
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [__crc_device_add+1466095/1798932] reiserfs_fill_super+0x0/0x5c0 [reiserfs]
 [do_kern_mount+99/272] do_kern_mount+0x63/0x110
 [__crc_device_add+1598495/1798932] reiserfs_fs_type+0x0/0x6c [reiserfs]
 [do_add_mount+129/368] do_add_mount+0x81/0x170
 [do_mount+385/464] do_mount+0x181/0x1d0
 [copy_mount_options+218/224] copy_mount_options+0xda/0xe0
 [sys_mount+225/320] sys_mount+0xe1/0x140
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: f0 81 28 00 00 00 01 0f 85 fb 20 00 00 89 5c 24 04 8b 43 20 

--Boundary_(ID_907Xx7zCD7/UuxMyAg5LzA)--
