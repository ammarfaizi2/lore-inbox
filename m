Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265263AbSJaRzv>; Thu, 31 Oct 2002 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSJaRzv>; Thu, 31 Oct 2002 12:55:51 -0500
Received: from mtl.slowbone.net ([213.237.73.175]:46720 "EHLO
	leeloo.slowbone.net") by vger.kernel.org with ESMTP
	id <S265263AbSJaRwu>; Thu, 31 Oct 2002 12:52:50 -0500
Message-ID: <051301c28107$3c7f6010$0201a8c0@mtl>
From: =?iso-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
To: <linux-kernel@vger.kernel.org>
Subject: BUG at drivers/block/ll_rw_blk.c:1945! [2.5.45]
Date: Thu, 31 Oct 2002 18:59:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happenes when I read larger files or dirs from an ext2 fs on a raid0 md
device.


kernel BUG at drivers/block/ll_rw_blk.c:1945!
invalid operand: 0000

CPU:    0
EIP:    0060:[submit_bio+21/84]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: cb8a0f60   edx: 00000000
esi: cb8a0f60   edi: c1304080   ebp: d9f63cd4   esp: d9f63c5c
ds: 0068   es: 0068   ss: 0068
Process cat (pid: 8826, threadinfo=d9f62000 task=d74cb920)
Stack: 00001000 c014c812 00000000 cb8a0f60 c014ca7c 00000000 cb8a0f60
c1304088
       c1304080 00000001 dffa67e0 00000002 dfdaee40 00000001 00000003
00000001
       0000000c cfa7a4f0 00000010 dffeb1a0 00000020 ffffffff 016a9d07
00000001
Call Trace: [mpage_bio_submit+34/40]  [do_mpage_readpage+500/704]
[add_to_page_cache+30/132]  [mpage_readpages+122/280]
[ext2_get_block+0/752]  [ext2_readpages+25/32]  [ext2_get_block+0/752]
[read_pages+56/260]  [buffered_rmqueue+198/208]  [__alloc_pages+122/568]
[do_page_cache_readahead+219/256]  [page_cache_readahead+210/292]
[do_generic_mapping_read+85/820]  [__generic_file_aio_read+461/500]
[file_read_actor+0/244]  [do_anonymous_page+323/348]
[generic_file_read+123/156]  [handle_mm_fault+97/208]
[do_page_fault+0/1028]  [do_brk+253/468]  [vfs_read+193/292]
[sys_read+42/60]  [syscall_call+7/11]
Code: 0f 0b 99 07 cb e7 2b c0 83 79 24 00 75 09 0f 0b 9a 07 cb e7



