Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTFMCBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbTFMCBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:01:13 -0400
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:21938 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265105AbTFMCBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:01:09 -0400
Date: Thu, 12 Jun 2003 22:14:55 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel crash dumps with 2.5.70-mm8
Message-ID: <Pine.LNX.4.55L-032.0306122212080.4915@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

These don't seem to matter much, but thought I'd share anyway.

inserting floppy driver for 2.5.70-mm8
Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c01c8118
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01c8118>]    Not tainted VLI
EFLAGS: 00010202
EIP is at devfs_get+0x8/0x10
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: 00000000   edx: 00000014
esi: c03e9ba0   edi: d6564224   ebp: 00000000   esp: d4c53e9c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3017, threadinfo=d4c52000 task=d4d034a0)
Stack: c01c9298 6b6b6b6b 000000d0 0000006b 00000068 c01c85db d6fdac78
00000286
       00006b6b 00000000 d4d436ac 00000000 c03e6420 c01c9489 d4d436ac
00000000
       00006b6b 00000000 00000000 c03e9ba0 d4c53f10 c01c9b35 d4d436ac
00000000
Call Trace:
 [<c01c9298>] devfsd_notify_de+0x68/0x210
 [<c01c85db>] _devfs_append_entry+0xbb/0x120
 [<c01c9489>] devfsd_notify+0x49/0x60
 [<c01c9b35>] devfs_mk_dir+0xc5/0x140
 [<c015b4a4>] kmem_cache_alloc+0x134/0x160
 [<c0261132>] rand_initialize_disk+0x22/0x50
 [<c020184d>] kobject_init+0x2d/0x50
 [<c0278273>] alloc_disk+0xa3/0xd0
 [<d790fca3>] floppy_init+0x43/0x600 [floppy]
 [<d7a3d073>] +0x17/0xaa4 [floppy]
 [<d7a42260>] +0x0/0x100 [floppy]
 [<c014a206>] sys_init_module+0x1e6/0x380
 [<d7a42260>] +0x0/0x100 [floppy]
 [<c017ab72>] sys_read+0x42/0x70
 [<c010b13b>] syscall_call+0x7/0xb

Code: 80 1c c0 0d 00 00 00 80 89 54 24 0c 89 44 24 08 e9 ce d9 fb ff 90 90
90 90
 90 90 90 90 90 90 90 90 90 90 8b 44 24 04 85 c0 74 03 <ff> 40 04 c3 8d 74
26 00
 83 ec 10 89 5c 24 0c 8b 5c 24 14 85 db

 <3>Slab corruption: start=d4d436ac, expend=d4d4370b, problemat=d4d436b0
Last user: [<c01c85db>](_devfs_append_entry+0xbb/0x120)
Data: ****6C
*******************************************************************
***********************A5
Next: 71 F0 2C .DB 85 1C C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `size-96': object was modified
after fre
eing
Call Trace:
 [<c01592d8>] check_poison_obj+0x158/0x1b0
 [<c015b62a>] __kmalloc+0x15a/0x1a0
 [<c01b7ce7>] load_elf_interp+0xa7/0x250
 [<c01b7ce7>] load_elf_interp+0xa7/0x250
 [<c01b83df>] load_elf_binary+0x3ef/0xb20
 [<c0125510>] autoremove_wake_function+0x0/0x50
 [<c01b7ff0>] load_elf_binary+0x0/0xb20
 [<c018d6e8>] search_binary_handler+0xb8/0x2b0
 [<c018daec>] do_execve+0x20c/0x260
 [<c0108ae0>] sys_execve+0x50/0x80
 [<c010b13b>] syscall_call+0x7/0xb

- --nwf;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6TN1R4WVIgmDWjIRAp+RAJ98egL1CImsoG2QRei9+6zfsPh9BACgvu6+
GU+nkORxKaW/5fYX60Jpdb8=
=w0mE
-----END PGP SIGNATURE-----

