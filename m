Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVF0Tnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVF0Tnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVF0Tnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:43:50 -0400
Received: from smtp-1.llnl.gov ([128.115.250.81]:15333 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S261175AbVF0TmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:42:22 -0400
Date: Mon, 27 Jun 2005 12:42:20 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506271211510.8605@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
 <200506251039.14746.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Chuck Harding wrote:

> What can be causing the following message to appear in dmesg and
> how can I fix it?
>
> BUG: scheduling with irqs disabled: kapmd/0x00000000/46
> caller is schedule_timeout+0x51/0x9e
> [<c02b3bc9>] schedule+0x96/0xf6 (8)
> [<c02b43f7>] schedule_timeout+0x51/0x9e (28)
> [<c01222ed>] process_timeout+0x0/0x5 (32)
> [<c0112063>] apm_mainloop+0x7a/0x96 (24)
> [<c0115e45>] default_wake_function+0x0/0x16 (12)
> [<c0115e45>] default_wake_function+0x0/0x16 (32)
> [<c0111485>] apm_driver_version+0x1c/0x38 (16)
> [<c01126f7>] apm+0x0/0x289 (8)
> [<c01127a6>] apm+0xaf/0x289 (8)
> [<c010133c>] kernel_thread_helper+0x0/0xb (20)
> [<c0101341>] kernel_thread_helper+0x5/0xb (4)
>
> This was also present in earlier final-V0.7.50 version I've tried
> (since -00) I don't get hangs but that doesn't look like it should
> be happening. Thanks.
>
another symptom (don't know if it's actually related) is that if I
try to switch to a virtual consol (ctl-alt-chift-F[1..6] the screen
won't change out of graphics mode - it goes black like it's trying
to switch but comes back with the graphical screen which isn't responsive
and hitting alt-F7 restores it to operation. I just rebooted to a kernel
that doesn't have the RT-preempt patch but uses the same .config and
everything for switching between X and virtual terminals works just fine.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- I'm not fat, just horizontally disproportionate. --
