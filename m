Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbVLWSpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbVLWSpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbVLWSpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:45:14 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24249 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030586AbVLWSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:45:12 -0500
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost
	a	preemption check!
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, John Rigg <lk@sound-man.co.uk>
In-Reply-To: <43AC2607.1050707@cybsft.com>
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com>
	 <1135352277.6652.2.camel@localhost.localdomain>
	 <43AC2607.1050707@cybsft.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 13:45:00 -0500
Message-Id: <1135363500.6652.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 10:29 -0600, K.R. Foley wrote:

> 
> OK. The BUG still exists (output below) but it does boot now with the
> above patch applied (THANKS Steven!), which would seem to imply the two
> weren't related. ARGH! :)
> 
> Dec 23 10:16:27 porky kernel: Event source lapic installed with caps set: 06
> Dec 23 10:16:27 porky kernel: BUG: swapper:0 task might have lost a
> preemption check!
> Dec 23 10:16:27 porky kernel: Brought up 2 CPUs
> Dec 23 10:16:27 porky kernel: checking if image is initramfs... it is
> Dec 23 10:16:27 porky kernel:  [<c010424e>] dump_stack+0x1e/0x20 (20)
> Dec 23 10:16:27 porky kernel:  [<c011c9cf>]
> preempt_enable_no_resched+0x5f/0x70 (20)
> Dec 23 10:16:27 porky kernel:  [<c0100ff2>] cpu_idle+0xb2/0x100 (40)
> Dec 23 10:16:27 porky kernel:  [<c0111446>]
> start_secondary+0x296/0x340<6>Freeing initrd memory: 452k freed
> 

Yeah, I've seen the "might have lost a preemption check" too. But since
this didn't seem to cause a problem booting my kernel (yet), it went to
the end of the todo list.

Does this cause any other problems?

-- Steve


