Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVF1IWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVF1IWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVF1IWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:22:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31707 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261734AbVF1ITX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:19:23 -0400
Date: Tue, 28 Jun 2005 10:18:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050628081843.GA16455@elte.hu>
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu> <200506250919.52640.gene.heskett@verizon.net> <200506251039.14746.gene.heskett@verizon.net> <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov> <1119902991.4794.5.camel@dhcp153.mvista.com> <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Although turning off apm works, this is a fix to the symptom and not a 
> cure.  Has someone already taken a look at this code? Since 
> apm_bios_call_simple calls local_save_flags and afterwards 
> raw_lock_irq_restore is then called.  Shouldn't that have been 
> raw_local_save_flags?

ah, indeed. I fixed this bug and have uploaded the -50-26 patch. Chuck, 
does this fix the APM problems for you?

> That apm_bios_call_simple_asm also looks pretty scary!  I haven't yet 
> figured out how APM_FUNC_VERSION becomes a normal function.

it's all black magic, so when hacking that code i always close my eyes.  
(that's how the bug got introduced)

	Ingo
