Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVF0UJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVF0UJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVF0UJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:09:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2806 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261154AbVF0UJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:09:57 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
References: <20050608112801.GA31084@elte.hu>
	 <20050625091215.GC27073@elte.hu>
	 <200506250919.52640.gene.heskett@verizon.net>
	 <200506251039.14746.gene.heskett@verizon.net>
	 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 27 Jun 2005 13:09:51 -0700
Message-Id: <1119902991.4794.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 12:01 -0700, Chuck Harding wrote:
> What can be causing the following message to appear in dmesg and
> how can I fix it?
> 
> BUG: scheduling with irqs disabled: kapmd/0x00000000/46
> caller is schedule_timeout+0x51/0x9e
>   [<c02b3bc9>] schedule+0x96/0xf6 (8)
>   [<c02b43f7>] schedule_timeout+0x51/0x9e (28)
>   [<c01222ed>] process_timeout+0x0/0x5 (32)
>   [<c0112063>] apm_mainloop+0x7a/0x96 (24)
>   [<c0115e45>] default_wake_function+0x0/0x16 (12)
>   [<c0115e45>] default_wake_function+0x0/0x16 (32)
>   [<c0111485>] apm_driver_version+0x1c/0x38 (16)
>   [<c01126f7>] apm+0x0/0x289 (8)
>   [<c01127a6>] apm+0xaf/0x289 (8)
>   [<c010133c>] kernel_thread_helper+0x0/0xb (20)
>   [<c0101341>] kernel_thread_helper+0x5/0xb (4)
> 
> This was also present in earlier final-V0.7.50 version I've tried
> (since -00) I don't get hangs but that doesn't look like it should
> be happening. Thanks.

If you have PREEMPT_RT enabled, it looks like interrupts are hard
disabled then there is a schedule_timeout() requested. You could try
turning off power management and see if you still have problems.

Daniel 


