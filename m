Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVK0Qaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVK0Qaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVK0Qaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:30:52 -0500
Received: from bay106-f33.bay106.hotmail.com ([65.54.161.43]:43640 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751109AbVK0Qav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:30:51 -0500
Message-ID: <BAY106-F33D9D22D1BA227EE3B323EC8490@phx.gbl>
X-Originating-IP: [151.41.155.187]
X-Originating-Email: [nchiellini@hotmail.com]
From: "Nicolo Chiellini" <nchiellini@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG ] Reiserfs problems
Date: Sun, 27 Nov 2005 17:30:50 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 27 Nov 2005 16:30:50.0656 (UTC) FILETIME=[EDCE3200:01C5F36F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Doing a mv from a disk to another i got this error:

ReiserFS: hdd5: warning: vs-4040: is_reusable: corresponding bit of block 
19420050 does not match required value (i==592, j==21394) test_bit==0
REISERFS: panic (device Null superblock): reiserfs[1882]: assertion !( 
is_reusable (s, block, 1) == 0 ) failed at 
fs/reiserfs/bitmap.c:402:reiserfs_free_block: vs-4071: can not free such 
block

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: ohci_hcd ide_scsi rtc
CPU:    0
EIP:    0060:[<c01b21c2>]    Tainted: G   M  VLI
EFLAGS: 00010286   (2.6.12.3)
EIP is at reiserfs_panic+0x52/0x80
eax: 000000cb   ebx: c043400a   ecx: c24cd520   edx: 00000000
esi: 00000000   edi: 00000140   ebp: c041a732   esp: d17d9b40
ds: 007b   es: 007b   ss: 0068
Process mv (pid: 1882, threadinfo=d17d8000 task=c24cd520)
Stack: c04410e0 c043400a c059b980 df67d000 c0438be0 00000192 c01967b4 
00000000
       c0438be0 0000075a 00000192 c041a732 c3b03edc d17d9ef8 cb00e220 
00000355
       0000037c c01bcf4e d17d9ef8 c3b03edc 01285392 00000001 c019d1fc 
d17d9c44
Call Trace:
[<c01967b4>] reiserfs_free_block+0xd4/0x130
[<c01bcf4e>] prepare_for_delete_or_cut+0x82e/0xb80
[<c019d1fc>] do_balance+0xfc/0x1a0
[<c01be3b9>] reiserfs_cut_from_item+0xd9/0x710
[<c01bed5e>] reiserfs_do_truncate+0x2be/0x6c0
[<c0169b9d>] lookup_hash+0x1d/0x30
[<c01bdd40>] reiserfs_delete_object+0x40/0x90
[<c01a026c>] reiserfs_delete_inode+0x8c/0xe0
[<c01a01e0>] reiserfs_delete_inode+0x0/0xe0
[<c017554e>] generic_delete_inode+0x7e/0x120
[<c01757c3>] iput+0x63/0x90
[<c016b133>] sys_unlink+0xd3/0x120
[<c013a0d6>] __do_IRQ+0xd6/0x120
[<c0102c05>] syscall_call+0x7/0xb
Code: 01 00 00 89 04 24 e8 ae fc ff ff c7 04 24 e0 10 44 c0 85 f6 89 d8 0f 
45 c7 ba 80 b9 59 c0 89 54 24 08 89 44 24 04 e8 be 51 f6 ff <0f> 0b 6a 01 c9 
45 43 c0 c7 04 24 20 11 44 c0 85 f6 b9 80 b9 59

Thanks, Bye


