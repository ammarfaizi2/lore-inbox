Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUGMLDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUGMLDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUGMLDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:03:12 -0400
Received: from pD95179CF.dip.t-dialin.net ([217.81.121.207]:48261 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S264882AbUGMLCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:02:54 -0400
Subject: Re: desktop and multimedia as an afterthought?
From: Thomas Charbonnel <thomas@undata.org>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, florin@sgi.com,
       linux-audio-dev@music.columbia.edu
In-Reply-To: <20040713032201.010f3e0f.akpm@osdl.org>
References: <1089665153.1231.88.camel@cube>
	 <200407122354.i6CNsNqS003382@localhost.localdomain>
	 <20040712172458.2659db52.akpm@osdl.org>
	 <1089683379.5773.62.camel@localhost>
	 <20040713032201.010f3e0f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089716476.5276.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 13:01:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote :

> Stack tracing seems a bit broken with 4k stacks.  Can you disable
> CONFIG_4KSTACKS for future testing?
> 

Now I get :

for the intel8x0 :

XRUN: pcmC1D0p
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0146728>] do_anonymous_page+0x118/0x190
 [<c01467ff>] do_no_page+0x5f/0x300
 [<c0146c92>] handle_mm_fault+0xe2/0x190
 [<c01456a0>] get_user_pages+0x150/0x380
 [<c0146e07>] make_pages_present+0x87/0xb0
 [<c01472a9>] mlock_fixup+0xa9/0xc0
 [<c01475ef>] do_mlockall+0x7f/0xa0
 [<c01476cb>] sys_mlockall+0xbb/0xc0
 [<c0105157>] syscall_call+0x7/0xb
Unexpected hw_pointer value [1] (stream = 1, delta: -50, max jitter =
64): wrong interrupt acknowledge?
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c033244d>] snd_pcm_period_elapsed+0x1cd/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01201ab>] do_softirq+0x2b/0x30
 [<c0107798>] do_IRQ+0x108/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
Unexpected hw_pointer value [1] (stream = 0, delta: -4, max jitter =
64): wrong interrupt acknowledge?
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c033244d>] snd_pcm_period_elapsed+0x1cd/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01201ab>] do_softirq+0x2b/0x30
 [<c0107798>] do_IRQ+0x108/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
XRUN: pcmC1D0p
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
Unexpected hw_pointer value [1] (stream = 1, delta: -22, max jitter =
64): wrong interrupt acknowledge?
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c033244d>] snd_pcm_period_elapsed+0x1cd/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01201ab>] do_softirq+0x2b/0x30
 [<c0107798>] do_IRQ+0x108/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01030f4>] cpu_idle+0x34/0x40
 [<c053e809>] start_kernel+0x169/0x190
 [<c010019f>] 0xc010019f
XRUN: pcmC1D0p
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
XRUN: pcmC1D0p
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c035790c>] snd_intel8x0_interrupt+0x1fc/0x260
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20

for the hdsp:

XRUN: pcmC2D0c
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c0368ed4>] snd_hdsp_interrupt+0x174/0x180
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01467ff>] do_no_page+0x5f/0x300
 [<c0146c92>] handle_mm_fault+0xe2/0x190
 [<c01456a0>] get_user_pages+0x150/0x380
 [<c0146e07>] make_pages_present+0x87/0xb0
 [<c01487f7>] do_mmap_pgoff+0x467/0x6c0
 [<c010ba10>] sys_mmap2+0xa0/0xe0
 [<c0105157>] syscall_call+0x7/0xb
XRUN: pcmC2D0c
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c0368ed4>] snd_hdsp_interrupt+0x174/0x180
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0145633>] get_user_pages+0xe3/0x380
 [<c0146e07>] make_pages_present+0x87/0xb0
 [<c01487f7>] do_mmap_pgoff+0x467/0x6c0
 [<c010ba10>] sys_mmap2+0xa0/0xe0
 [<c0105157>] syscall_call+0x7/0xb
XRUN: pcmC2D0c
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c0368ed4>] snd_hdsp_interrupt+0x174/0x180
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01201ab>] do_softirq+0x2b/0x30
 [<c0107798>] do_IRQ+0x108/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c01030f4>] cpu_idle+0x34/0x40
 [<c053e809>] start_kernel+0x169/0x190
 [<c010019f>] 0xc010019f
XRUN: pcmC2D0c
 [<c0105f3e>] dump_stack+0x1e/0x30
 [<c0332561>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c0368ed4>] snd_hdsp_interrupt+0x174/0x180
 [<c010739b>] handle_IRQ_event+0x3b/0x70
 [<c0107726>] do_IRQ+0x96/0x150
 [<c0105ac4>] common_interrupt+0x18/0x20
 [<c0144fc5>] zap_pte_range+0x145/0x240
 [<c0145125>] zap_pmd_range+0x65/0x90
 [<c01451a5>] unmap_page_range+0x55/0x80
 [<c01452e4>] unmap_vmas+0x114/0x1e0
 [<c0149845>] exit_mmap+0x85/0x170
 [<c0119ebf>] mmput+0x6f/0xb0
 [<c011e6c4>] do_exit+0x114/0x470
 [<c011eaca>] do_group_exit+0x3a/0xb0
 [<c012700e>] get_signal_to_deliver+0x25e/0x370
 [<c0104eea>] do_signal+0x6a/0x100
 [<c0104fb9>] do_notify_resume+0x39/0x3c
 [<c01051a2>] work_notifysig+0x13/0x15

Thomas


