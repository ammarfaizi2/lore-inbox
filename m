Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUCBMcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUCBMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:31:55 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:31229 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S261627AbUCBMbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:31:45 -0500
Subject: Re: Oopses with both recent 2.4.x kernels and 2.6.x kernels
From: Stian Jordet <liste@jordet.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078225389.931.3.camel@buick.jordet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	 <Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
	 <1078225389.931.3.camel@buick.jordet>
Content-Type: multipart/mixed; boundary="=-qJlxHOWFCVgiZ3FPXjKW"
Message-Id: <1078230684.934.0.camel@buick.jordet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 13:31:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qJlxHOWFCVgiZ3FPXjKW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Btw, here is one of the 2.6.x oopses as well (as you requested).

Best regards,
Stian

--=-qJlxHOWFCVgiZ3FPXjKW
Content-Disposition: attachment; filename=syslog.txt
Content-Type: text/plain; name=syslog.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Jan 20 00:20:04 dodge kernel: ------------[ cut here ]------------
Jan 20 00:20:04 dodge kernel: kernel BUG at mm/page_alloc.c:201!
Jan 20 00:20:04 dodge kernel: invalid operand: 0000 [#1]
Jan 20 00:20:04 dodge kernel: CPU:    0
Jan 20 00:20:04 dodge kernel: EIP:    0060:[free_pages_bulk+482/512]    Not tainted
Jan 20 00:20:04 dodge kernel: EFLAGS: 00010002
Jan 20 00:20:04 dodge kernel: EIP is at free_pages_bulk+0x1e2/0x200
Jan 20 00:20:04 dodge kernel: eax: 00000001   ebx: c00609c8   ecx: 00000000   edx: 666026a5
Jan 20 00:20:04 dodge kernel: esi: 666026a4   edi: ffffffff   ebp: 33301352   esp: c86d5d90
Jan 20 00:20:04 dodge kernel: ds: 007b   es: 007b   ss: 0068
Jan 20 00:20:04 dodge kernel: Process mrtg (pid: 26804, threadinfo=c86d4000 task=c9b860c0)
Jan 20 00:20:04 dodge kernel: Stack: c038ad80 c00609c8 00000000 c038ae40 00000001 c00609a0 c038adbc 00000000 
Jan 20 00:20:04 dodge kernel:        c1000000 c038adbc 00000086 ffffffff c038ad80 c00609a0 c038ae5c 00000246 
Jan 20 00:20:04 dodge kernel:        c01341b9 c038ad80 00000000 c038ae5c 00000000 c038ad80 c00609a0 00000005 
Jan 20 00:20:04 dodge kernel: Call Trace:
Jan 20 00:20:04 dodge kernel:  [free_hot_cold_page+217/240] free_hot_cold_page+0xd9/0xf0
Jan 20 00:20:04 dodge kernel:  [do_generic_mapping_read+714/1008] do_generic_mapping_read+0x2ca/0x3f0
Jan 20 00:20:04 dodge kernel:  [file_read_actor+0/256] file_read_actor+0x0/0x100
Jan 20 00:20:04 dodge kernel:  [__generic_file_aio_read+454/512] __generic_file_aio_read+0x1c6/0x200
Jan 20 00:20:04 dodge kernel:  [file_read_actor+0/256] file_read_actor+0x0/0x100
Jan 20 00:20:04 dodge kernel:  [generic_file_aio_read+91/128] generic_file_aio_read+0x5b/0x80
Jan 20 00:20:04 dodge kernel:  [do_sync_read+137/192] do_sync_read+0x89/0xc0
Jan 20 00:20:04 dodge kernel:  [do_page_fault+300/1328] do_page_fault+0x12c/0x530
Jan 20 00:20:04 dodge kernel:  [do_brk+324/560] do_brk+0x144/0x230
Jan 20 00:20:04 dodge kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Jan 20 00:20:04 dodge kernel:  [sys_read+66/112] sys_read+0x42/0x70
Jan 20 00:20:04 dodge kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 20 00:20:04 dodge kernel: 
Jan 20 00:20:04 dodge kernel: Code: 0f 0b c9 00 9b d1 34 c0 e9 51 ff ff ff 0f 0b bc 00 9b d1 34 
Jan 20 00:20:04 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 00100104
Jan 20 00:20:04 dodge kernel:  printing eip:
Jan 20 00:20:04 dodge kernel: c0133cbf
Jan 20 00:20:04 dodge kernel: *pde = 00000000
Jan 20 00:20:04 dodge kernel: Oops: 0002 [#2]
Jan 20 00:20:04 dodge kernel: CPU:    0
Jan 20 00:20:04 dodge kernel: EIP:    0060:[free_pages_bulk+143/512]    Not tainted
Jan 20 00:20:04 dodge kernel: EFLAGS: 00010003
Jan 20 00:20:04 dodge kernel: EIP is at free_pages_bulk+0x8f/0x200
Jan 20 00:20:04 dodge kernel: eax: c00609a8   ebx: c038ae5c   ecx: 00200200   edx: 00100100
Jan 20 00:20:04 dodge kernel: esi: c00609a0   edi: c038ae5c   ebp: 00000203   esp: c86d5b34
Jan 20 00:20:04 dodge kernel: ds: 007b   es: 007b   ss: 0068
Jan 20 00:20:04 dodge kernel: Process mrtg (pid: 26804, threadinfo=c86d4000 task=c9b860c0)
Jan 20 00:20:04 dodge kernel: Stack: c11a48c0 00268000 00000000 c038af54 00000001 c1044d20 c038aed0 00000000 
Jan 20 00:20:04 dodge kernel:        c1000000 c038adbc 00000082 ffffffff c038ad80 c100a230 c038ae5c 00000203 
Jan 20 00:20:04 dodge kernel:        c01341b9 c038ad80 00000000 c038ae5c 00000000 c038ad80 c5c7ac0c 0020d000 
Jan 20 00:20:04 dodge kernel: Call Trace:
Jan 20 00:20:04 dodge kernel:  [free_hot_cold_page+217/240] free_hot_cold_page+0xd9/0xf0
Jan 20 00:20:04 dodge kernel:  [zap_pte_range+334/400] zap_pte_range+0x14e/0x190
Jan 20 00:20:04 dodge kernel:  [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
Jan 20 00:20:04 dodge kernel:  [unmap_page_range+75/128] unmap_page_range+0x4b/0x80
Jan 20 00:20:04 dodge kernel:  [unmap_vmas+254/544] unmap_vmas+0xfe/0x220
Jan 20 00:20:04 dodge kernel:  [exit_mmap+109/384] exit_mmap+0x6d/0x180
Jan 20 00:20:04 dodge kernel:  [mmput+81/160] mmput+0x51/0xa0
Jan 20 00:20:04 dodge kernel:  [do_exit+290/800] do_exit+0x122/0x320
Jan 20 00:20:04 dodge kernel:  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
Jan 20 00:20:04 dodge kernel:  [die+203/208] die+0xcb/0xd0
Jan 20 00:20:04 dodge kernel:  [do_invalid_op+202/208] do_invalid_op+0xca/0xd0
Jan 20 00:20:04 dodge kernel:  [free_pages_bulk+482/512] free_pages_bulk+0x1e2/0x200
Jan 20 00:20:04 dodge kernel:  [update_wall_time+22/64] update_wall_time+0x16/0x40
Jan 20 00:20:04 dodge kernel:  [do_timer+224/240] do_timer+0xe0/0xf0
Jan 20 00:20:04 dodge kernel:  [timer_interrupt+56/240] timer_interrupt+0x38/0xf0
Jan 20 00:20:04 dodge kernel:  [handle_IRQ_event+73/128] handle_IRQ_event+0x49/0x80
Jan 20 00:20:04 dodge kernel:  [do_IRQ+140/240] do_IRQ+0x8c/0xf0
Jan 20 00:20:04 dodge kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 20 00:20:04 dodge kernel:  [free_pages_bulk+482/512] free_pages_bulk+0x1e2/0x200
Jan 20 00:20:04 dodge kernel:  [free_hot_cold_page+217/240] free_hot_cold_page+0xd9/0xf0
Jan 20 00:20:04 dodge kernel:  [do_generic_mapping_read+714/1008] do_generic_mapping_read+0x2ca/0x3f0
Jan 20 00:20:04 dodge kernel:  [file_read_actor+0/256] file_read_actor+0x0/0x100
Jan 20 00:20:04 dodge kernel:  [__generic_file_aio_read+454/512] __generic_file_aio_read+0x1c6/0x200
Jan 20 00:20:04 dodge kernel:  [file_read_actor+0/256] file_read_actor+0x0/0x100
Jan 20 00:20:04 dodge kernel:  [generic_file_aio_read+91/128] generic_file_aio_read+0x5b/0x80
Jan 20 00:20:04 dodge kernel:  [do_sync_read+137/192] do_sync_read+0x89/0xc0
Jan 20 00:20:04 dodge kernel:  [do_page_fault+300/1328] do_page_fault+0x12c/0x530
Jan 20 00:20:04 dodge kernel:  [do_brk+324/560] do_brk+0x144/0x230
Jan 20 00:20:04 dodge kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Jan 20 00:20:04 dodge kernel:  [sys_read+66/112] sys_read+0x42/0x70
Jan 20 00:20:04 dodge kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

--=-qJlxHOWFCVgiZ3FPXjKW--

