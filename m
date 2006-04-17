Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWDQPF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWDQPF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWDQPF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:05:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21404 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751077AbWDQPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:05:27 -0400
Subject: Re: RT question : softirq and minimal user RT priority
From: Lee Revell <rlrevell@joe-job.com>
To: markh@compro.net
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <4443966B.8020802@compro.net>
References: <200601131527.00828.Serge.Noiraud@bull.net>
	 <1137167600.7241.22.camel@localhost.localdomain>
	 <4443966B.8020802@compro.net>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 11:05:24 -0400
Message-Id: <1145286325.16138.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't trim CC lists

On Mon, 2006-04-17 at 09:21 -0400, Mark Hounschell wrote:
> Steven Rostedt wrote:
> >> Is the smallest usable real-time priority greater than the highest real-time softirq ?
> > 
> > Nope, you can use any rt priority you want.  It's up to you whether you
> > want to preempt the softirqs or not. Be careful, timers may be preempted
> > from delivering signals to high priority processes.  I have a patch to
> > fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
> > 
> > -- Steve
> 
> I know this is an old thread but I seem to be having a problem similar
> to this and I didn't find any real resolution in the archives.
> 
> I'm using the rt16 patch on 2.6.16.5 with complete preemption. I have a
> high priority rt compute bound task that isn't getting signals from a
> pci cards interrupt handler. Only when I insure the rt priority of the
> task is lower than the rt priority of the irq thread ([IRQ 193]) will my
> task receive signals.
> 
> Is this a bug? Is the bug in my interrupt handler? Or is this expected
> and acceptable?

It's expected if your high priority RT task never gives up the CPU - if
this is the case the IRQ thread should have higher priority.

Lee

