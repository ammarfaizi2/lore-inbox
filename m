Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUDMR7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUDMR7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:59:08 -0400
Received: from [63.81.117.28] ([63.81.117.28]:50135 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263603AbUDMR7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:59:04 -0400
Message-ID: <407C2929.20401@xfs.org>
Date: Tue, 13 Apr 2004 12:53:45 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gustavo Franco <stratus@acm.org>
CC: linux-kernel@vger.kernel.org, XFS Linux <linux-xfs@oss.sgi.com>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.5 - kernel BUG at fs/xfs/support/debug.c:106!
References: <407B4479.7090702@acm.org>
In-Reply-To: <407B4479.7090702@acm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Franco wrote:

xfs_iget_core: ambiguous vns: vp/0xed46edc0, invp/0xc79b9b00
------------[ cut here ]------------
kernel BUG at fs/xfs/support/debug.c:106!
invalid operand: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c0250a1e>]    Not tainted
EFLAGS: 00010246   (2.6.5)
EIP is at cmn_err+0x9e/0xb0
eax: 00000040   ebx: 00000000   ecx: 00000002   edx: c03b55bc
esi: c0384e2f   edi: c0480f1e   ebp: 00000293   esp: dd081d48
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 951, threadinfo=dd080000 task=f167b920)
Stack: c036f000 c0375165 c0480ee0 c037ecc0 004d8ea0 00000000 d2c1d680 c021d07e
        00000000 c037ecc0 ed46edc0 c79b9b00 c016deca f6569c00 c1ad2e00 f64b08a4
        f63da128 dd080000 f6569c00 c1ad2e00 f64b08a0 00000000 00000000 d2c1d680
Call Trace:
  [<c021d07e>] xfs_iget_core+0x4ae/0x5d0
  [<c016deca>] get_new_inode_fast+0x4a/0xf0
  [<c021d302>] xfs_iget+0x162/0x1a0
  [<c023a5fc>] xfs_dir_lookup_int+0xac/0x130
  [<c023fe50>] xfs_lookup+0x50/0x90
  [<c024c71f>] linvfs_lookup+0x5f/0xa0
  [<c0161b95>] real_lookup+0xd5/0x100
  [<c0161e36>] do_lookup+0x96/0xb0
  [<c01622ec>] link_path_walk+0x49c/0x900
  [<c0162ca9>] __user_walk+0x49/0x60
  [<c015da3c>] vfs_lstat+0x1c/0x60
  [<c015e1ab>] sys_lstat64+0x1b/0x40
  [<c0106fff>] syscall_call+0x7/0xb

Code: 0f 0b 6a 00 85 51 37 c0 83 c4 0c 5b 5e 5f 5d c3 89 f6 83 ec

This has been seen before on nfs servers, Christoph was looking into
it.

Steve
