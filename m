Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbUJ0NzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUJ0NzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUJ0Ny7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:54:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38029 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262442AbUJ0Nvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:51:55 -0400
Date: Wed, 27 Oct 2004 15:53:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
Message-ID: <20041027135309.GA8090@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. Currently with RT-V0.3.2.
> 
> So it seems that the jackd -R is no more an issue here.

great.

> However (oh no!:) those jackd -R xruns are still frequent, much
> frequent than RT-U3, which is my stable RT kernel atm.

-V0.4.1 could help with this problem. There were a number of places
where the PREEMPT_REALTIME kernel missed reschedules so it could easily
happen that jackd would sit in the runqueue waiting to be executed and
the kernel got quickly out of a critical section but then the kernel
'forgot' to reschedule for many milliseconds!

	Ingo
