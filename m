Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUBXVDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUBXVDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:03:14 -0500
Received: from attila.bofh.it ([213.92.8.2]:39892 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S262459AbUBXVBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:01:52 -0500
Date: Tue, 24 Feb 2004 22:01:44 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: page allocation failure. order:3, mode:0x20
Message-ID: <20040224210144.GA9129@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux attila 2.6.3 #1 Fri Feb 20 02:12:34 CET 2004 ppc GNU/Linux

(Linus tree.)

kernel: tinyproxy: page allocation failure. order:3, mode:0x20
kernel: Call trace:
kernel:  [c00097e8] dump_stack+0x18/0x28
kernel:  [c0037fd8] __alloc_pages+0x31c/0x364
kernel:  [c003804c] __get_free_pages+0x2c/0x74
kernel:  [c003b14c] cache_grow+0x94/0x328
kernel:  [c003b5a0] cache_alloc_refill+0x1c0/0x25c
kernel:  [c003b9ac] __kmalloc+0xa8/0xb4
kernel:  [c0167dc8] alloc_skb+0x4c/0xe0
kernel:  [c0127004] loopback_xmit+0x100/0x110
kernel:  [c016d0c0] dev_queue_xmit+0xcc/0x248
kernel:  [c0184464] ip_finish_output+0x124/0x26c
kernel:  [c018698c] dst_output+0x28/0x5c
kernel:  [c01784c8] nf_hook_slow+0xf0/0x14c
kernel:  [c0184c50] ip_queue_xmit+0x408/0x520
kernel:  [c01960b4] tcp_transmit_skb+0x3e4/0x5e4
kernel: tinyproxy: page allocation failure. order:4, mode:0x20
kernel: Call trace:
kernel:  [c00097e8] dump_stack+0x18/0x28
kernel:  [c0037fd8] __alloc_pages+0x31c/0x364
kernel:  [c003804c] __get_free_pages+0x2c/0x74
kernel:  [c003b14c] cache_grow+0x94/0x328
kernel:  [c003b5a0] cache_alloc_refill+0x1c0/0x25c
kernel:  [c003b9ac] __kmalloc+0xa8/0xb4
kernel:  [c0167dc8] alloc_skb+0x4c/0xe0
kernel:  [c01968d8] tcp_fragment+0x68/0x37c
kernel:  [c0197b88] tcp_retransmit_skb+0x370/0x3a0
kernel:  [c0190cd0] tcp_fastretrans_alert+0x2d8/0x6c8
kernel:  [c0191cbc] tcp_ack+0x15c/0x380
kernel:  [c0194700] tcp_rcv_established+0x280/0x724
kernel:  [c019e24c] tcp_v4_do_rcv+0x13c/0x140
kernel:  [c016772c] __release_sock+0x40/0x68
kernel: FormMail.pl: page allocation failure. order:4, mode:0x20
kernel: Call trace:
kernel:  [c00097e8] dump_stack+0x18/0x28
kernel:  [c0037fd8] __alloc_pages+0x31c/0x364
kernel:  [c003804c] __get_free_pages+0x2c/0x74
kernel:  [c003b14c] cache_grow+0x94/0x328
kernel:  [c003b5a0] cache_alloc_refill+0x1c0/0x25c
kernel:  [c003b9ac] __kmalloc+0xa8/0xb4
kernel:  [c0167dc8] alloc_skb+0x4c/0xe0
kernel:  [c01968d8] tcp_fragment+0x68/0x37c
kernel:  [c0197b88] tcp_retransmit_skb+0x370/0x3a0
kernel:  [c019a444] tcp_retransmit_timer+0x134/0x49c
kernel:  [c019a878] tcp_write_timer+0xcc/0x128
kernel:  [c0023864] run_timer_softirq+0xf8/0x1ac
kernel:  [c001eed0] do_softirq+0xfc/0x100
kernel:  [c0008098] timer_interrupt+0x260/0x290
kernel:  [c0006300] ret_from_except+0x0/0x14
kernel: Call trace:
kernel:  [c00097e8] dump_stack+0x18/0x28
kernel:  [c0037fd8] __alloc_pages+0x31c/0x364
kernel:  [c003804c] __get_free_pages+0x2c/0x74
kernel:  [c003b14c] cache_grow+0x94/0x328
kernel:  [c003b5a0] cache_alloc_refill+0x1c0/0x25c
kernel:  [c003b9ac] __kmalloc+0xa8/0xb4
kernel:  [c0167dc8] alloc_skb+0x4c/0xe0
kernel:  [c01968d8] tcp_fragment+0x68/0x37c
kernel:  [c0197b88] tcp_retransmit_skb+0x370/0x3a0
kernel:  [c0190cd0] tcp_fastretrans_alert+0x2d8/0x6c8
kernel:  [c0191cbc] tcp_ack+0x15c/0x380
kernel:  [c0194700] tcp_rcv_established+0x280/0x724
kernel:  [c019e24c] tcp_v4_do_rcv+0x13c/0x140
kernel:  [c019e920] tcp_v4_rcv+0x6d0/0x91c

-- 
ciao, |
Marco | [4740 peTA4vRHSP4tQ]
