Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263832AbRFDUmG>; Mon, 4 Jun 2001 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFDUl4>; Mon, 4 Jun 2001 16:41:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:39103 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263832AbRFDUlt>; Mon, 4 Jun 2001 16:41:49 -0400
Date: Mon, 4 Jun 2001 16:41:48 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106042041.f54KfmY07533@devserv.devel.redhat.com>
To: green@linuxhacker.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac7 SMP crash (hotplug race?)
In-Reply-To: <mailman.991678980.18162.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.991678980.18162.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I told device to go to sleep, it reported (over serial console that I
>    looked at with minicom), that it turned off internal devices
>    (including USB client), reported it is going to sleep, and turned
>    serial and itself off.

What does it mean "I told device to go to sleep"?
What device? How (what command line)?

> wait_on_irq, CPU 1
> irq: 1 [1 0]
> bh:  1 [0 1]
> CPU 0: <unknown>
> CPU 1: c167fe68 c01d805d ... (not recorded full stack)
> Call Trace: [<c0108522>] [<c0170f97>] [<c0170f60>] [<c011d706>] [<c011a56c>] [<c011a423>] [<c011a2ab>] [<c0108935>] [<c0108525>] [<c01617e8>] [<c011a67d>] [<c0121c35>] [<c0121670>] [<c0105000>] [<c0105556>] [<c0121670>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c0108522 <__global_cli+e2/170>
> Trace; c0170f97 <rs_timer+37/110>
> Trace; c0170f60 <rs_timer+0/110>
> Trace; c011d706 <timer_bh+256/2b0>
> Trace; c011a56c <bh_action+4c/b0>
> Trace; c011a423 <tasklet_hi_action+53/90>
> Trace; c011a2ab <do_softirq+6b/a0>
> Trace; c0108935 <do_IRQ+e5/f0>
> Trace; c0108525 <__global_cli+e5/170>
> Trace; c01617e8 <flush_to_ldisc+d8/120>
> Trace; c011a67d <__run_task_queue+5d/70>
> Trace; c0121c35 <context_thread+c5/200>
> Trace; c0121670 <exec_usermodehelper+3c0/400>
> Trace; c0105000 <prepare_namespace+0/10>
> Trace; c0105556 <kernel_thread+26/30>
> Trace; c0121670 <exec_usermodehelper+3c0/400>

Curious. What host controller driver do you use?

-- Pete
