Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVBLQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVBLQuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVBLQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 11:50:40 -0500
Received: from imap.gmx.net ([213.165.64.20]:22171 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261157AbVBLQuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 11:50:25 -0500
X-Authenticated: #26099252
From: Christian Heim <christian.th.heim@gmx.de>
Reply-To: christian.th.heim@gmx.de
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.11-rc3 and isdn mppp
Date: Sat, 12 Feb 2005 17:50:23 +0100
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502121750.23899.christian.th.heim@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, i have to setup ISDN here at home, and wanted to use both channels.
I am able to add the second channel, but then the kernel (at least i think) 
starts to complain.

>17:36:22 kraftwerk Badness in local_bh_enable at kernel/softirq.c:140
>17:36:22 kraftwerk [<c011b201>] local_bh_enable+0x71/0x80
>17:36:22 kraftwerk [<c030c1a7>] isdn_ppp_xmit+0xe7/0x7d0
>17:36:22 kraftwerk [<c02fe664>] isdn_net_xmit+0x184/0x1d0
>17:36:22 kraftwerk [<e0f07928>] ip_nat_cheat_check+0x28/0x40 [iptable_nat]
>17:36:22 kraftwerk [<c02fea24>] isdn_net_start_xmit+0x284/0x2a0
>17:36:22 kraftwerk [<c031b69b>] dev_queue_xmit_nit+0xeb/0xf0
>17:36:22 kraftwerk [<e0f08004>] nat_packet+0x84/0xb0 [iptable_nat]
>17:36:22 kraftwerk [<c0325b50>] qdisc_restart+0x60/0x150
>17:36:22 kraftwerk [<c031b9f5>] dev_queue_xmit+0x165/0x1f0
>17:36:22 kraftwerk [<c0320ba7>] neigh_connected_output+0x87/0xd0
>17:36:22 kraftwerk [<c0331999>] ip_finish_output2+0xc9/0x1b0
>17:36:22 kraftwerk [<c03318d0>] ip_finish_output2+0x0/0x1b0
>17:36:22 kraftwerk [<c0324d22>] nf_hook_slow+0xb2/0xf0
>17:36:22 kraftwerk [<c03318d0>] ip_finish_output2+0x0/0x1b0
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032f5fa>] ip_finish_output+0x1da/0x1e0
>17:36:22 kraftwerk [<c03318d0>] ip_finish_output2+0x0/0x1b0
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032dfd9>] ip_forward_finish+0x19/0x40
>17:36:22 kraftwerk [<c0324d22>] nf_hook_slow+0xb2/0xf0
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032df3a>] ip_forward+0x17a/0x200
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c032cff9>] ip_rcv_finish+0x199/0x220
>17:36:22 kraftwerk [<c0324a22>] nf_iterate+0x72/0xb0
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c0324d22>] nf_hook_slow+0xb2/0xf0
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032df3a>] ip_forward+0x17a/0x200
>17:36:22 kraftwerk [<c032dfc0>] ip_forward_finish+0x0/0x40
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c032cff9>] ip_rcv_finish+0x199/0x220
>17:36:22 kraftwerk [<c0324a22>] nf_iterate+0x72/0xb0
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c0324d22>] nf_hook_slow+0xb2/0xf0
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c032cca2>] ip_rcv+0x362/0x400
>17:36:22 kraftwerk [<c032ce60>] ip_rcv_finish+0x0/0x220
>17:36:22 kraftwerk [<c031be59>] netif_receive_skb+0x119/0x170
>17:36:22 kraftwerk [<c0316552>] alloc_skb+0x32/0xd0
>17:36:22 kraftwerk [<c02d71fd>] rtl8139_rx+0x18d/0x310
>17:36:22 kraftwerk [<c02d7521>] rtl8139_poll+0x41/0xc0
>17:36:22 kraftwerk [<c031c001>] net_rx_action+0x61/0xe0
>17:36:22 kraftwerk [<c011b179>] __do_softirq+0x79/0x90
>17:36:22 kraftwerk [<c01045c1>] do_softirq+0x41/0x50
>17:36:22 kraftwerk =======================
>17:36:22 kraftwerk [<c010449f>] do_IRQ+0x5f/0xa0
>17:36:22 kraftwerk [<c0102cfe>] common_interrupt+0x1a/0x20
>17:36:22 kraftwerk [<c0100593>] default_idle+0x23/0x30
>17:36:22 kraftwerk [<c0100618>] cpu_idle+0x48/0x60
>17:36:22 kraftwerk [<c046a78d>] start_kernel+0x14d/0x190
>17:36:22 kraftwerk [<c046a380>] unknown_bootoption+0x0/0x1b0

I'm using the vanilla-2.6.11-rc3 sources with the following config:
>CONFIG_PPP=y
>CONFIG_PPP_MULTILINK=y
>CONFIG_PPP_FILTER=y
># CONFIG_PPP_ASYNC is not set
>CONFIG_PPP_SYNC_TTY=y
>CONFIG_PPP_DEFLATE=y
>CONFIG_PPP_BSDCOMP=y
>CONFIG_PPPOE=y
># ISDN subsystem
>CONFIG_ISDN=y
># Old ISDN4Linux
>CONFIG_ISDN_I4L=y
>CONFIG_ISDN_PPP=y
>CONFIG_ISDN_PPP_VJ=y
>CONFIG_ISDN_MPP=y
>CONFIG_IPPP_FILTER=y
>CONFIG_ISDN_PPP_BSDCOMP=y
># CONFIG_ISDN_AUDIO is not set
># ISDN feature submodules
># CONFIG_ISDN_DRV_LOOP is not set
># CONFIG_ISDN_DIVERSION is not set
># ISDN4Linux hardware drivers
>CONFIG_ISDN_DRV_HISAX=m
># CONFIG_ISDN_DRV_TPAM is not set
># CONFIG_ISDN_CAPI is not set

The connection is been established with isdn4k-utils-3.2_p1.

And again this only happens if I add a second link to the master device!

Hope anybody could help me

With kind regards

Christian Heim
