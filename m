Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbTDXUyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTDXUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:54:34 -0400
Received: from ip-86-8.evc.net ([212.95.86.8]:33921 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S264420AbTDXUyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:54:31 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: some oops
Date: Thu, 24 Apr 2003 23:06:34 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304242306.34824.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are some oops on 2.5.68,
I am not overcloked and tested my ram.
Highmem is activated (1G),
On chipset SIS648

Regards.

Nicolas.

PS: tell me if I'am wrong posting here...

------------[ cut here ]------------
kernel BUG at mm/slab.c:1502!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0137c85>]    Not tainted
EFLAGS: 00010087
EIP is at kmem_cache_free+0x25c/0x2b6
eax: c1870208   ebx: 00870208   ecx: f600d290   edx: f7ffd7d0
esi: 00000084   edi: f600d290   ebp: caecfbf4   esp: caecfbcc
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 5129, threadinfo=caece000 task=f4bf5900)
Stack: 00003000 00003000 c0000000 c0000000 c0149d48 c1bf1afc 00000296 f600d290
       f7ffa53c f7d5e3a8 caecfc14 c0149d48 f7ffd7d0 f600d290 c1b1e4b4 ca7c9954
       ca7c9a38 f608f73c caecfc44 c013f76c ca7c9954 ca7c9908 00000300 00000000
Call Trace:
 [<c0149d48>] __fput+0x87/0xd1
 [<c0149d48>] __fput+0x87/0xd1
 [<c013f76c>] exit_mmap+0x147/0x169
 [<c011a578>] mmput+0x3e/0x80
 [<c0151545>] exec_mmap+0x8e/0xf2
 [<c015160c>] flush_old_exec+0x1a/0x6dd
 [<c0151446>] open_exec+0xbc/0xd6
 [<c01514aa>] kernel_read+0x4a/0x57
 [<c0169289>] load_elf_binary+0x2e3/0xc28
 [<c0134518>] __alloc_pages+0x83/0x2a9
 [<c0151048>] copy_strings+0x1bb/0x22f
 [<c0152037>] search_binary_handler+0xfa/0x19d
 [<c015225e>] do_execve+0x184/0x1c7
 [<c0107af2>] sys_execve+0x4b/0x7a
 [<c0108fe3>] syscall_call+0x7/0xb

Code: 0f 0b de 05 9b be 2b c0 e9 06 fe ff ff 89 7c 24 04 c7 04 24
 ------------[ cut here ]------------
kernel BUG at mm/slab.c:1502!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c0137c85>]    Not tainted
EFLAGS: 00010087
EIP is at kmem_cache_free+0x25c/0x2b6
eax: c1870208   ebx: 00870208   ecx: f600dce0   edx: f7ffd7d0
esi: 00000084   edi: f600dce0   ebp: cac4bf6c   esp: cac4bf44
ds: 007b   es: 007b   ss: 0068
Process local (pid: 5128, threadinfo=cac4a000 task=f6074d00)
Stack: 0000001d 00020002 f600dce0 f7ffa6a4 c0149d48 c1bf1afc 00000296 f600dce0
       f7ffa6a4 d95f9084 cac4bf8c c0149d48 f7ffd7d0 f600dce0 d8d91190 f600dce0
       f4682c1c 00000000 cac4bfa8 c01487e7 f600dce0 f4682c1c f600dce0 bfffe778
Call Trace:
 [<c0149d48>] __fput+0x87/0xd1
 [<c0149d48>] __fput+0x87/0xd1
 [<c01487e7>] filp_close+0x4b/0x74
 [<c0148861>] sys_close+0x51/0x5f
 [<c0108fe3>] syscall_call+0x7/0xb

Code: 0f 0b de 05 9b be 2b c0 e9 06 fe ff ff 89 7c 24 04 c7 04 24

slab error in cache_free_debugcheck(): cache `inode_cache': double free, or 
memory before object was overwritten
Call Trace:
 [<c0137ae8>] kmem_cache_free+0xbf/0x2b6
 [<c015d28e>] destroy_inode+0x4e/0x50
 [<c015d28e>] destroy_inode+0x4e/0x50
 [<c015e12b>] iput+0x56/0x6f
 [<c019e676>] devfs_d_iput+0x74/0x88
 [<c015be10>] dput+0x114/0x141
 [<c015c0f6>] prune_dcache+0x10b/0x10d
 [<c015c3b0>] shrink_dcache_memory+0x3e/0x40
 [<c013999b>] shrink_slab+0x10c/0x153
 [<c013a767>] balance_pgdat+0x119/0x162
 [<c013a894>] kswapd+0xe4/0xe6
 [<c011a2f0>] autoremove_wake_function+0x0/0x4b
 [<c011a2f0>] autoremove_wake_function+0x0/0x4b
 [<c013a7b0>] kswapd+0x0/0xe6
 [<c0107229>] kernel_thread_helper+0x5/0xb

devfs_d_iput(_▒CØÄ ): de: f8a6cc99 dentry: f7c35afc de->dentry: 738b1574
Forcing Oops
------------[ cut here ]------------
kernel BUG at fs/devfs/base.c:2169!
invalid operand: 0000 [#3]
CPU:    0
EIP:    0060:[<c019e65f>]    Not tainted
EFLAGS: 00010286
EIP is at devfs_d_iput+0x5d/0x88
eax: 0000000d   ebx: f8a6cc99   ecx: 00000001   edx: c02f1db8
esi: f7c35afc   edi: f7c33d2c   ebp: c1bc9e68   esp: c1bc9e44
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 6, threadinfo=c1bc8000 task=c1bc7900)
Stack: c02be03b c02ad80e f8a6cce6 f8a6cc99 f7c35afc 738b1574 f7c35afc f7c33d2c
       0000000e c1bc9e84 c015c0f6 f7c35afc f7c33d2c 00000080 c1bc8000 00000412
       c1bc9e94 c015c3b0 00000080 00000080 c1bc9ecc c013999b 00000080 000000d0
Call Trace:
 [<f8a6cce6>] scsi_alloc_sdev+0x12a/0x1a8 [scsi_mod]
 [<f8a6cc99>] scsi_alloc_sdev+0xdd/0x1a8 [scsi_mod]
 [<c015c0f6>] prune_dcache+0x10b/0x10d
 [<c015c3b0>] shrink_dcache_memory+0x3e/0x40
 [<c013999b>] shrink_slab+0x10c/0x153
 [<c013a767>] balance_pgdat+0x119/0x162
 [<c013a894>] kswapd+0xe4/0xe6
 [<c011a2f0>] autoremove_wake_function+0x0/0x4b
 [<c011a2f0>] autoremove_wake_function+0x0/0x4b
 [<c013a7b0>] kswapd+0x0/0xe6
 [<c0107229>] kernel_thread_helper+0x5/0xb

Code: 0f 0b 79 08 49 e0 2b c0 c7 43 20 00 00 00 00 89 3c 24 e8 5f

