Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVKBCs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVKBCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVKBCs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:48:26 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:24209 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932228AbVKBCsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:48:25 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130876293.6178.6.camel@cmn3.stanford.edu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 18:47:42 -0800
Message-Id: <1130899662.12101.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 12:18 -0800, Fernando Lopez-Lezcano wrote:
> On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote: 
> > i have released the 2.6.14-rt1 tree, which can be downloaded from the 
> > usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > this release is mainly about ktimer fixes: it updates to the latest 
> > ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
> > GTOD tree), it fixes TSC synchronization problems on HT systems, and 
> > updates the ktimers debugging code.
> > 
> > These together could fix most of the timer warnings and annoyances 
> > reported for 2.6.14-rc5-rt kernels. In particular the new 
> > TSC-synchronization code could fix SMP systems: the upstream TSC 
> > synchronization method is fine for 1 usec resolution, but it was not 
> > good enough for 1 nsec resolution and likely caused the SMP bugs 
> > reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> > 
> > Please re-report any bugs that remain.
> 
> 2.6.14-rt2 seems to be running fine on my athlon x2 smp system. Apart
> from some time warp messages when starting up it looks fine so far (this
> is on fc4). 

Actually, after enough time logged in (or maybe just with the kernel
running without a reboot) I still get the usual Jack warnings:

delay of 5469.000 usecs exceeds estimated spare time of 2641.000;
restart ...

-- Fernando


