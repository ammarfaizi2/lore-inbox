Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUCNELV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUCNELM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:11:12 -0500
Received: from holomorphy.com ([207.189.100.168]:9484 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263271AbUCNEKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:10:51 -0500
Date: Sat, 13 Mar 2004 20:10:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm4 scsi_delete_timer() oops
Message-ID: <20040314041047.GK655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mar 13 19:41:59 holomorphy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mar 13 19:41:59 holomorphy kernel:  printing eip:
Mar 13 19:41:59 holomorphy kernel: 00000000
Mar 13 19:41:59 holomorphy kernel: *pde = 00000000
Mar 13 19:41:59 holomorphy kernel: Oops: 0000 [#1]
Mar 13 19:41:59 holomorphy kernel: CPU:    0
Mar 13 19:41:59 holomorphy kernel: EIP:    0060:[<00000000>]    Not tainted VLI
Mar 13 19:41:59 holomorphy kernel: EFLAGS: 00010286
Mar 13 19:41:59 holomorphy kernel: EIP is at 0x0
Mar 13 19:41:59 holomorphy kernel: eax: 00000000   ebx: d5fbff64   ecx: c061e000   edx: ed1ad040
Mar 13 19:41:59 holomorphy kernel: esi: 5015a947   edi: 0000000c   ebp: 00000000   esp: d5fbec58
Mar 13 19:41:59 holomorphy kernel: ds: 007b   es: 007b   ss: 0068
Mar 13 19:41:59 holomorphy kernel: Process xmms (pid: 12324, threadinfo=d5fbe000 task=c0e74180)
Mar 13 19:41:59 holomorphy kernel: Stack: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Mar 13 19:41:59 holomorphy kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Mar 13 19:41:59 holomorphy kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Mar 13 19:41:59 holomorphy kernel: Call Trace:
Mar 13 19:41:59 holomorphy kernel:  [<c0358076>] scsi_delete_timer+0x16/0x30
Mar 13 19:41:59 holomorphy kernel:  [<c0373de9>] ahc_linux_run_complete_queue+0x69/0xd0
Mar 13 19:41:59 holomorphy kernel:  [<c011872d>] scheduler_tick+0x1d/0x520
Mar 13 19:41:59 holomorphy kernel:  [<c01238c6>] update_process_times+0x46/0x60
Mar 13 19:41:59 holomorphy kernel:  [<c012372b>] update_wall_time+0xb/0x40
Mar 13 19:41:59 holomorphy kernel:  [<c0123b7f>] do_timer+0xdf/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c01119d9>] timer_interrupt+0x29/0x110
Mar 13 19:41:59 holomorphy kernel:  [<c03e4274>] kfree_skbmem+0x24/0x30
Mar 13 19:41:59 holomorphy kernel:  [<c03e4308>] __kfree_skb+0x88/0x100
Mar 13 19:41:59 holomorphy kernel:  [<c03131b9>] ei_start_xmit+0x179/0x2d0
Mar 13 19:41:59 holomorphy kernel:  [<c03f31df>] qdisc_restart+0x1f/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c03e4274>] kfree_skbmem+0x24/0x30
Mar 13 19:41:59 holomorphy kernel:  [<c03e4308>] __kfree_skb+0x88/0x100
Mar 13 19:41:59 holomorphy kernel:  [<c04588ed>] packet_rcv_spkt+0x13d/0x220
Mar 13 19:41:59 holomorphy kernel:  [<c03e84d7>] dev_queue_xmit_nit+0xa7/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c03f31df>] qdisc_restart+0x1f/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c03e883c>] dev_queue_xmit+0x16c/0x1f0
Mar 13 19:41:59 holomorphy kernel:  [<c0414ebc>] ip_finish_output2+0x9c/0x1e0
Mar 13 19:41:59 holomorphy kernel:  [<c0414e20>] ip_finish_output2+0x0/0x1e0
Mar 13 19:41:59 holomorphy kernel:  [<c03f25f2>] nf_hook_slow+0xd2/0x120
Mar 13 19:41:59 holomorphy kernel:  [<c0414e20>] ip_finish_output2+0x0/0x1e0
Mar 13 19:41:59 holomorphy kernel:  [<c0412b58>] ip_finish_output+0x1f8/0x200
Mar 13 19:41:59 holomorphy kernel:  [<c0414e20>] ip_finish_output2+0x0/0x1e0
Mar 13 19:41:59 holomorphy kernel:  [<c0414e04>] dst_output+0x14/0x30
Mar 13 19:41:59 holomorphy kernel:  [<c03f25f2>] nf_hook_slow+0xd2/0x120
Mar 13 19:41:59 holomorphy kernel:  [<c0414df0>] dst_output+0x0/0x30
Mar 13 19:41:59 holomorphy kernel:  [<c01359ef>] mempool_alloc+0x6f/0x120
Mar 13 19:41:59 holomorphy kernel:  [<c011a620>] autoremove_wake_function+0x0/0x50
Mar 13 19:41:59 holomorphy kernel:  [<c011a620>] autoremove_wake_function+0x0/0x50
Mar 13 19:41:59 holomorphy kernel:  [<c01359ef>] mempool_alloc+0x6f/0x120
Mar 13 19:41:59 holomorphy kernel:  [<c02ec91e>] cfq_add_crq_rb+0x7e/0x90
Mar 13 19:41:59 holomorphy kernel:  [<c01359ef>] mempool_alloc+0x6f/0x120
Mar 13 19:41:59 holomorphy kernel:  [<c011a620>] autoremove_wake_function+0x0/0x50
Mar 13 19:41:59 holomorphy kernel:  [<c0377a38>] ahc_linux_run_device_queue+0x468/0x900
Mar 13 19:41:59 holomorphy kernel:  [<c03741b1>] ahc_linux_queue+0x1c1/0x290
Mar 13 19:41:59 holomorphy kernel:  [<c02ecdbd>] cfq_next_request+0x5d/0x70
Mar 13 19:41:59 holomorphy kernel:  [<c0118f63>] schedule+0x323/0x530
Mar 13 19:41:59 holomorphy kernel:  [<c035a65b>] scsi_request_fn+0x1ab/0x270
Mar 13 19:41:59 holomorphy kernel:  [<c0132e77>] wait_on_page_bit+0xa7/0xc0
Mar 13 19:41:59 holomorphy kernel:  [<c011a620>] autoremove_wake_function+0x0/0x50
Mar 13 19:41:59 holomorphy kernel:  [<c0132cf0>] add_to_page_cache+0x60/0xc0
Mar 13 19:41:59 holomorphy kernel:  [<c01337c9>] file_read_actor+0xd9/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c0133445>] do_generic_mapping_read+0x105/0x3b0
Mar 13 19:41:59 holomorphy kernel:  [<c01336f0>] file_read_actor+0x0/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c013398e>] __generic_file_aio_read+0x1ae/0x1e0
Mar 13 19:41:59 holomorphy kernel:  [<c01336f0>] file_read_actor+0x0/0xf0
Mar 13 19:41:59 holomorphy kernel:  [<c0133a1a>] generic_file_aio_read+0x5a/0x80
Mar 13 19:41:59 holomorphy kernel:  [<c014c71b>] do_sync_read+0x8b/0xc0
Mar 13 19:41:59 holomorphy kernel:  [<c011815e>] recalc_task_prio+0x8e/0x1b0
Mar 13 19:41:59 holomorphy kernel:  [<c0118f63>] schedule+0x323/0x530
Mar 13 19:41:59 holomorphy kernel:  [<c0118ac9>] scheduler_tick+0x3b9/0x520
Mar 13 19:41:59 holomorphy kernel:  [<c0123d0c>] schedule_timeout+0x6c/0xc0
Mar 13 19:41:59 holomorphy kernel:  [<c0123c60>] process_timeout+0x0/0x10
Mar 13 19:41:59 holomorphy kernel:  [<c0123f1e>] sys_nanosleep+0xfe/0x1b0
Mar 13 19:41:59 holomorphy kernel:  [<c046d173>] syscall_call+0x7/0xb
Mar 13 19:41:59 holomorphy kernel: 
Mar 13 19:41:59 holomorphy kernel: Code:  Bad EIP value.
