Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbULJF7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbULJF7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULJF7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:59:20 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:38924 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261692AbULJF7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:59:16 -0500
Date: Thu, 9 Dec 2004 21:58:10 -0800
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bill Huey <bhuey@lnxw.com>, Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Ingo Molnar <mingo@elte.hu>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041210055810.GA30416@nietzsche.lynx.com>
References: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com> <20041210050126.GA30282@nietzsche.lynx.com> <1102655656.3238.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102655656.3238.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 12:14:16AM -0500, Steven Rostedt wrote:
> On Thu, 2004-12-09 at 21:01 -0800, Bill Huey wrote:
> > On Thu, Dec 09, 2004 at 01:23:38PM -0600, Mark_H_Johnson@raytheon.com wrote:
> > > I may take this "off line" if it goes on too much longer. A little
> > > "view of the customer" is good for the whole group, but if it
> > > gets too much into my specific application, I don't see the benefit.
> > 
> > Taking offline would cut the rest of the developers off from having
> > any empirical data to work with. It's a bad idea. The entire point
> > of the RT kernel and app is to characterize the behavior of the system
> > so that fringe events happen and so that they can be tracked down and
> > eventually solved. Continue on IMO. :)
> 
> I second the motion. It's a fun read ;-)

Like your SLAB adventures. I thought it was a bit bizzare that it was
made fully preemptable and it any time you get another developer able
to hammer on this, like you, is alway an encouraging sign for the rest
of us on this project. :)

Unfortunately, jackd is only one program and what's needed is a broader
set of apps that can push the system much harder, along with jackd, to
see where things blow up. SMP is a likely trigger for all of this stuff.
In particular, shared-exclusive lock semantics under high contention
situations, vma access, etc... We'll see.

bill

