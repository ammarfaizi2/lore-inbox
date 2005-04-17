Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVDQUfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVDQUfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVDQUe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:34:29 -0400
Received: from main.gmane.org ([80.91.229.2]:59051 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261519AbVDQUdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:33:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Shaun Reitan" <mailinglists@unix-scripts.com>
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Date: Sun, 17 Apr 2005 13:32:42 -0700
Message-ID: <d3ugtr$gml$1@sea.gmane.org>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com> <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-111-70-41.oc.oc.cox.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, finally got a full dump from the serial console!  Here is it!

----------------------------------------------------------------------------
---------------------------------------
Unable to handle kernel paging request at virtual address f8b6f02c
 printing eip:
f88b0078
*pde = 031f6067
Oops: 0000 [#1]
SMP
Modules linked in: loop tun ebt_ip ebt_arp ebtable_filter ebtables autofs4
ipv6

bridge e1000 ohci1394 ieee1394 floppy sg parport_pc parport ext3 jbd 3w_9xxx
sd_

mod scsi_mod
CPU:    0
EIP:    0060:[<f88b0078>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11.5-hr1)
EIP is at ebt_do_table+0x78/0x6e0 [ebtables]
eax: f8b6f000   ebx: f88b7000   ecx: f88b7080   edx: f88b7080
esi: c03e8d20   edi: c0438f08   ebp: 80000000   esp: c03e8c7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03e8000 task=c0333b60)
Stack: c0438dd8 80000000 c0294362 f7728580 c02a9010 00000003 00000003
c85c6012
       f8816610 f8b6f000 f8b6f000 f8b39000 00000000 f88b7080 f88b7080
0000000a
       0000000a f6646800 c03e8d1c 00000001 f8816620 c03e8d20 c0438f08
80000000
Call Trace:
 [<c0294362>] nf_iterate+0x72/0xb0
 [<c02a9010>] dst_output+0x0/0x20
 [<c0294362>] nf_iterate+0x72/0xb0
 [<f889e6d0>] br_pass_frame_up_finish+0x0/0x10 [bridge]
 [<c0294708>] nf_hook_slow+0x68/0xf0
 [<f889e6d0>] br_pass_frame_up_finish+0x0/0x10 [bridge]
 [<f889e73a>] br_pass_frame_up+0x5a/0x60 [bridge]
 [<f889e6d0>] br_pass_frame_up_finish+0x0/0x10 [bridge]
 [<f889e7b9>] br_handle_frame_finish+0x79/0x110 [bridge]
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<c0294752>] nf_hook_slow+0xb2/0xf0
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<f88a231c>] br_nf_pre_routing_finish+0xfc/0x290 [bridge]
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<c0113d20>] try_to_wake_up+0x220/0x250
 [<c012dbeb>] autoremove_wake_function+0x1b/0x50
 [<c0115737>] __wake_up_common+0x37/0x60
 [<c0122386>] __mod_timer+0xd6/0x120
 [<c0294362>] nf_iterate+0x72/0xb0
 [<f88a2220>] br_nf_pre_routing_finish+0x0/0x290 [bridge]
 [<f88a2220>] br_nf_pre_routing_finish+0x0/0x290 [bridge]
 [<c0294752>] nf_hook_slow+0xb2/0xf0
 [<f88a2220>] br_nf_pre_routing_finish+0x0/0x290 [bridge]
 [<f88a29f7>] br_nf_pre_routing+0x257/0x410 [bridge]
 [<f88a2220>] br_nf_pre_routing_finish+0x0/0x290 [bridge]
 [<c0294362>] nf_iterate+0x72/0xb0
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<c0294708>] nf_hook_slow+0x68/0xf0
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<f889e94a>] br_handle_frame+0xfa/0x1e0 [bridge]
 [<f889e740>] br_handle_frame_finish+0x0/0x110 [bridge]
 [<c028aa3d>] netif_receive_skb+0x13d/0x2c0
 [<f888b42e>] e1000_clean_rx_irq+0x15e/0x4a0 [e1000]
 [<c02849d9>] __kfree_skb+0xa9/0x150
 [<f888b06a>] e1000_clean+0xba/0xf0 [e1000]
 [<c028ad4f>] net_rx_action+0x6f/0x100
 [<c011e909>] __do_softirq+0xb9/0xd0
 [<c0104a8a>] do_softirq+0x4a/0x60
 =======================
 [<c0104953>] do_IRQ+0x63/0xb0
 [<c010e7d0>] smp_apic_timer_interrupt+0xd0/0xe0
 [<c01030c2>] common_interrupt+0x1a/0x20
 [<c0100812>] mwait_idle+0x52/0x80
 [<c0100650>] default_idle+0x0/0x30
 [<c010071b>] cpu_idle+0x5b/0x70
 [<c03ad911>] start_kernel+0x161/0x1a0
 [<c03ad350>] unknown_bootoption+0x0/0x1e0
Code: 00 89 54 24 34 8b 43 20 c7 44 24 2c 00 00 00 00 85 c0 74 07 8b 0c 88
89 4c

 24 2c 8b 44 24 4c 8b 4c 24 34 8b 44 83 08 89 44 24 28 <8b> 50 2c 89 c5 83
c5 30

 89 54 24 3c 8b 40 24 c1 e0 04 01 c8 89
 <0>Kernel panic - not syncing: Fatal exception in interrupt
----------------------------------------------------------------------------
-----------------------------

--

Best Regards,

Shaun Reitan

"Zwane Mwaikambo" <zwane@arm.linux.org.uk> wrote in message
news:Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com...
> On Tue, 12 Apr 2005, mailinglist@unix-scripts.com wrote:
>
> > The machine crashed again twice today.  I have vga=791 so i caugh a bit
more
> > of the crash.  i enabled serial redirection in the bios so i'm hoping to
> > catch the full dump next time.
>
> Cool, can you also try Cc'ing netdev@oss.sgi.com?
>
> Thanks,
> Zwane
>



