Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVAXSUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVAXSUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVAXSUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:20:54 -0500
Received: from [217.7.64.195] ([217.7.64.195]:43648 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S261548AbVAXSTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:19:33 -0500
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2: Badness in local_bh_enable at kernel/softirq.c:140
Date: Mon, 24 Jan 2005 19:19:29 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xwT9BN514rv+K15"
Message-Id: <200501241919.29987.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xwT9BN514rv+K15
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


(2.6.11-rc1 does _not_ have this problem)

Config attached. 

[....]
Jan 24 18:33:29 dev vtund[10306]: VTUN server ver 2.6 11/08/2004 (stand)
Jan 24 18:33:30 dev init: Activating demand-procedures for 'A'
Jan 24 18:33:30 dev vtund[10438]: Session oernie[213.54.9.143:35645] opened
Jan 24 18:33:30 dev vtund[10438]: ZLIB compression[level 9] initialized.
Jan 24 18:33:30 dev vtund[10438]: BlowFish encryption initialized
Jan 24 18:33:30 dev device tap0 entered promiscuous mode
Jan 24 18:33:30 dev br1: port 2(tap0) entering learning state
Jan 24 18:33:30 dev Ebtables v2.0 registered
Jan 24 18:33:30 dev Badness in local_bh_enable at kernel/softirq.c:140
Jan 24 18:33:30 dev [<c0121648>] local_bh_enable+0x88/0x90
Jan 24 18:33:30 dev [<f9324501>] ebt_do_table+0x501/0x6f0 [ebtables]
Jan 24 18:33:30 dev [<f91d2b60>] br_dev_queue_push_xmit+0x0/0x140 [bridge]
Jan 24 18:33:30 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:30 dev [<f91d2b60>] br_dev_queue_push_xmit+0x0/0x140 [bridge]
Jan 24 18:33:30 dev [<f91d2b60>] br_dev_queue_push_xmit+0x0/0x140 [bridge]
Jan 24 18:33:30 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:30 dev [<f91d8919>] br_nf_local_out_finish+0x69/0xb0 [bridge]
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<c02b50a1>] nf_hook_slow+0xf1/0x130
Jan 24 18:33:30 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:30 dev [<f91d8a57>] br_nf_local_out+0xf7/0x250 [bridge]
Jan 24 18:33:30 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<f91d2d65>] __br_deliver+0x65/0x70 [bridge]
Jan 24 18:33:30 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:30 dev [<f91d2085>] br_dev_xmit+0x75/0xc0 [bridge]
Jan 24 18:33:30 dev [<c02a9a8e>] dev_queue_xmit+0xde/0x2a0
Jan 24 18:33:30 dev [<c02c398f>] ip_finish_output2+0xaf/0x1b0
Jan 24 18:33:30 dev [<c0115df0>] activate_task+0x90/0xb0
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<f91d8e73>] ip_sabotage_out+0x113/0x180 [bridge]
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02c1285>] ip_finish_output+0x205/0x210
Jan 24 18:33:30 dev [<c02c38e0>] ip_finish_output2+0x0/0x1b0
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02c38c4>] dst_output+0x14/0x30
Jan 24 18:33:30 dev [<f91d8e73>] ip_sabotage_out+0x113/0x180 [bridge]
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c02c188d>] ip_queue_xmit+0x3cd/0x4f0
Jan 24 18:33:30 dev [<c02c38b0>] dst_output+0x0/0x30
Jan 24 18:33:30 dev [<c0115c98>] recalc_task_prio+0x88/0x150
Jan 24 18:33:30 dev [<c0115c98>] recalc_task_prio+0x88/0x150
Jan 24 18:33:30 dev [<c0115df0>] activate_task+0x90/0xb0
Jan 24 18:33:30 dev [<c0115c98>] recalc_task_prio+0x88/0x150
Jan 24 18:33:30 dev [<c0115df0>] activate_task+0x90/0xb0
Jan 24 18:33:30 dev [<c0116372>] try_to_wake_up+0x252/0x280
Jan 24 18:33:30 dev [<c02d87e1>] tcp_v4_send_check+0x51/0xf0
Jan 24 18:33:30 dev [<c02d5a90>] tcp_delack_timer+0x0/0x200
Jan 24 18:33:30 dev [<c02d26d0>] tcp_transmit_skb+0x440/0x730
Jan 24 18:33:30 dev [<c02d5a90>] tcp_delack_timer+0x0/0x200
Jan 24 18:33:30 dev [<c02d50b0>] tcp_send_ack+0xa0/0xf0
Jan 24 18:33:30 dev [<c02d5ba2>] tcp_delack_timer+0x112/0x200
Jan 24 18:33:30 dev [<c0125a06>] run_timer_softirq+0xd6/0x1c0
Jan 24 18:33:30 dev [<c01215aa>] __do_softirq+0xba/0xd0
Jan 24 18:33:30 dev [<c0104e6a>] do_softirq+0x4a/0x60
Jan 24 18:33:30 dev =======================
Jan 24 18:33:30 dev [<c0121689>] irq_exit+0x39/0x40
Jan 24 18:33:30 dev [<c01032b4>] apic_timer_interrupt+0x1c/0x24
Jan 24 18:33:30 dev [<c013f2f7>] __mod_page_state+0x27/0x30
Jan 24 18:33:30 dev [<c014aa96>] handle_mm_fault+0x36/0x170
Jan 24 18:33:30 dev [<c011493c>] do_page_fault+0x19c/0x5d5
Jan 24 18:33:30 dev [<c015ac35>] __fput+0xc5/0x130
Jan 24 18:33:30 dev [<c014b8f7>] remove_vm_struct+0x77/0xa0
Jan 24 18:33:30 dev [<c014d2ff>] unmap_vma_list+0x1f/0x30
Jan 24 18:33:30 dev [<c014d6e3>] do_munmap+0x143/0x180
Jan 24 18:33:30 dev [<c014d765>] sys_munmap+0x45/0x70
Jan 24 18:33:30 dev [<c01147a0>] do_page_fault+0x0/0x5d5
Jan 24 18:33:30 dev [<c010335b>] error_code+0x2b/0x30
Jan 24 18:33:31 dev Badness in local_bh_enable at kernel/softirq.c:140
Jan 24 18:33:31 dev [<c0121648>] local_bh_enable+0x88/0x90
Jan 24 18:33:31 dev [<f9324501>] ebt_do_table+0x501/0x6f0 [ebtables]
Jan 24 18:33:31 dev [<c01af46d>] balance_internal+0x31d/0xa00
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:31 dev [<f91d8919>] br_nf_local_out_finish+0x69/0xb0 [bridge]
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<c02b50a1>] nf_hook_slow+0xf1/0x130
Jan 24 18:33:31 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:31 dev [<f91d8a57>] br_nf_local_out+0xf7/0x250 [bridge]
Jan 24 18:33:31 dev [<f91d88b0>] br_nf_local_out_finish+0x0/0xb0 [bridge]
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<c02b4c3a>] nf_iterate+0x7a/0xb0
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<c02b5032>] nf_hook_slow+0x82/0x130
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<f91d2d65>] __br_deliver+0x65/0x70 [bridge]
Jan 24 18:33:31 dev [<f91d2ca0>] br_forward_finish+0x0/0x60 [bridge]
Jan 24 18:33:31 dev [<f91d2085>] br_dev_xmit+0x75/0xc0 [bridge]
Jan 24 18:33:31 dev [<c02a9a8e>] dev_queue_xmit+0xde/0x2a0

[... megabytes of similar messages ....]

Patches welcome :)

<Earny>

--Boundary-00=_xwT9BN514rv+K15
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.bz2"

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
oA==

--Boundary-00=_xwT9BN514rv+K15--
