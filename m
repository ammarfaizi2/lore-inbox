Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSH0IIa>; Tue, 27 Aug 2002 04:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSH0IIa>; Tue, 27 Aug 2002 04:08:30 -0400
Received: from mailer.psp.ucl.ac.be ([130.104.83.246]:56707 "EHLO
	guppy.psp.ucl.ac.be") by vger.kernel.org with ESMTP
	id <S315430AbSH0II3>; Tue, 27 Aug 2002 04:08:29 -0400
Mime-Version: 1.0
Message-Id: <p05100313b990e4f8afb4@[130.104.82.36]>
Date: Tue, 27 Aug 2002 10:12:41 +0200
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Bernard Paris <Bernard.Paris@psp.ucl.ac.be>
Subject: Re: PROBEM: kernel crashes
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

well, I've got a new crash this night.  The message log seems 
different from the previous I've sent you last week:
(note: memtest86 v3.0 does **not**  detect any memory problems). 
Could you tell me if you think it is not a kernel bug and perhaps 
things I could do. Thanks a lot.

Aug 26 23:42:35 PSPweb kernel: age, wrong page on list.
Aug 26 23:42:35 PSPweb kernel: VM: reclaim_page, wrong page on list.
Aug 26 23:42:39 PSPweb last message repeated 98 times
Aug 26 23:42:39 PSPweb kernel: VM: reclg page on list.
Aug 26 23:42:39 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:42:39 PSPweb last message repeated 371 times
Aug 26 23:42:41 PSPweb kernel: g page on list.
Aug 26 23:42:41 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:42:41 PSPweb last message repeated 371 times
Aug 26 23:42:42 PSPweb kernel: g page on list.
Aug 26 23:42:42 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:43:13 PSPweb last message repeated 5097 times
Aug 26 23:43:15 PSPweb kernel: g page on list.
Aug 26 23:43:15 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:43:18 PSPweb last message repeated 869 times
Aug 26 23:43:20 PSPweb kernel: g page on list.
Aug 26 23:43:20 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:43:20 PSPweb last message repeated 371 times
Aug 26 23:43:22 PSPweb kernel: g page on list.
Aug 26 23:43:22 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:43:27 PSPweb last message repeated 1387 times
Aug 26 23:43:30 PSPweb kernel: g page on list.
.... etc etc etc  .....
Aug 26 23:44:14 PSPweb kernel: VM: refill_inactive, wrong page on list.
Aug 26 23:44:41 PSPweb last message repeated 7071 times
Aug 26 23:44:41 PSPweb kernel: VM: reclaim_page, wrong page on list.
Aug 26 23:44:41 PSPweb kernel: VM: reclaim_page, wrong page on list.
Aug 26 23:44:41 PSPweb kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000010
Aug 26 23:44:41 PSPweb kernel:  printing eip:
Aug 26 23:44:41 PSPweb kernel: c012da23
Aug 26 23:44:41 PSPweb kernel: *pde = 00000000
Aug 26 23:44:41 PSPweb kernel: Oops: 0002
Aug 26 23:44:41 PSPweb kernel: appletalk 3c59x iptable_filter 
ip_tables st usb-uhci usbcore aic7xxx sd_mod sc
Aug 26 23:44:41 PSPweb kernel: CPU:    0
Aug 26 23:44:42 PSPweb kernel: EIP:    0010:[<c012da23>]    Not tainted
Aug 26 23:44:42 PSPweb kernel: EFLAGS: 00010203
Aug 26 23:44:42 PSPweb kernel:
Aug 26 23:44:42 PSPweb kernel: EIP is at reclaim_page [kernel] 0xf3 (2.4.18-3)
Aug 26 23:44:42 PSPweb kernel: eax: 00000005   ebx: c02cac8c   ecx: 
00000000   edx: c11760a0
Aug 26 23:44:42 PSPweb kernel: esi: c02cac70   edi: c02cac8c   ebp: 
c02cac5c   esp: c7a09e6c
Aug 26 23:44:42 PSPweb kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 23:44:42 PSPweb kernel: Process dump (pid: 12978, stackpage=c7a09000)
Aug 26 23:44:42 PSPweb kernel: Stack: c02cac94 0000028d 00000000 
c02cac5c c02cac5c 00000000 000000e1 c012fad3
Aug 26 23:44:42 PSPweb kernel:        c02cac5c c02cae18 c012fc37 
00000001 00000001 c02cae14 000001d0 c75cf304
Aug 26 23:44:42 PSPweb kernel:        00000002 0007404d c7ff8328 
c0127807 c4ec35f0 c4ec35f0 00000002 0007404b
Aug 26 23:44:42 PSPweb kernel: Call Trace: [<c012fad3>] 
fixup_freespace [kernel] 0xf
Aug 26 23:44:42 PSPweb kernel: [<c012fc37>] __alloc_pages [kernel] 0x87
Aug 26 23:44:42 PSPweb kernel: [<c0127807>] page_cache_read [kernel] 0x5f
Aug 26 23:44:42 PSPweb kernel: [<c0127ecf>] generic_file_readahead 
[kernel] 0x113
Aug 26 23:44:42 PSPweb kernel: [<c012820e>] do_generic_file_read [kernel] 0x2f6
Aug 26 23:44:42 PSPweb kernel: [<c01286dd>] generic_file_read [kernel] 0x9d
Aug 26 23:44:42 PSPweb kernel: [<c01285bc>] file_read_actor [kernel] 0x0
Aug 26 23:44:42 PSPweb kernel: [<c0135f91>] sys_read [kernel] 0x95
Aug 26 23:44:42 PSPweb kernel: [<c0135da6>] sys_lseek [kernel] 0x6e
Aug 26 23:44:43 PSPweb kernel: [<c01085f7>] system_call [kernel] 0x33
Aug 26 23:44:43 PSPweb kernel:
Aug 26 23:44:43 PSPweb kernel:
Aug 26 23:44:43 PSPweb kernel: Code: ff 49 10 ff 0d e4 42 33 c0 8b 46 
18 83 e0 40 74 10 6a 58 68
Aug 26 23:44:43 PSPweb kernel:  VM: reclaim_page, wrong page on list.
Aug 26 23:44:43 PSPweb kernel: VM: reclaim_page, wrong page on list.
Aug 26 23:44:44 PSPweb last message repeated 128 times
Aug 26 23:44:44 PSPweb kernel: VM: page_launder, wrong page on list.
Aug 26 23:44:44 PSPweb last message repeated 240 times
Aug 26 23:44:44 PSPweb kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Aug 26 23:44:44 PSPweb kernel:  printing eip:
Aug 26 23:44:44 PSPweb kernel: c012e75b
Aug 26 23:44:44 PSPweb kernel: *pde = 00000000
Aug 26 23:44:44 PSPweb kernel: Oops: 0002
Aug 26 23:44:44 PSPweb kernel: appletalk 3c59x iptable_filter 
ip_tables st usb-uhci usbcore aic7xxx sd_mod sc
Aug 26 23:44:44 PSPweb kernel: CPU:    0
Aug 26 23:44:44 PSPweb kernel: EIP:    0010:[<c012e75b>]    Not tainted
Aug 26 23:44:44 PSPweb kernel: EFLAGS: 00010246
Aug 26 23:44:44 PSPweb kernel:
Aug 26 23:44:44 PSPweb kernel: EIP is at refill_inactive_zone 
[kernel] 0x233 (2.4.18-3)
Aug 26 23:44:44 PSPweb kernel: eax: c108f520   ebx: c1178de4   ecx: 
00000000   edx: 00000000
Aug 26 23:44:44 PSPweb kernel: esi: c1178e00   edi: c02cac5c   ebp: 
00000108   esp: c11c1f54
Aug 26 23:44:44 PSPweb kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 23:44:44 PSPweb kernel: Process kswapd (pid: 5, stackpage=c11c1000)
Aug 26 23:44:44 PSPweb kernel: Stack: c11c0000 c02cac84 00000000 
00001ba7 0000430a c02cac5c c02cab80 00001ba7
Aug 26 23:44:44 PSPweb kernel:        c012e986 c02cac5c 00000006 
00000000 0000003f 000001d0 00000080 00000000
Aug 26 23:44:44 PSPweb kernel:        66666667 c012ebb1 c11a5f90 
000001d0 c11a7120 000001d0 c11a70b0 000001d0
Aug 26 23:44:44 PSPweb kernel: Call Trace: [<c012e986>] 
refill_inactive [kernel] 0x1ce
Aug 26 23:44:44 PSPweb kernel: [<c012ebb1>] do_try_to_free_pages [kernel] 0x35
Aug 26 23:44:44 PSPweb kernel: [<c012ee64>] kswapd [kernel] 0xf8
Aug 26 23:44:44 PSPweb kernel: [<c0105000>] stext [kernel] 0x0
Aug 26 23:44:44 PSPweb kernel: [<c0106e7a>] kernel_thread [kernel] 0x26
Aug 26 23:44:44 PSPweb kernel: [<c012ed6c>] kswapd [kernel] 0x0
Aug 26 23:44:44 PSPweb kernel:
Aug 26 23:44:44 PSPweb kernel:
Aug 26 23:44:44 PSPweb kernel: Code: 89 42 04 89 10 8b 47 28 89 70 04 
89 06 8b 44 24 04 89 46 04
Aug 26 23:44:44 PSPweb kernel:  VM: reclaim_page, wrong page on list.
Aug 26 23:44:44 PSPweb kernel: VM: reclaim_page, wrong page on list.
Aug 26 23:44:44 PSPweb kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000010
Aug 26 23:44:44 PSPweb kernel:  printing eip:

