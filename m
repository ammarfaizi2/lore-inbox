Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWKHR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWKHR1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWKHR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:27:54 -0500
Received: from pat.uio.no ([129.240.10.4]:949 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1754607AbWKHR1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:27:53 -0500
Subject: Re: Kernel error messages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marco Schwarz <marco.schwarz@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061108141801.241790@gmx.net>
References: <20061108141801.241790@gmx.net>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 09:27:43 -0800
Message-Id: <1163006863.5712.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 15:18 +0100, Marco Schwarz wrote:
> Hi,
> 
> with a vanilla 2.6.18.2 Kernel I get the following messages when I run a process with high CPU/memory consumption:
> 
> Nov  8 15:08:24 linux kernel: BUG: unable to handle kernel paging request at virtual address 6e696c43
> Nov  8 15:08:24 linux kernel:  printing eip:
> Nov  8 15:08:12 linux last message repeated 146 times
> Nov  8 15:08:24 linux kernel: c043d3d5
> Nov  8 15:08:24 linux kernel: *pde = 00000000
> Nov  8 15:08:24 linux kernel: Oops: 0000 [#1]
> Nov  8 15:08:24 linux kernel: SMP
> Nov  8 15:08:24 linux kernel: Modules linked in:
> Nov  8 15:08:24 linux kernel: CPU:    1
> Nov  8 15:08:24 linux kernel: EIP:    0060:[<c043d3d5>]    Not tainted VLI
> Nov  8 15:08:24 linux kernel: EFLAGS: 00010246   (2.6.18.2 #8)
> Nov  8 15:08:24 linux kernel: EIP is at rpcauth_refreshcred+0x15/0x50
> Nov  8 15:08:24 linux kernel: eax: df6df240   ebx: df6df240   ecx: 00000001   edx: 6e696c2f
> Nov  8 15:08:24 linux kernel: esi: df1b5000   edi: 00000000   ebp: df6df2a8   esp: d8ccfd00
> Nov  8 15:08:24 linux kernel: ds: 007b   es: 007b   ss: 0068
> Nov  8 15:08:24 linux kernel: Process ln (pid: 11343, ti=d8cce000 task=d5d5a030 task.ti=d8cce000)
> Nov  8 15:08:24 linux kernel: Stack: df6df240 00000000 c043bfcd df6df240 00000000 d8ccfd48 d8ccfd20 c0436ecd
> Nov  8 15:08:24 linux kernel:        00000000 00000000 df1e1410 df1b5000 d8ccfd58 00000006 c01ff735 dd24e7a4
> Nov  8 15:08:24 linux kernel:        df1e12f8 df1e12f0 c050ee20 d8ccfd68 00000006 df1b5000 00000017 d8ccfed8
> Nov  8 15:08:24 linux kernel: Call Trace:
> Nov  8 15:08:24 linux kernel:  [<c043bfcd>] __rpc_execute+0x4d/0x1f0
> Nov  8 15:08:24 linux kernel:  [<c0436ecd>] rpc_call_sync+0x8d/0xb0
> Nov  8 15:08:24 linux kernel:  [<c01ff735>] nfs_proc_symlink+0xd5/0x150
> Nov  8 15:08:24 linux kernel:  [<c01f8159>] nfs_symlink+0x89/0x190
> Nov  8 15:08:24 linux kernel:  [<c0175556>] d_alloc+0xf6/0x180
> Nov  8 15:08:24 linux kernel:  [<c0175b1d>] __d_lookup+0x8d/0x110
> Nov  8 15:08:24 linux kernel:  [<c0269e8b>] _atomic_dec_and_lock+0x2b/0x50
> Nov  8 15:08:24 linux kernel:  [<c01793e3>] mntput_no_expire+0x13/0x70
> Nov  8 15:08:24 linux kernel:  [<c016bbe0>] __link_path_walk+0x3f0/0xef0
> Nov  8 15:08:24 linux kernel:  [<c0175b1d>] __d_lookup+0x8d/0x110
> Nov  8 15:08:24 linux kernel:  [<c01f8841>] nfs_permission+0xb1/0x160
> Nov  8 15:08:24 linux kernel:  [<c01f8790>] nfs_permission+0x0/0x160
> Nov  8 15:08:24 linux kernel:  [<c016b23a>] permission+0xba/0xe0
> Nov  8 15:08:24 linux kernel:  [<c016bb83>] __link_path_walk+0x393/0xef0
> Nov  8 15:08:24 linux kernel:  [<c01793e3>] mntput_no_expire+0x13/0x70
> Nov  8 15:08:24 linux kernel:  [<c016c74b>] link_path_walk+0x6b/0xd0
> Nov  8 15:08:24 linux kernel:  [<c0175b1d>] __d_lookup+0x8d/0x110
> Nov  8 15:08:24 linux kernel:  [<c01f8790>] nfs_permission+0x0/0x160
> Nov  8 15:08:24 linux kernel:  [<c016b23a>] permission+0xba/0xe0
> Nov  8 15:08:24 linux kernel:  [<c016e511>] vfs_symlink+0x91/0x100
> Nov  8 15:08:24 linux kernel:  [<c016e5f7>] sys_symlinkat+0x77/0xc0
> Nov  8 15:08:24 linux kernel:  [<c016e651>] sys_symlink+0x11/0x20
> Nov  8 15:08:24 linux kernel:  [<c0102b4d>] sysenter_past_esp+0x56/0x79
> Nov  8 15:08:24 linux kernel: Code: e8 31 16 ce ff 83 c4 10 eb a2 8d b6 00 00 00 00 8d bf 00 00 00 00 56 53 8b 70 28 89 c3 f6 05 68 da 67 c0 10 75 16 8b 56 08 89 d8 <ff> 52 14 8
> 5 c0 78 04 5b 5e c3 90 89 43 18 5b 5e c3 56 8b 40 10
> Nov  8 15:08:24 linux kernel: EIP: [<c043d3d5>] rpcauth_refreshcred+0x15/0x50 SS:ESP 0068:d8ccfd00
> 
> Anyone knows what could be going wrong ?

Some credential appears to be corrupt. What mount options are you
running with?

Cheers,
  Trond

