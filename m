Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbTIJS5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbTIJS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:56:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33798
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265499AbTIJSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:55:39 -0400
Date: Wed, 10 Sep 2003 11:55:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030910185537.GB1461@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030828235649.61074690.akpm@osdl.org> <20030910185338.GA1461@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910185338.GA1461@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't modify subject line... :(

Hi,

I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi.  I've been
using it for the last few days straight and I tried copying files from my
ide cdrom using ide-scsi.  cp segfaults, I get this oops, and X hangs.
Syslog was running long enough to capture it, and a sysrq SUB saved it to
disk.

I will be trying a newer kernel soon.  Has this been caught and fixed already?

Sep 10 11:23:27 mis-mike-wstn kernel: sr0: scsi-1 drive
Sep 10 11:23:27 mis-mike-wstn kernel: Uniform CD-ROM driver Revision: 3.12
Sep 10 11:23:27 mis-mike-wstn kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Sep 10 11:24:45 mis-mike-wstn kernel: nfs: server fs not responding, still trying
Sep 10 11:24:47 mis-mike-wstn last message repeated 2 times
Sep 10 11:24:47 mis-mike-wstn kernel: nfs: server fs OK
Sep 10 11:24:47 mis-mike-wstn last message repeated 2 times
Sep 10 11:29:39 mis-mike-wstn kernel: Unable to handle kernel paging request at virtual address 6b6b6b7b
Sep 10 11:29:39 mis-mike-wstn kernel:  printing eip:
Sep 10 11:29:39 mis-mike-wstn kernel: d48894dc
Sep 10 11:29:39 mis-mike-wstn kernel: *pde = 00000000
Sep 10 11:29:39 mis-mike-wstn kernel: Oops: 0000 [#1]
Sep 10 11:29:39 mis-mike-wstn kernel: PREEMPT SMP 
Sep 10 11:29:39 mis-mike-wstn kernel: CPU:    0
Sep 10 11:29:39 mis-mike-wstn kernel: EIP:    0060:[_end+339697948/1068932160]    Not tainted VLI
Sep 10 11:29:39 mis-mike-wstn kernel: EFLAGS: 00010002
Sep 10 11:29:39 mis-mike-wstn kernel: EIP is at idescsi_queue+0x59c/0x614 [ide_scsi]
Sep 10 11:29:39 mis-mike-wstn kernel: eax: 6b6b6b6b   ebx: c2050000   ecx: c2050000   edx: d3357864
Sep 10 11:29:39 mis-mike-wstn kernel: esi: d3357864   edi: c410629c   ebp: c2051d18   esp: c2051ce0
Sep 10 11:29:39 mis-mike-wstn kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 11:29:39 mis-mike-wstn kernel: Process cp (pid: 29140, threadinfo=c2050000 task=ca90e000)
Sep 10 11:29:39 mis-mike-wstn kernel: Stack: d3a94540 00000293 d3a9451c d3a9451c c9e92c00 d33578b8 c461c18c c13cdca0 
Sep 10 11:29:39 mis-mike-wstn kernel:        ffffffff 00000000 d3a946d8 c9e92c00 c410629c c0487b58 c2051d38 c026cf08 
Sep 10 11:29:39 mis-mike-wstn kernel:        d3357864 c026d0d0 c2050000 d3357864 d3680304 00000000 c2051d58 c02724dd 
Sep 10 11:29:39 mis-mike-wstn kernel: Call Trace:
Sep 10 11:29:39 mis-mike-wstn kernel:  [scsi_dispatch_cmd+556/676] scsi_dispatch_cmd+0x22c/0x2a4
Sep 10 11:29:39 mis-mike-wstn kernel:  [scsi_done+0/108] scsi_done+0x0/0x6c
Sep 10 11:29:39 mis-mike-wstn kernel:  [scsi_request_fn+713/1036] scsi_request_fn+0x2c9/0x40c
Sep 10 11:29:39 mis-mike-wstn kernel:  [generic_unplug_device+132/216] generic_unplug_device+0x84/0xd8
Sep 10 11:29:39 mis-mike-wstn kernel:  [blk_run_queues+270/424] blk_run_queues+0x10e/0x1a8
Sep 10 11:29:39 mis-mike-wstn kernel:  [block_sync_page+8/16] block_sync_page+0x8/0x10
Sep 10 11:29:39 mis-mike-wstn kernel:  [wait_on_page_bit_wq+169/228] wait_on_page_bit_wq+0xa9/0xe4
Sep 10 11:29:39 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:39 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:39 mis-mike-wstn kernel:  [do_generic_mapping_read+770/1156] do_generic_mapping_read+0x302/0x484
Sep 10 11:29:39 mis-mike-wstn kernel:  [__generic_file_aio_read+478/508] __generic_file_aio_read+0x1de/0x1fc
Sep 10 11:29:39 mis-mike-wstn kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Sep 10 11:29:39 mis-mike-wstn kernel:  [generic_file_read+171/200] generic_file_read+0xab/0xc8
Sep 10 11:29:39 mis-mike-wstn kernel:  [_end+341016069/1068932160] rpcauth_lookupcred+0x75/0x80 [sunrpc]
Sep 10 11:29:39 mis-mike-wstn kernel:  [cp_new_stat64+224/248] cp_new_stat64+0xe0/0xf8
Sep 10 11:29:39 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:39 mis-mike-wstn kernel:  [sys_fstat64+37/44] sys_fstat64+0x25/0x2c
Sep 10 11:29:39 mis-mike-wstn kernel:  [vfs_read+183/240] vfs_read+0xb7/0xf0
Sep 10 11:29:39 mis-mike-wstn kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 10 11:29:39 mis-mike-wstn kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 10 11:29:39 mis-mike-wstn kernel:  [ip_mc_source+583/892] ip_mc_source+0x247/0x37c
Sep 10 11:29:39 mis-mike-wstn kernel: 
Sep 10 11:29:39 mis-mike-wstn kernel: Code: 08 00 00 00 74 09 e8 a8 6e 89 eb 8d 74 26 00 6a 04 8b 7d f8 57 8b 45 fc 50 e8 01 39 9d eb 83 c4 0c fa ff 43 14 8b 55 08 8b 42 04 <8b> 40 10 8b 58 2c 81 7b 04 ad 4e ad de 74 17 68 e2 94 88 d4 68 
Sep 10 11:29:39 mis-mike-wstn kernel:  <6>note: cp[29140] exited with preempt_count 1
Sep 10 11:29:39 mis-mike-wstn kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Sep 10 11:29:39 mis-mike-wstn kernel: Call Trace:
Sep 10 11:29:39 mis-mike-wstn kernel:  [__might_sleep+99/104] __might_sleep+0x63/0x68
Sep 10 11:29:39 mis-mike-wstn kernel:  [remove_shared_vm_struct+43/132] remove_shared_vm_struct+0x2b/0x84
Sep 10 11:29:39 mis-mike-wstn kernel:  [exit_mmap+485/552] exit_mmap+0x1e5/0x228
Sep 10 11:29:39 mis-mike-wstn kernel:  [mmput+174/204] mmput+0xae/0xcc
Sep 10 11:29:39 mis-mike-wstn kernel:  [do_exit+498/1332] do_exit+0x1f2/0x534
Sep 10 11:29:39 mis-mike-wstn kernel:  [die+351/352] die+0x15f/0x160
Sep 10 11:29:39 mis-mike-wstn kernel:  [do_page_fault+733/1045] do_page_fault+0x2dd/0x415
Sep 10 11:29:39 mis-mike-wstn kernel:  [_end+339697948/1068932160] idescsi_queue+0x59c/0x614 [ide_scsi]
Sep 10 11:29:39 mis-mike-wstn kernel:  [do_page_fault+0/1045] do_page_fault+0x0/0x415
Sep 10 11:29:40 mis-mike-wstn kernel:  [recalc_task_prio+377/392] recalc_task_prio+0x179/0x188
Sep 10 11:29:40 mis-mike-wstn kernel:  [schedule+1404/1760] schedule+0x57c/0x6e0
Sep 10 11:29:40 mis-mike-wstn kernel:  [preempt_schedule+43/72] preempt_schedule+0x2b/0x48
Sep 10 11:29:40 mis-mike-wstn kernel:  [ide_do_drive_cmd+354/399] ide_do_drive_cmd+0x162/0x18f
Sep 10 11:29:40 mis-mike-wstn kernel:  [error_code+47/64] error_code+0x2f/0x40
Sep 10 11:29:40 mis-mike-wstn kernel:  [_end+339697948/1068932160] idescsi_queue+0x59c/0x614 [ide_scsi]
Sep 10 11:29:40 mis-mike-wstn kernel:  [scsi_dispatch_cmd+556/676] scsi_dispatch_cmd+0x22c/0x2a4
Sep 10 11:29:40 mis-mike-wstn kernel:  [scsi_done+0/108] scsi_done+0x0/0x6c
Sep 10 11:29:40 mis-mike-wstn kernel:  [scsi_request_fn+713/1036] scsi_request_fn+0x2c9/0x40c
Sep 10 11:29:40 mis-mike-wstn kernel:  [generic_unplug_device+132/216] generic_unplug_device+0x84/0xd8
Sep 10 11:29:40 mis-mike-wstn kernel:  [blk_run_queues+270/424] blk_run_queues+0x10e/0x1a8
Sep 10 11:29:40 mis-mike-wstn kernel:  [block_sync_page+8/16] block_sync_page+0x8/0x10
Sep 10 11:29:40 mis-mike-wstn kernel:  [wait_on_page_bit_wq+169/228] wait_on_page_bit_wq+0xa9/0xe4
Sep 10 11:29:40 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:40 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:40 mis-mike-wstn kernel:  [do_generic_mapping_read+770/1156] do_generic_mapping_read+0x302/0x484
Sep 10 11:29:40 mis-mike-wstn kernel:  [__generic_file_aio_read+478/508] __generic_file_aio_read+0x1de/0x1fc
Sep 10 11:29:40 mis-mike-wstn kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Sep 10 11:29:40 mis-mike-wstn kernel:  [generic_file_read+171/200] generic_file_read+0xab/0xc8
Sep 10 11:29:40 mis-mike-wstn kernel:  [_end+341016069/1068932160] rpcauth_lookupcred+0x75/0x80 [sunrpc]
Sep 10 11:29:40 mis-mike-wstn kernel:  [cp_new_stat64+224/248] cp_new_stat64+0xe0/0xf8
Sep 10 11:29:40 mis-mike-wstn kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Sep 10 11:29:40 mis-mike-wstn kernel:  [sys_fstat64+37/44] sys_fstat64+0x25/0x2c
Sep 10 11:29:40 mis-mike-wstn kernel:  [vfs_read+183/240] vfs_read+0xb7/0xf0
Sep 10 11:29:40 mis-mike-wstn kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 10 11:29:40 mis-mike-wstn kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 10 11:29:40 mis-mike-wstn kernel:  [ip_mc_source+583/892] ip_mc_source+0x247/0x37c


