Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbTCDMKe>; Tue, 4 Mar 2003 07:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269398AbTCDMKe>; Tue, 4 Mar 2003 07:10:34 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51641 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269395AbTCDMKd>;
	Tue, 4 Mar 2003 07:10:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: oops Re: 2.5.63-mm2
Date: Tue, 4 Mar 2003 23:20:50 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303042320.50458.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops running contest:

Unable to handle kernel paging request at virtual address 9acfdcf2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c016d525>]    Not tainted
EFLAGS: 00010246
EIP is at ext3_free_branches+0x1d/0x210
eax: 9acfdcf2   ebx: c6c8d610   ecx: cdf422c0   edx: c9120000
esi: c7ff6dc0   edi: 0001401f   ebp: c2883eb4   esp: c2883e04
ds: 007b   es: 007b   ss: 0068
Process dbench (pid: 7379, threadinfo=c2882000 task=c1717900)
Stack: c6c8d610 c7ff6dc0 0001401f c2883eb4 c2883e14 c2883e14 c013f59c c6c8d610
       c2883eac c016d5d6 c7ff6dc0 cdf422c0 c6c8d610 c911f000 c9120000 00000000
       c2883eac 00000000 00000001 c7ff6dc0 00000400 cdf42240 00000001 c016d891
Call Trace:
 [<c013f59c>] __bread_slow+0x6c/0x94
 [<c016d5d6>] ext3_free_branches+0xce/0x210
 [<c016d891>] ext3_truncate+0x179/0x4b8
 [<c016da65>] ext3_truncate+0x34d/0x4b8
 [<c017b9a7>] __jbd_kmalloc+0x1b/0x6c
 [<c0175c13>] start_this_handle+0x157/0x1a0
 [<c0175d30>] journal_start+0x8c/0xb8
 [<c016b14f>] start_transaction+0x57/0x84
 [<c016b1e4>] ext3_delete_inode+0x0/0x190
 [<c016b2c3>] ext3_delete_inode+0xdf/0x190
 [<c016b1e4>] ext3_delete_inode+0x0/0x190
 [<c015284f>] generic_delete_inode+0x8b/0xb4
 [<c0152988>] generic_drop_inode+0x10/0x24
 [<c0152a02>] iput+0x66/0x6c
 [<c01500f6>] dput+0x16a/0x1a0
 [<c013e378>] __fput+0x94/0xb4
 [<c013e2e3>] fput+0x13/0x14
 [<c013cec5>] filp_close+0x99/0xa4
 [<c0116cb8>] put_files_struct+0x4c/0xb4
 [<c01176c7>] do_exit+0x1b7/0x354
 [<c011788a>] sys_exit+0xe/0x10
 [<c0108b17>] syscall_call+0x7/0xb

Code: f6 00 02 0f 85 e2 01 00 00 83 6c 24 3c 01 0f 82 b9 01 00 00

Con
