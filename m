Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUJ2T5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUJ2T5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbUJ2Tz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:55:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:28327
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S263478AbUJ2ToQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:44:16 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <1099078393.14209.14.camel@krustophenia.net>
References: <1099008264.4199.4.camel@krustophenia.net>
	 <200410290057.i9T0v5I8011561@localhost.localdomain>
	 <20041029080247.GC30400@elte.hu>
	 <1099078393.14209.14.camel@krustophenia.net>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 29 Oct 2004 21:35:54 +0200
Message-Id: <1099078554.22115.63.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 15:33 -0400, Lee Revell wrote:
> On Fri, 2004-10-29 at 10:02 +0200, Ingo Molnar wrote:
> >    I know that Jackd does alot of precautions 
> >    to avoid unintentional scheduling (mlockall, the use of SCHED_FIFO), 
> >    but are you absolutely sure it doesnt happen? This scenario could be 
> >    excluded by measuring the time Jackd calls poll(), and comparing it
> >    to the expected value. [Or is this value already included in the 
> >    stats Rui collected? Maybe the "Maximum Process Cycle" value?]
> 
> Yes, this is already accounted for in the 'Maximum Process Cycle' value.
> This measures the time between returning from poll() and entering it
> again.  I will try to add some instrumentation to jackd and test this
> weekend.  I do agree that it could be a jackd bug; this would not be the
> first time the VP patches exposed bugs in other apps.
> 

Can you check out, whether the memory is getting low when you are doing
this tests ? The VM code has a serious problem, which might be related
to those latencies.

tglx


