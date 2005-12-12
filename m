Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVLLBSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVLLBSE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVLLBSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:18:03 -0500
Received: from services.erkkila.org ([24.97.94.217]:54149 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id S1750983AbVLLBSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:18:01 -0500
Message-ID: <439CCFC7.2080100@erkkila.org>
Date: Mon, 12 Dec 2005 01:17:59 +0000
From: Paul Erkkila <pee@erkkila.org>
User-Agent: Mail/News 1.5 (X11/20051209)
MIME-Version: 1.0
To: linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5 gre tunnel checksum error
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    I'm getting this traceback from 2.6.15-rc5.

    - no skge driver in this box
        - 02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit
Ethernet Controller (LOM)
        - 03:01.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
        - 03:04.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 78)

    - just seems to be ping that causes it
    - the checksums look ok with tethereal

tunnel0: hw csum failure.
 [<c03733cf>] __skb_checksum_complete+0x67/0x6d
 [<c03cd50f>] icmp_error+0xbb/0x1c1
 [<c03d36ce>] ipt_do_table+0x2f2/0x4f0
 [<c03718dc>] skb_checksum+0x4e/0x2c2
 [<c03ca33c>] ip_conntrack_in+0x117/0x395
 [<c03d9f33>] ipt_hook+0x37/0x3c
 [<c03882cc>] nf_iterate+0x58/0xa8
 [<c039177a>] ip_rcv_finish+0x0/0x2ba
 [<c0388387>] nf_hook_slow+0x6b/0x134
 [<c039177a>] ip_rcv_finish+0x0/0x2ba
 [<c03913ba>] ip_rcv+0x1d0/0x590
 [<c039177a>] ip_rcv_finish+0x0/0x2ba
 [<c03763ba>] netif_receive_skb+0x1d0/0x23e
 [<c03764aa>] process_backlog+0x82/0x109
 [<c03765c0>] net_rx_action+0x8f/0x16a
 [<c0126517>] __do_softirq+0x6b/0xd8
 [<c01265b6>] do_softirq+0x32/0x34
 [<c0104ee2>] do_IRQ+0x1e/0x24
 [<c0103756>] common_interrupt+0x1a/0x20
 [<c0100d6c>] default_idle+0x2e/0x52
 [<c0100e09>] cpu_idle+0x65/0x73
 [<c055a945>] start_kernel+0x180/0x1bc
 [<c055a32a>] unknown_bootoption+0x0/0x1e0


-pee

