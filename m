Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTFCGVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 02:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTFCGVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 02:21:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42376 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264934AbTFCGVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 02:21:09 -0400
Date: Mon, 02 Jun 2003 23:34:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Alex Tomas <bzzz@tmi.comex.ru>
Subject: ext3 semaphore tracing
Message-ID: <215070000.1054622052@[10.10.2.4]>
In-Reply-To: <32370000.1054338684@[10.10.2.4]>
References: <20030527004255.5e32297b.akpm@digeo.com><1980000.1054189401@[10.10.2.4]><18080000.1054233607@[10.10.2.4]><20030529115237.33c9c09a.akpm@digeo.com><39810000.1054240214@[10.10.2.4]><20030529141405.4578b72c.akpm@digeo.com><12430000.1054309916@[10.10.2.4]> <20030530094344.74a0e617.akpm@digeo.com> <32370000.1054338684@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some idiot wrote:
>
> I had the sem tracing one in there too, but got no output. I might have
> another look at that later on ...

Seems to be moron-related ass-locating-with-both-hands error on my part.

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c010e056>] alloc_ldt+0x6a/0x1a0
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c014858d>] sys_chmod+0x9d/0xc8
 [<c01552cd>] path_release+0xd/0x30
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c0180c8d>] ext3_unlink+0xed/0x150
 [<c0180ca5>] ext3_unlink+0x105/0x150
 [<c0157278>] vfs_unlink+0x110/0x150
 [<c0157361>] sys_unlink+0xa9/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c0148662>] chown_common+0xaa/0xc8
 [<c01486b3>] sys_chown+0x33/0x48
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb


 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c014858d>] sys_chmod+0x9d/0xc8
 [<c01552cd>] path_release+0xd/0x30
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad20>] ext3_delete_inode+0x94/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad20>] ext3_delete_inode+0x94/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c0148662>] chown_common+0xaa/0xc8
 [<c01486b3>] sys_chown+0x33/0x48
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c0148003>] sys_utime+0xdb/0x104
 [<c01552cd>] path_release+0xd/0x30
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c0148662>] chown_common+0xaa/0xc8
 [<c01486b3>] sys_chown+0x33/0x48
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181364>] .text.lock.namei+0x19/0x35
 [<c0160a83>] inode_setattr+0xd7/0xe4
 [<c017da31>] ext3_setattr+0xf1/0x120
 [<c0160be0>] notify_change+0xe0/0x14c
 [<c014858d>] sys_chmod+0x9d/0xc8
 [<c01552cd>] path_release+0xd/0x30
 [<c0148c7b>] sys_close+0x53/0x6c
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c0180add>] ext3_rmdir+0xa1/0x164
 [<c0180b30>] ext3_rmdir+0xf4/0x164
 [<c0156ebf>] d_unhash+0x3b/0x74
 [<c0157021>] vfs_rmdir+0x129/0x17c
 [<c0157127>] sys_rmdir+0xb3/0xf4well
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb

Call Trace:
 [<c0107b4e>] __down+0x96/0x114
 [<c0118888>] default_wake_function+0x0/0x20
 [<c0107d48>] __down_failed+0x8/0xc
 [<c0181350>] .text.lock.namei+0x5/0x35
 [<c017ce51>] ext3_truncate+0x119/0x3d4
 [<c018460e>] new_handle+0xe/0x48
 [<c01846d1>] journal_start+0x89/0xb8
 [<c01813b2>] ext3_journal_start+0x32/0x50
 [<c017abeb>] start_transaction+0x13/0x40
 [<c017ad16>] ext3_delete_inode+0x8a/0xe0
 [<c017ac8c>] ext3_delete_inode+0x0/0xe0
 [<c015ffa3>] generic_delete_inode+0x6b/0xd4
 [<c0160134>] generic_drop_inode+0x10/0x20
 [<c01601aa>] iput+0x66/0x6c
 [<c01573a9>] sys_unlink+0xf1/0x130
 [<c0108c87>] syscall_call+0x7/0xb



