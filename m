Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTEFN1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTEFN1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:27:22 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:27022 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S263688AbTEFN1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:27:17 -0400
Date: Tue, 6 May 2003 15:39:38 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Linux 2.5.69
Message-ID: <20030506133938.GA11062@k3.hellgate.ch>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.68 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing "kernel BUG at include/linux/module.h:284!" with 2.5.69.

I first suspected the early summer in Europe made my hardware flaky, but I
can't reproduce with 2.5.68.

Roger

May  6 14:22:52 k3 kernel: ------------[ cut here ]------------
May  6 14:22:52 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:22:52 k3 kernel: invalid operand: 0000 [#1]
May  6 14:22:52 k3 kernel: CPU:    0
May  6 14:22:52 k3 kernel: EIP:    0060:[sys_accept+113/336]    Not tainted
May  6 14:22:52 k3 kernel: EFLAGS: 00010246
May  6 14:22:52 k3 kernel: EIP is at sys_accept+0x71/0x150
May  6 14:22:52 k3 kernel: eax: 00000000   ebx: f88bee40   ecx: 00000001   edx: f88bee80
May  6 14:22:52 k3 kernel: esi: f5d9e044   edi: f66a1434   ebp: f6459f7c   esp: f6459ee8
May  6 14:22:52 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:22:52 k3 kernel: Process medusa-idled (pid: 1205, threadinfo=f6458000 task=f6457980)
May  6 14:22:52 k3 kernel: Stack: bffff704 f6459fa4 00000004 f6459f94 00000000 f6459f60 f6459f60 bffff5a8 
May  6 14:22:52 k3 kernel:        f6458000 f6459fb4 f7fff080 f7210808 f6458000 c03ad300 f645801c 00000000 
May  6 14:22:52 k3 kernel:        00000002 00000000 fffeff9a 00000000 00000000 f6457980 c011bfd0 00000000 
May  6 14:22:52 k3 kernel: Call Trace:
May  6 14:22:52 k3 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  6 14:22:52 k3 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  6 14:22:52 k3 kernel:  [sys_socketcall+187/448] sys_socketcall+0xbb/0x1c0
May  6 14:22:52 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:22:52 k3 kernel: 
May  6 14:22:52 k3 kernel: Code: 0f 0b 1c 01 4d 36 2e c0 8d b4 26 00 00 00 00 ff 83 c0 00 00 
May  6 14:22:52 k3 kernel:  ------------[ cut here ]------------
May  6 14:22:52 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:22:52 k3 kernel: invalid operand: 0000 [#2]
May  6 14:22:52 k3 kernel: CPU:    0
May  6 14:22:52 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:22:52 k3 kernel: EFLAGS: 00010246
May  6 14:22:52 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:22:52 k3 kernel: eax: 00000000   ebx: f5cf8700   ecx: 00000001   edx: f88bee80
May  6 14:22:52 k3 kernel: esi: 00000000   edi: f5cf84c0   ebp: f6065ea4   esp: f6065e94
May  6 14:22:52 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:22:52 k3 kernel: Process gkrellm (pid: 1240, threadinfo=f6064000 task=f6456000)
May  6 14:22:52 k3 kernel: Stack: 00000000 f6065efc f5cf84c0 f88ba340 f6065ed4 f88ba398 00000000 f66a1a1c 
May  6 14:22:52 k3 kernel:        f6065efc 0000006e 00000011 7fffffff 00000000 00000000 fffffff4 f66a1a1c 
May  6 14:22:52 k3 kernel:        f6065f7c c0230d1f f66a1a1c f6065efc 0000006e 00000002 bffff0c4 f6065fa4 
May  6 14:22:52 k3 kernel: Call Trace:
May  6 14:22:52 k3 kernel:  [_end+944667008/1069725248] unix_stream_connect+0x30/0x470 [unix]
May  6 14:22:52 k3 kernel:  [_end+944667096/1069725248] unix_stream_connect+0x88/0x470 [unix]
May  6 14:22:52 k3 kernel:  [sys_connect+95/144] sys_connect+0x5f/0x90
May  6 14:22:52 k3 kernel:  [sys_socket+46/80] sys_socket+0x2e/0x50
May  6 14:22:52 k3 kernel:  [sys_socketcall+157/448] sys_socketcall+0x9d/0x1c0
May  6 14:22:52 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:22:52 k3 kernel: 
May  6 14:22:52 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:23:09 k3 kernel:  ------------[ cut here ]------------
May  6 14:23:09 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:23:09 k3 kernel: invalid operand: 0000 [#3]
May  6 14:23:09 k3 kernel: CPU:    0
May  6 14:23:09 k3 kernel: EIP:    0060:[sys_accept+113/336]    Not tainted
May  6 14:23:09 k3 kernel: EFLAGS: 00010246
May  6 14:23:09 k3 kernel: EIP is at sys_accept+0x71/0x150
May  6 14:23:09 k3 kernel: eax: 00000000   ebx: f88bee40   ecx: 00000001   edx: f88bee80
May  6 14:23:09 k3 kernel: esi: f6f8323c   edi: f6f83044   ebp: f6f1bf7c   esp: f6f1bee8
May  6 14:23:09 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:23:09 k3 kernel: Process trivial-rewrite (pid: 900, threadinfo=f6f1a000 task=f7444000)
May  6 14:23:09 k3 kernel: Stack: bffffb94 f6f1bfa4 00000004 f590a008 00000000 f6f1bf04 c014307a f6f1bf0c 
May  6 14:23:09 k3 kernel:        c01435e5 f6f1bf14 f7fff080 f72107dc f7210000 00000020 f6f1bf5c c0147d3d 
May  6 14:23:09 k3 kernel:        f7fff080 f72107dc 00000282 00000001 00000004 f72107e0 0000002c 00000028 
May  6 14:23:09 k3 kernel: Call Trace:
May  6 14:23:09 k3 kernel:  [free_hot_page+10/16] free_hot_page+0xa/0x10
May  6 14:23:09 k3 kernel:  [__free_pages+53/80] __free_pages+0x35/0x50
May  6 14:23:09 k3 kernel:  [kfree+525/608] kfree+0x20d/0x260
May  6 14:23:09 k3 kernel:  [select_bits_free+12/16] select_bits_free+0xc/0x10
May  6 14:23:09 k3 kernel:  [select_bits_free+12/16] select_bits_free+0xc/0x10
May  6 14:23:09 k3 kernel:  [sys_select+1086/1104] sys_select+0x43e/0x450
May  6 14:23:09 k3 kernel:  [sys_socketcall+187/448] sys_socketcall+0xbb/0x1c0
May  6 14:23:09 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:23:09 k3 kernel: 
May  6 14:23:09 k3 kernel: Code: 0f 0b 1c 01 4d 36 2e c0 8d b4 26 00 00 00 00 ff 83 c0 00 00 
May  6 14:23:09 k3 kernel:  ------------[ cut here ]------------
May  6 14:23:09 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:23:09 k3 kernel: invalid operand: 0000 [#4]
May  6 14:23:09 k3 kernel: CPU:    0
May  6 14:23:09 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:23:09 k3 kernel: EFLAGS: 00210246
May  6 14:23:09 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:23:09 k3 kernel: eax: 00000000   ebx: f6f814c0   ecx: 00000001   edx: f88bee80
May  6 14:23:09 k3 kernel: esi: 00000000   edi: f6f51280   ebp: f5c85ea4   esp: f5c85e94
May  6 14:23:09 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:23:09 k3 kernel: Process gkrellm (pid: 1713, threadinfo=f5c84000 task=f6456cc0)
May  6 14:23:09 k3 kernel: Stack: 00000000 f5c85efc f6f51280 f88ba340 f5c85ed4 f88ba398 00000000 f6f3be0c 
May  6 14:23:09 k3 kernel:        f5c85efc 0000006e 0000001a 7fffffff 00000000 00000000 fffffff4 f6f3be0c 
May  6 14:23:09 k3 kernel:        f5c85f7c c0230d1f f6f3be0c f5c85efc 0000006e 00000002 bfffed04 f5c85fa4 
May  6 14:23:09 k3 kernel: Call Trace:
May  6 14:23:09 k3 kernel:  [_end+944667008/1069725248] unix_stream_connect+0x30/0x470 [unix]
May  6 14:23:09 k3 kernel:  [_end+944667096/1069725248] unix_stream_connect+0x88/0x470 [unix]
May  6 14:23:09 k3 kernel:  [sys_connect+95/144] sys_connect+0x5f/0x90
May  6 14:23:09 k3 kernel:  [sys_socket+46/80] sys_socket+0x2e/0x50
May  6 14:23:09 k3 kernel:  [sys_socketcall+157/448] sys_socketcall+0x9d/0x1c0
May  6 14:23:09 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:23:09 k3 kernel: 
May  6 14:23:09 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:23:30 k3 gconfd (rl-1740): starting (version 1.0.9), pid 1740 user 'rl'
May  6 14:23:30 k3 kernel:  ------------[ cut here ]------------
May  6 14:23:30 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:23:30 k3 kernel: invalid operand: 0000 [#5]
May  6 14:23:30 k3 kernel: CPU:    0
May  6 14:23:30 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:23:30 k3 kernel: EFLAGS: 00210246
May  6 14:23:30 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:23:30 k3 kernel: eax: 00000000   ebx: f5cf8940   ecx: 00000001   edx: f88bee80
May  6 14:23:30 k3 kernel: esi: f6f3b62c   edi: c03cc7e0   ebp: f0c33f10   esp: f0c33f00
May  6 14:23:30 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:23:30 k3 kernel: Process gconfd-1 (pid: 1740, threadinfo=f0c32000 task=f73b6660)
May  6 14:23:30 k3 kernel: Stack: f6f3b62c 00000004 c03cc7e0 00000001 f0c33f1c f88b9b1d f6f3b62c f0c33f5c 
May  6 14:23:30 k3 kernel:        c0230847 f6f3b62c 00000000 00000001 f0c33fa4 00000000 ffffff9f 00000048 
May  6 14:23:30 k3 kernel:        c0152741 f7d837b0 f1358824 00200292 f0c33f64 c0152741 f7ffd8f0 f0c33f7c 
May  6 14:23:30 k3 kernel: Call Trace:
May  6 14:23:30 k3 kernel:  [_end+944664925/1069725248] unix_create+0x5d/0x80 [unix]
May  6 14:23:30 k3 kernel:  [sock_create+279/448] sock_create+0x117/0x1c0
May  6 14:23:30 k3 kernel:  [unmap_vma+113/128] unmap_vma+0x71/0x80
May  6 14:23:30 k3 kernel:  [unmap_vma+113/128] unmap_vma+0x71/0x80
May  6 14:23:30 k3 kernel:  [sys_socket+28/80] sys_socket+0x1c/0x50
May  6 14:23:30 k3 kernel:  [sys_socketcall+125/448] sys_socketcall+0x7d/0x1c0
May  6 14:23:30 k3 kernel:  [smp_apic_timer_interrupt+43/224] smp_apic_timer_interrupt+0x2b/0xe0
May  6 14:23:30 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:23:30 k3 kernel: 
May  6 14:23:30 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:23:36 k3 kernel:  ------------[ cut here ]------------
May  6 14:23:36 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:23:36 k3 kernel: invalid operand: 0000 [#6]
May  6 14:23:36 k3 kernel: CPU:    0
May  6 14:23:36 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:23:36 k3 kernel: EFLAGS: 00210246
May  6 14:23:36 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:23:36 k3 kernel: eax: 00000000   ebx: f5cf8040   ecx: 00000001   edx: f88bee80
May  6 14:23:36 k3 kernel: esi: 00000000   edi: f5cf8b80   ebp: f0acdea4   esp: f0acde94
May  6 14:23:36 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:23:36 k3 kernel: Process gkrellm (pid: 1722, threadinfo=f0acc000 task=f5d74660)
May  6 14:23:36 k3 kernel: Stack: 00000000 f0acdefc f5cf8b80 f88ba340 f0acded4 f88ba398 00000000 f6f3b824 
May  6 14:23:36 k3 kernel:        f0acdefc 0000006e 0000001a 7fffffff 00000000 00000000 fffffff4 f6f3b824 
May  6 14:23:36 k3 kernel:        f0acdf7c c0230d1f f6f3b824 f0acdefc 0000006e 00000002 bfffed04 f0acdfa4 
May  6 14:23:36 k3 kernel: Call Trace:
May  6 14:23:36 k3 kernel:  [_end+944667008/1069725248] unix_stream_connect+0x30/0x470 [unix]
May  6 14:23:36 k3 kernel:  [_end+944667096/1069725248] unix_stream_connect+0x88/0x470 [unix]
May  6 14:23:36 k3 kernel:  [sys_connect+95/144] sys_connect+0x5f/0x90
May  6 14:23:36 k3 kernel:  [sys_socketcall+157/448] sys_socketcall+0x9d/0x1c0
May  6 14:23:36 k3 kernel:  [do_syscall_trace+52/96] do_syscall_trace+0x34/0x60
May  6 14:23:36 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:23:36 k3 kernel: 
May  6 14:23:36 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:23:37 k3 kernel:  ------------[ cut here ]------------
May  6 14:23:37 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:23:37 k3 kernel: invalid operand: 0000 [#7]
May  6 14:23:37 k3 kernel: CPU:    0
May  6 14:23:37 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:23:37 k3 kernel: EFLAGS: 00210246
May  6 14:23:37 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:23:37 k3 kernel: eax: 00000000   ebx: f5cf8280   ecx: 00000001   edx: f88bee80
May  6 14:23:37 k3 kernel: esi: 00000000   edi: f6008040   ebp: f0c33ea4   esp: f0c33e94
May  6 14:23:37 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:23:37 k3 kernel: Process galeon-bin (pid: 1742, threadinfo=f0c32000 task=f0c82000)
May  6 14:23:37 k3 kernel: Stack: 00000000 f0c33efc f6008040 f88ba340 f0c33ed4 f88ba398 00000000 f66a162c 
May  6 14:23:37 k3 kernel:        f0c33efc 0000006e 00000018 7fffffff 00000000 00000000 fffffff4 f66a162c 
May  6 14:23:37 k3 kernel:        f0c33f7c c0230d1f f66a162c f0c33efc 0000006e 00000002 bffff074 f0c33fa4 
May  6 14:23:37 k3 kernel: Call Trace:
May  6 14:23:37 k3 kernel:  [_end+944667008/1069725248] unix_stream_connect+0x30/0x470 [unix]
May  6 14:23:37 k3 kernel:  [_end+944667096/1069725248] unix_stream_connect+0x88/0x470 [unix]
May  6 14:23:37 k3 kernel:  [sys_connect+95/144] sys_connect+0x5f/0x90
May  6 14:23:37 k3 kernel:  [sys_socket+46/80] sys_socket+0x2e/0x50
May  6 14:23:37 k3 kernel:  [sys_socketcall+157/448] sys_socketcall+0x9d/0x1c0
May  6 14:23:37 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:23:37 k3 kernel: 
May  6 14:23:37 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:24:09 k3 kernel:  ------------[ cut here ]------------
May  6 14:24:09 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:24:09 k3 kernel: invalid operand: 0000 [#8]
May  6 14:24:09 k3 kernel: CPU:    0
May  6 14:24:09 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:24:09 k3 kernel: EFLAGS: 00010246
May  6 14:24:09 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:24:09 k3 kernel: eax: 00000000   ebx: f6008700   ecx: 00000001   edx: f88bee80
May  6 14:24:09 k3 kernel: esi: f637823c   edi: c03cc7e0   ebp: f0ce5f10   esp: f0ce5f00
May  6 14:24:09 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:24:09 k3 kernel: Process zsh (pid: 1846, threadinfo=f0ce4000 task=f0c83980)
May  6 14:24:09 k3 kernel: Stack: f637823c 00000004 c03cc7e0 00000001 f0ce5f1c f88b9b1d f637823c f0ce5f5c 
May  6 14:24:09 k3 kernel:        c0230847 f637823c 00000000 00000001 f0ce5fa4 00000000 ffffff9f 00030002 
May  6 14:24:09 k3 kernel:        00001000 f78b4e08 00000000 00000000 f0ce5f98 c0152d01 f650bdc0 f0ce5f7c 
May  6 14:24:09 k3 kernel: Call Trace:
May  6 14:24:09 k3 kernel:  [_end+944664925/1069725248] unix_create+0x5d/0x80 [unix]
May  6 14:24:09 k3 kernel:  [sock_create+279/448] sock_create+0x117/0x1c0
May  6 14:24:09 k3 kernel:  [do_brk+257/480] do_brk+0x101/0x1e0
May  6 14:24:09 k3 kernel:  [sys_socket+28/80] sys_socket+0x1c/0x50
May  6 14:24:09 k3 kernel:  [sys_socketcall+125/448] sys_socketcall+0x7d/0x1c0
May  6 14:24:09 k3 kernel:  [error_code+45/56] error_code+0x2d/0x38
May  6 14:24:09 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:24:09 k3 kernel: 
May  6 14:24:09 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:24:10 k3 kernel:  ------------[ cut here ]------------
May  6 14:24:10 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:24:10 k3 kernel: invalid operand: 0000 [#9]
May  6 14:24:10 k3 kernel: CPU:    0
May  6 14:24:10 k3 kernel: EIP:    0060:[_end+944664612/1069725248]    Not tainted
May  6 14:24:10 k3 kernel: EFLAGS: 00010246
May  6 14:24:10 k3 kernel: EIP is at unix_create1+0x84/0x160 [unix]
May  6 14:24:10 k3 kernel: eax: 00000000   ebx: f6f3ab80   ecx: 00000001   edx: f88bee80
May  6 14:24:10 k3 kernel: esi: f5c18044   edi: c03cc7e0   ebp: f0d17f10   esp: f0d17f00
May  6 14:24:10 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:24:10 k3 kernel: Process local (pid: 1848, threadinfo=f0d16000 task=f5fed980)
May  6 14:24:10 k3 kernel: Stack: f5c18044 00000004 c03cc7e0 00000001 f0d17f1c f88b9b1d f5c18044 f0d17f5c 
May  6 14:24:10 k3 kernel:        c0230847 f5c18044 00000000 00000001 f0d17fa4 00000000 ffffff9f 00030002 
May  6 14:24:10 k3 kernel:        00001000 f2341778 00000000 00000000 f0d17f98 c0152d01 f73f34c0 f0d17f7c 
May  6 14:24:10 k3 kernel: Call Trace:
May  6 14:24:10 k3 kernel:  [_end+944664925/1069725248] unix_create+0x5d/0x80 [unix]
May  6 14:24:10 k3 kernel:  [sock_create+279/448] sock_create+0x117/0x1c0
May  6 14:24:10 k3 kernel:  [do_brk+257/480] do_brk+0x101/0x1e0
May  6 14:24:10 k3 kernel:  [sys_socket+28/80] sys_socket+0x1c/0x50
May  6 14:24:10 k3 kernel:  [sys_socketcall+125/448] sys_socketcall+0x7d/0x1c0
May  6 14:24:10 k3 kernel:  [error_code+45/56] error_code+0x2d/0x38
May  6 14:24:10 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:24:10 k3 kernel: 
May  6 14:24:10 k3 kernel: Code: 0f 0b 1c 01 f2 cd 8b f8 8d 74 26 00 ff 05 00 ef 8b f8 0f b7 
May  6 14:24:10 k3 kernel:  ------------[ cut here ]------------
May  6 14:24:10 k3 kernel: kernel BUG at include/linux/module.h:284!
May  6 14:24:10 k3 kernel: invalid operand: 0000 [#10]
May  6 14:24:10 k3 kernel: CPU:    0
May  6 14:24:10 k3 kernel: EIP:    0060:[sys_accept+113/336]    Not tainted
May  6 14:24:10 k3 kernel: EFLAGS: 00010246
May  6 14:24:10 k3 kernel: EIP is at sys_accept+0x71/0x150
May  6 14:24:10 k3 kernel: eax: 00000000   ebx: f88bee40   ecx: 00000001   edx: f88bee80
May  6 14:24:10 k3 kernel: esi: f5c18434   edi: f66a123c   ebp: f646df7c   esp: f646dee8
May  6 14:24:10 k3 kernel: ds: 007b   es: 007b   ss: 0068
May  6 14:24:10 k3 kernel: Process medusa-idled (pid: 1183, threadinfo=f646c000 task=f6688cc0)
May  6 14:24:10 k3 kernel: Stack: bffff7c4 f646dfa4 00000004 f646df94 00000000 f646df60 f646df60 bffff668 
May  6 14:24:10 k3 kernel:        f646c000 f646dfb4 f7fff080 f7210808 f646c000 c03ad300 f646c01c 00000000 
May  6 14:24:10 k3 kernel:        00000002 00000000 00003198 00000001 00000000 f6688cc0 c011bfd0 00000000 
May  6 14:24:10 k3 kernel: Call Trace:
May  6 14:24:10 k3 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  6 14:24:10 k3 kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  6 14:24:10 k3 kernel:  [sys_socketcall+187/448] sys_socketcall+0xbb/0x1c0
May  6 14:24:10 k3 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  6 14:24:10 k3 kernel: 
May  6 14:24:10 k3 kernel: Code: 0f 0b 1c 01 4d 36 2e c0 8d b4 26 00 00 00 00 ff 83 c0 00 00 
