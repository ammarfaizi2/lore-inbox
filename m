Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVAWI0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVAWI0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 03:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVAWI0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 03:26:33 -0500
Received: from av8.netikka.fi ([213.250.83.8]:31105 "EHLO mail.linuxvaasa.com")
	by vger.kernel.org with ESMTP id S261258AbVAWI0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 03:26:22 -0500
Message-ID: <41F35FAB.1050304@netikka.fi>
Date: Sun, 23 Jan 2005 10:26:19 +0200
From: Johnny Strom <jonny.strom@netikka.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; sv-SE; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-gb, en, en-us, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ppp in 2.6.11-rc2 Badness in local_bh_enable at kernel/softirq.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I have the same problem with 2.6.11-rc2 I am using ppp with rp-pppoe-3.5 
it starts like this as soon as it brings upp the link.

This is from the booutup of my system:

Jan 21 19:45:14 mail kernel:  [<c03650e8>] ip_send_reply+0x1e8/0x250
Jan 21 19:45:14 mail kernel:  [<c0364e70>] ip_reply_glue_bits+0x0/0x90
Jan 21 19:45:14 mail kernel:  [<c03a1f9b>] ip_nat_used_tuple+0x2b/0x40
Jan 21 19:45:14 mail kernel:  [<c03a254f>] ip_nat_setup_info+0xbf/0x300
Jan 21 19:45:14 mail kernel:  [<c0379591>] tcp_v4_send_reset+0xf1/0x150
Jan 21 19:45:15 mail kernel:  [<c037abef>] tcp_v4_rcv+0x43f/0x7e0
Jan 21 19:45:15 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:15 mail kernel:  [<c036023c>] 
ip_local_deliver_finish+0xbc/0x170
Jan 21 19:45:15 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:15 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:15 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:15 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:15 mail kernel:  [<c035ff59>] ip_local_deliver+0x59/0x60
Jan 21 19:45:15 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:15 mail kernel:  [<c03603d9>] ip_rcv_finish+0xe9/0x250
Jan 21 19:45:16 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:16 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:16 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:16 mail kernel:  [<c03600cd>] ip_rcv+0x16d/0x220
Jan 21 19:45:16 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:16 mail kernel:  [<c034b468>] netif_receive_skb+0x128/0x1b0
Jan 21 19:45:16 mail kernel:  [<c02847df>] ppp_input+0xff/0x1a0
Jan 21 19:45:17 mail kernel:  [<c034b563>] process_backlog+0x73/0x100
Jan 21 19:45:17 mail kernel:  [<c034b65a>] net_rx_action+0x6a/0xf0
Jan 21 19:45:17 mail kernel:  [<c01197b8>] __do_softirq+0x78/0x90
Jan 21 19:45:17 mail kernel:  [<c01197f6>] do_softirq+0x26/0x30
Jan 21 19:45:17 mail kernel:  [<c011985c>] local_bh_enable+0x5c/0x90
Jan 21 19:45:17 mail kernel:  [<c03b35f4>] packet_poll+0x84/0xa0
Jan 21 19:45:17 mail kernel:  [<c03419b9>] sock_poll+0x29/0x40
Jan 21 19:45:18 mail kernel:  [<c01666d2>] do_select+0x272/0x2e0
Jan 21 19:45:18 mail kernel:  [<c01662b0>] __pollwait+0x0/0xd0
Jan 21 19:45:18 mail kernel:  [<c0166a2f>] sys_select+0x2bf/0x4d0
Jan 21 19:45:18 mail kernel:  [<c010277d>] sysenter_past_esp+0x52/0x75
Jan 21 19:45:18 mail kernel: Badness in local_bh_enable at 
kernel/softirq.c:140
Jan 21 19:45:18 mail kernel:  [<c0119887>] local_bh_enable+0x87/0x90
Jan 21 19:45:18 mail kernel:  [<c02884db>] ppp_async_push+0xab/0x180
Jan 21 19:45:18 mail kernel:  [<c02ae931>] ide_intr+0x141/0x1b0
Jan 21 19:45:18 mail kernel:  [<c02883f5>] ppp_async_send+0x15/0x50
Jan 21 19:45:18 mail kernel:  [<c02845d5>] ppp_push+0xf5/0x100
Jan 21 19:45:18 mail kernel:  [<c028421d>] ppp_send_frame+0x25d/0x520
Jan 21 19:45:18 mail kernel:  [<c039a350>] tcp_in_window+0x470/0x480
Jan 21 19:45:18 mail kernel:  [<c0283f5f>] ppp_xmit_process+0x7f/0xe0
Jan 21 19:45:18 mail kernel:  [<c0283be8>] ppp_start_xmit+0xd8/0x240
Jan 21 19:45:18 mail kernel:  [<c0357cf0>] qdisc_restart+0x70/0x180
Jan 21 19:45:19 mail kernel:  [<c034af2f>] dev_queue_xmit+0x1df/0x2a0
Jan 21 19:45:19 mail kernel:  [<c03652d6>] ip_finish_output2+0x106/0x1f0
Jan 21 19:45:19 mail kernel:  [<c03651d0>] ip_finish_output2+0x0/0x1f0
Jan 21 19:45:19 mail kernel:  [<c03651d0>] ip_finish_output2+0x0/0x1f0
Jan 21 19:45:19 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:19 mail kernel:  [<c03651d0>] ip_finish_output2+0x0/0x1f0
Jan 21 19:45:19 mail kernel:  [<c03651a0>] dst_output+0x0/0x30
Jan 21 19:45:19 mail kernel:  [<c0362d4a>] ip_finish_output+0x4a/0x50
Jan 21 19:45:19 mail kernel:  [<c03651d0>] ip_finish_output2+0x0/0x1f0
Jan 21 19:45:19 mail kernel:  [<c03651b4>] dst_output+0x14/0x30
Jan 21 19:45:19 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:19 mail kernel:  [<c03651a0>] dst_output+0x0/0x30
Jan 21 19:45:19 mail kernel:  [<c0364c61>] 
ip_push_pending_frames+0x2f1/0x420
Jan 21 19:45:19 mail kernel:  [<c03651a0>] dst_output+0x0/0x30
Jan 21 19:45:19 mail kernel:  [<c0362d4a>] ip_finish_output+0x4a/0x50
Jan 21 19:45:19 mail kernel:  [<c03651d0>] ip_finish_output2+0x0/0x1f0
Jan 21 19:45:19 mail kernel:  [<c03651b4>] dst_output+0x14/0x30
Jan 21 19:45:19 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:19 mail kernel:  [<c03651a0>] dst_output+0x0/0x30
Jan 21 19:45:19 mail kernel:  [<c0364c61>] 
ip_push_pending_frames+0x2f1/0x420
Jan 21 19:45:19 mail kernel:  [<c03651a0>] dst_output+0x0/0x30
Jan 21 19:45:19 mail kernel:  [<c03650e8>] ip_send_reply+0x1e8/0x250
Jan 21 19:45:19 mail kernel:  [<c0364e70>] ip_reply_glue_bits+0x0/0x90
Jan 21 19:45:20 mail kernel:  [<c03a1f9b>] ip_nat_used_tuple+0x2b/0x40
Jan 21 19:45:20 mail kernel:  [<c03a254f>] ip_nat_setup_info+0xbf/0x300
Jan 21 19:45:20 mail kernel:  [<c0379591>] tcp_v4_send_reset+0xf1/0x150
Jan 21 19:45:20 mail kernel:  [<c037abef>] tcp_v4_rcv+0x43f/0x7e0
Jan 21 19:45:20 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:20 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:21 mail kernel:  [<c036023c>] 
ip_local_deliver_finish+0xbc/0x170
LPF/eth1/52:54:4c:1a:14:8b/192.168.1.0/24
Jan 21 19:45:21 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:21 mail dhcpd:
Jan 21 19:45:21 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:21 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:21 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:21 mail kernel:  [<c035ff59>] ip_local_deliver+0x59/0x60
Jan 21 19:45:22 mail kernel:  [<c0360180>] ip_local_deliver_finish+0x0/0x170
Jan 21 19:45:22 mail kernel:  [<c03603d9>] ip_rcv_finish+0xe9/0x250
Jan 21 19:45:22 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:22 mail kernel:  [<c0356bea>] nf_hook_slow+0x11a/0x180
Jan 21 19:45:22 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:22 mail kernel:  [<c03600cd>] ip_rcv+0x16d/0x220
Jan 21 19:45:23 mail kernel:  [<c03602f0>] ip_rcv_finish+0x0/0x250
Jan 21 19:45:23 mail kernel:  [<c034b468>] netif_receive_skb+0x128/0x1b0



