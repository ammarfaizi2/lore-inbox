Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUHXUCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUHXUCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUHXUCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:02:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:33940 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268254AbUHXUBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:01:02 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: page allocation failure
Date: Tue, 24 Aug 2004 22:05:19 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408242205.20571.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

is this a kernel bug, or smbd failure? I think it could be caused by kernel 
and less memory. Cause the machine is running with 56MB ram. But IMHO I think 
the kernel shouldn't handle it this way. Running 2.6.8-rc4-mm1.

best regards,
dominik

syslog:
Aug 24 15:27:24 debian kernel: cupsd: page allocation failure. order:3, 
mode:0x20
Aug 24 15:27:24 debian kernel: Stack pointer is garbage, not printing trace
Aug 24 15:27:24 debian kernel: smbd: page allocation failure. order:3, 
mode:0x20
Aug 24 15:27:24 debian kernel:  [__alloc_pages+477/784] 
__alloc_pages+0x1dd/0x310
Aug 24 15:27:24 debian kernel:  [__get_free_pages+24/64] 
__get_free_pages+0x18/0x40
Aug 24 15:27:24 debian kernel:  [kmem_getpages+25/176] kmem_getpages+0x19/0xb0
Aug 24 15:27:24 debian kernel:  [cache_grow+182/400] cache_grow+0xb6/0x190
Aug 24 15:27:24 debian kernel:  [cache_alloc_refill+531/592] 
cache_alloc_refill+0x213/0x250
Aug 24 15:27:24 debian kernel:  [__kmalloc+92/96] __kmalloc+0x5c/0x60
Aug 24 15:27:24 debian kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Aug 24 15:27:24 debian kernel:  [skb_copy+40/192] skb_copy+0x28/0xc0
Aug 24 15:27:24 debian kernel:  [skb_checksum_help+86/368] 
skb_checksum_help+0x56/0x170
Aug 24 15:27:24 debian kernel:  [pg0+71789271/1069305856] 
ip_nat_fn+0x177/0x2a0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [pg0+71789854/1069305856] 
ip_nat_local_fn+0x6e/0xb0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_iterate+85/160] nf_iterate+0x55/0xa0
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_hook_slow+120/288] nf_hook_slow+0x78/0x120
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [ip_queue_xmit+781/1328] 
ip_queue_xmit+0x30d/0x530
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [recalc_task_prio+187/432] 
recalc_task_prio+0xbb/0x1b0
Aug 24 15:27:24 debian kernel:  [do_IRQ+343/416] do_IRQ+0x157/0x1a0
Aug 24 15:27:24 debian kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Aug 24 15:27:24 debian kernel:  [tcp_v4_send_check+3/272] 
tcp_v4_send_check+0x3/0x110
Aug 24 15:27:24 debian kernel:  [tcp_transmit_skb+984/1760] 
tcp_transmit_skb+0x3d8/0x6e0
Aug 24 15:27:24 debian kernel:  [buffered_rmqueue+259/528] 
buffered_rmqueue+0x103/0x210
Aug 24 15:27:24 debian kernel:  [sk_stream_wait_memory+373/496] 
sk_stream_wait_memory+0x175/0x1f0
Aug 24 15:27:24 debian kernel:  [tcp_write_xmit+326/704] 
tcp_write_xmit+0x146/0x2c0
Aug 24 15:27:24 debian kernel:  [tcp_sendmsg+4088/4176] 
tcp_sendmsg+0xff8/0x1050
Aug 24 15:27:24 debian kernel:  [recalc_task_prio+187/432] 
recalc_task_prio+0xbb/0x1b0
Aug 24 15:27:24 debian kernel:  [inet_sendmsg+74/112] inet_sendmsg+0x4a/0x70
Aug 24 15:27:24 debian kernel:  [sock_sendmsg+190/240] sock_sendmsg+0xbe/0xf0
Aug 24 15:27:24 debian kernel:  [update_atime+71/176] update_atime+0x47/0xb0
Aug 24 15:27:24 debian kernel:  [do_generic_mapping_read+688/1088] 
do_generic_mapping_read+0x2b0/0x440
Aug 24 15:27:24 debian kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
Aug 24 15:27:24 debian kernel:  [file_read_actor+0/240] 
file_read_actor+0x0/0xf0
Aug 24 15:27:24 debian kernel:  [sockfd_lookup+22/144] sockfd_lookup+0x16/0x90
Aug 24 15:27:24 debian kernel:  [sys_sendto+216/272] sys_sendto+0xd8/0x110
Aug 24 15:27:24 debian kernel:  [do_select+684/720] do_select+0x2ac/0x2d0
Aug 24 15:27:24 debian kernel:  [__pollwait+0/192] __pollwait+0x0/0xc0
Aug 24 15:27:24 debian kernel:  [sys_send+51/64] sys_send+0x33/0x40
Aug 24 15:27:24 debian kernel:  [sys_socketcall+322/592] 
sys_socketcall+0x142/0x250
Aug 24 15:27:24 debian kernel:  [do_gettimeofday+26/192] 
do_gettimeofday+0x1a/0xc0
Aug 24 15:27:24 debian kernel:  [sys_time+22/80] sys_time+0x16/0x50
Aug 24 15:27:24 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 24 15:27:24 debian kernel: smbd: page allocation failure. order:3, 
mode:0x20
Aug 24 15:27:24 debian kernel:  [__alloc_pages+477/784] 
__alloc_pages+0x1dd/0x310
Aug 24 15:27:24 debian kernel:  [__get_free_pages+24/64] 
__get_free_pages+0x18/0x40
Aug 24 15:27:24 debian kernel:  [kmem_getpages+25/176] kmem_getpages+0x19/0xb0
Aug 24 15:27:24 debian kernel:  [cache_grow+182/400] cache_grow+0xb6/0x190
Aug 24 15:27:24 debian kernel:  [cache_alloc_refill+531/592] 
cache_alloc_refill+0x213/0x250
Aug 24 15:27:24 debian kernel:  [__kmalloc+92/96] __kmalloc+0x5c/0x60
Aug 24 15:27:24 debian kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Aug 24 15:27:24 debian kernel:  [skb_copy+40/192] skb_copy+0x28/0xc0
Aug 24 15:27:24 debian kernel:  [skb_checksum_help+86/368] 
skb_checksum_help+0x56/0x170
Aug 24 15:27:24 debian kernel:  [pg0+71789271/1069305856] 
ip_nat_fn+0x177/0x2a0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [pg0+71789854/1069305856] 
ip_nat_local_fn+0x6e/0xb0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_iterate+85/160] nf_iterate+0x55/0xa0
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_hook_slow+120/288] nf_hook_slow+0x78/0x120
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [ip_queue_xmit+781/1328] 
ip_queue_xmit+0x30d/0x530
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [preempt_schedule+37/64] 
preempt_schedule+0x25/0x40
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_hook_slow+266/288] 
nf_hook_slow+0x10a/0x120
Aug 24 15:27:24 debian kernel:  [tcp_transmit_skb+984/1760] 
tcp_transmit_skb+0x3d8/0x6e0
Aug 24 15:27:24 debian kernel:  [tcp_ack_saw_tstamp+24/64] 
tcp_ack_saw_tstamp+0x18/0x40
Aug 24 15:27:24 debian kernel:  [tcp_write_xmit+326/704] 
tcp_write_xmit+0x146/0x2c0
Aug 24 15:27:24 debian kernel:  [__tcp_data_snd_check+78/240] 
__tcp_data_snd_check+0x4e/0xf0
Aug 24 15:27:24 debian kernel:  [__kfree_skb+168/320] __kfree_skb+0xa8/0x140
Aug 24 15:27:24 debian kernel:  [tcp_rcv_established+1029/1968] 
tcp_rcv_established+0x405/0x7b0
Aug 24 15:27:24 debian kernel:  [tcp_v4_do_rcv+240/256] 
tcp_v4_do_rcv+0xf0/0x100
Aug 24 15:27:24 debian kernel:  [__release_sock+82/128] 
__release_sock+0x52/0x80
Aug 24 15:27:24 debian kernel:  [release_sock+72/128] release_sock+0x48/0x80
Aug 24 15:27:24 debian kernel:  [tcp_sendmsg+1927/4176] 
tcp_sendmsg+0x787/0x1050
Aug 24 15:27:24 debian kernel:  [recalc_task_prio+187/432] 
recalc_task_prio+0xbb/0x1b0
Aug 24 15:27:24 debian kernel:  [inet_sendmsg+74/112] inet_sendmsg+0x4a/0x70
Aug 24 15:27:24 debian kernel:  [sock_sendmsg+190/240] sock_sendmsg+0xbe/0xf0
Aug 24 15:27:24 debian kernel:  [update_atime+71/176] update_atime+0x47/0xb0
Aug 24 15:27:24 debian kernel:  [do_generic_mapping_read+688/1088] 
do_generic_mapping_read+0x2b0/0x440
Aug 24 15:27:24 debian kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
Aug 24 15:27:24 debian kernel:  [file_read_actor+0/240] 
file_read_actor+0x0/0xf0
Aug 24 15:27:24 debian kernel:  [sockfd_lookup+22/144] sockfd_lookup+0x16/0x90
Aug 24 15:27:24 debian kernel:  [sys_sendto+216/272] sys_sendto+0xd8/0x110
Aug 24 15:27:24 debian kernel:  [do_select+684/720] do_select+0x2ac/0x2d0
Aug 24 15:27:24 debian kernel:  [__pollwait+0/192] __pollwait+0x0/0xc0
Aug 24 15:27:24 debian kernel:  [sys_send+51/64] sys_send+0x33/0x40
Aug 24 15:27:24 debian kernel:  [sys_socketcall+322/592] 
sys_socketcall+0x142/0x250
Aug 24 15:27:24 debian kernel:  [do_gettimeofday+26/192] 
do_gettimeofday+0x1a/0xc0
Aug 24 15:27:24 debian kernel:  [sys_time+22/80] sys_time+0x16/0x50
Aug 24 15:27:24 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 24 15:27:24 debian kernel: smbd: page allocation failure. order:3, 
mode:0x20
Aug 24 15:27:24 debian kernel:  [__alloc_pages+477/784] 
__alloc_pages+0x1dd/0x310
Aug 24 15:27:24 debian kernel:  [__get_free_pages+24/64] 
__get_free_pages+0x18/0x40
Aug 24 15:27:24 debian kernel:  [kmem_getpages+25/176] kmem_getpages+0x19/0xb0
Aug 24 15:27:24 debian kernel:  [cache_grow+182/400] cache_grow+0xb6/0x190
Aug 24 15:27:24 debian kernel:  [cache_alloc_refill+531/592] 
cache_alloc_refill+0x213/0x250
Aug 24 15:27:24 debian kernel:  [__kmalloc+92/96] __kmalloc+0x5c/0x60
Aug 24 15:27:24 debian kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Aug 24 15:27:24 debian kernel:  [skb_copy+40/192] skb_copy+0x28/0xc0
Aug 24 15:27:24 debian kernel:  [skb_checksum_help+86/368] 
skb_checksum_help+0x56/0x170
Aug 24 15:27:24 debian kernel:  [pg0+71789271/1069305856] 
ip_nat_fn+0x177/0x2a0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [pg0+71789854/1069305856] 
ip_nat_local_fn+0x6e/0xb0 [iptable_nat]
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_iterate+85/160] nf_iterate+0x55/0xa0
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [nf_hook_slow+120/288] nf_hook_slow+0x78/0x120
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [ip_queue_xmit+781/1328] 
ip_queue_xmit+0x30d/0x530
Aug 24 15:27:24 debian kernel:  [dst_output+0/32] dst_output+0x0/0x20
Aug 24 15:27:24 debian kernel:  [tcp_transmit_skb+984/1760] 
tcp_transmit_skb+0x3d8/0x6e0
Aug 24 15:27:24 debian kernel:  [tcp_ack_saw_tstamp+24/64] 
tcp_ack_saw_tstamp+0x18/0x40
Aug 24 15:27:24 debian kernel:  [smp_apic_timer_interrupt+42/160] 
smp_apic_timer_interrupt+0x2a/0xa0
Aug 24 15:27:24 debian kernel:  [apic_timer_interrupt+26/32] 
apic_timer_interrupt+0x1a/0x20
Aug 24 15:27:24 debian kernel:  [tcp_v4_send_check+177/272] 
tcp_v4_send_check+0xb1/0x110
Aug 24 15:27:24 debian kernel:  [tcp_cwnd_restart+35/256] 
tcp_cwnd_restart+0x23/0x100
Aug 24 15:27:24 debian kernel:  [tcp_transmit_skb+984/1760] 
tcp_transmit_skb+0x3d8/0x6e0
Aug 24 15:27:24 debian kernel:  [buffered_rmqueue+259/528] 
buffered_rmqueue+0x103/0x210
Aug 24 15:27:24 debian kernel:  [tcp_write_xmit+326/704] 
tcp_write_xmit+0x146/0x2c0
Aug 24 15:27:24 debian kernel:  [tcp_sendmsg+4088/4176] 
tcp_sendmsg+0xff8/0x1050
Aug 24 15:27:24 debian kernel:  [inet_sendmsg+74/112] inet_sendmsg+0x4a/0x70
Aug 24 15:27:24 debian kernel:  [sock_sendmsg+190/240] sock_sendmsg+0xbe/0xf0
Aug 24 15:27:24 debian kernel:  [__copy_to_user_ll+56/112] 
__copy_to_user_ll+0x38/0x70
Aug 24 15:27:24 debian kernel:  [update_atime+155/176] update_atime+0x9b/0xb0
Aug 24 15:27:24 debian kernel:  [do_generic_mapping_read+688/1088] 
do_generic_mapping_read+0x2b0/0x440
Aug 24 15:27:24 debian kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
Aug 24 15:27:24 debian kernel:  [file_read_actor+0/240] 
file_read_actor+0x0/0xf0
Aug 24 15:27:24 debian kernel:  [sockfd_lookup+22/144] sockfd_lookup+0x16/0x90
Aug 24 15:27:24 debian kernel:  [sys_sendto+216/272] sys_sendto+0xd8/0x110
Aug 24 15:27:24 debian kernel:  [do_select+684/720] do_select+0x2ac/0x2d0
Aug 24 15:27:24 debian kernel:  [__pollwait+0/192] __pollwait+0x0/0xc0
Aug 24 15:27:24 debian kernel:  [sys_send+51/64] sys_send+0x33/0x40
Aug 24 15:27:24 debian kernel:  [sys_socketcall+322/592] 
sys_socketcall+0x142/0x250
Aug 24 15:27:24 debian kernel:  [do_gettimeofday+26/192] 
do_gettimeofday+0x1a/0xc0
Aug 24 15:27:24 debian kernel:  [sys_time+22/80] sys_time+0x16/0x50
Aug 24 15:27:24 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 24 15:27:24 debian kernel: smbd: page allocation failure. order:3, 
mode:0x20
Aug 24 15:27:24 debian kernel: Stack pointer is garbage, not printing trace
