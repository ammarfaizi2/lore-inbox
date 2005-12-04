Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVLDXnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVLDXnK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLDXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:43:10 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:64400 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932279AbVLDXnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:43:08 -0500
Date: Mon, 5 Dec 2005 00:43:20 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shemminger@osdl.org, netdev@vger.kernel.org
Message-ID: <20051204234320.GA7478@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	shemminger@osdl.org, netdev@vger.kernel.org
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.217.138
Subject: Re: Linux 2.6.15-rc5: sk98lin broken
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005, Linus Torvalds wrote:
> shemminger@osdl.org:
>       sk98lin: fix checksumming code
>       sk98lin: add permanent address support
>       sk98lin: avoid message confusion with skge

I have an Asus P4P800 "Deluxe" with 3c940 LOM.

If I ping the box I get the following:

Dec  4 22:57:02 abc kernel: [<c0103c00>] dump_stack+0x17/0x19
Dec  4 22:57:02 abc kernel: [<c03b99e9>] netdev_rx_csum_fault+0x27/0x2d
Dec  4 22:57:02 abc kernel: [<c03b75a9>] __skb_checksum_complete+0x5a/0x60
Dec  4 22:57:02 abc kernel: [<c0404c51>] icmp_error+0xbd/0x193
Dec  4 22:57:02 abc kernel: [<c0402291>] ip_conntrack_in+0x67/0x279
Dec  4 22:57:02 abc kernel: [<c03c8cbf>] nf_iterate+0x59/0x7d
Dec  4 22:57:02 abc kernel: [<c03c8d3a>] nf_hook_slow+0x57/0x106
Dec  4 22:57:02 abc kernel: [<c03d1074>] ip_rcv+0x1af/0x580
Dec  4 22:57:02 abc kernel: [<c03ba1ed>] netif_receive_skb+0x15a/0x1ef
Dec  4 22:57:02 abc kernel: [<c03ba301>] process_backlog+0x7f/0x10d
Dec  4 22:57:02 abc kernel: [<c03ba40c>] net_rx_action+0x7d/0x110
Dec  4 22:57:02 abc kernel: [<c01250a2>] __do_softirq+0x72/0xe1
Dec  4 22:57:02 abc kernel: [<c0104ed7>] do_softirq+0x5d/0x61
Dec  4 22:57:02 abc kernel: =======================
Dec  4 22:57:02 abc kernel: [<c01251fa>] irq_exit+0x48/0x4a
Dec  4 22:57:02 abc kernel: [<c0104d9d>] do_IRQ+0x5d/0x8f
Dec  4 22:57:02 abc kernel: [<c010372e>] common_interrupt+0x1a/0x20
Dec  4 22:57:02 abc kernel: [<c0100d51>] cpu_idle+0x49/0xa0
Dec  4 22:57:02 abc kernel: [<c01002d7>] rest_init+0x37/0x39
Dec  4 22:57:02 abc kernel: [<c057f8cf>] start_kernel+0x164/0x177
Dec  4 22:57:02 abc kernel: [<c0100210>] 0xc0100210

  (once for each ICMP packet)

2.6.15-rc2 works fine.


Johannes
