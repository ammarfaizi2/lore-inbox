Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUEEVbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUEEVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbUEEVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:31:16 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53478 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264461AbUEEVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:31:13 -0400
Date: Wed, 5 May 2004 17:31:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: kernel BUG at fs/ext3/balloc.c:942!
Message-ID: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shout at me if you need something else, right now i need to reboot my
workstation.

------------[ cut here ]------------
kernel BUG at fs/ext3/balloc.c:942!
invalid operand: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c01a4b75>]    Not tainted VLI
EFLAGS: 00010287   (2.6.6-rc3-mm2)
EIP is at ext3_try_to_allocate_with_rsv+0x102/0x1e7
eax: 00010000   ebx: 00002246   ecx: 00018000   edx: 00012244
esi: f72eca00   edi: 00000000   ebp: f71c1cdc   esp: f73b19b0
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 755, threadinfo=f73b0000 task=f73ad0e0)
Stack: f72eca00 00000000 c014bf30 00000000 00010000 f7259900 00000002 c253e4ec
       00000000 00000002 f72eca00 00002246 f7257040 c01a4e23 e0557e40 00002246
       f71c1cdc f73b1a38 00000000 f71c1c80 c01aa235 c32c1600 c01b22b7 00000002
Call Trace:
 [<c014bf30>] __bread+0x5/0x1b
 [<c01a4e23>] ext3_new_block+0x1c9/0x57a
 [<c01aa235>] ext3_do_update_inode+0x162/0x357
 [<c01b22b7>] journal_get_write_access+0x33/0x45
 [<c01a76d2>] ext3_alloc_branch+0x48/0x259
 [<c01a7bc4>] ext3_get_block_handle+0x137/0x2fc
 [<c03c4e97>] ipv4_sabotage_out+0xd8/0xf2
 [<c039184c>] ip_finish_output2+0x0/0x18f
 [<c01b1565>] start_this_handle+0xd2/0x34a
 [<c01a7ddd>] ext3_get_block+0x54/0x9e
 [<c014c67b>] __block_prepare_write+0x1bf/0x3a0
 [<c014cfb0>] block_prepare_write+0x28/0x3d
 [<c01a7d89>] ext3_get_block+0x0/0x9e
 [<c01a829f>] ext3_prepare_write+0x51/0x110
 [<c01a7d89>] ext3_get_block+0x0/0x9e
 [<c01301f9>] generic_file_aio_write_nolock+0x39a/0xa9b
 [<c039f0e2>] tcp_transmit_skb+0x3f3/0x5fd
 [<c02ad418>] copy_to_user+0x32/0x45
 [<c0377ffb>] memcpy_toiovec+0x27/0x49
 [<c0130959>] generic_file_write_nolock+0x5f/0x7d
 [<c03b3cf9>] inet_recvmsg+0x4a/0x69
 [<c0130b14>] generic_file_writev+0x3a/0x5a
 [<c0130ada>] generic_file_writev+0x0/0x5a
 [<c0149ec5>] do_readv_writev+0x1db/0x21f
 [<c0149966>] do_sync_write+0x0/0xa4
 [<c0149fa1>] vfs_writev+0x49/0x52
 [<c01f07b0>] nfsd_write+0xf2/0x305
 [<c03cc8a7>] svc_sock_enqueue+0x143/0x2b0
 [<c01f6ef8>] nfsd3_proc_write+0xb8/0x11b
 [<c01f8951>] nfs3svc_decode_writeargs+0x0/0x159
 [<c01ecf0b>] nfsd_dispatch+0xb9/0x190
 [<c03cee15>] svc_authenticate+0x4d/0x7c
 [<c03cc5f2>] svc_process+0x46b/0x5c2
 [<c01148cc>] default_wake_function+0x0/0xc
 [<c01ecc8d>] nfsd+0x1c1/0x386
 [<c0103952>] ret_from_fork+0x6/0x14
 [<c01ecacc>] nfsd+0x0/0x386
 [<c0101f6d>] kernel_thread_helper+0x5/0xb

Code: e8 e8 2f f2 ff ff 85 c0 b8 ff ff ff ff 0f 44 d8 8b 86 6c 01 00 00 8b
4c 24 10 03 48 10 39 4d 08 73 09 8b 44 24 10 39 45 0c 73 08 <0f> 0b ae 03
f5 4f 41 c0 8b 54 24 38 8b 4c 24 18 89 f0 89 14 24

