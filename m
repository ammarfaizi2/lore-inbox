Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVLJDLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVLJDLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 22:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVLJDLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 22:11:10 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:44489 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S964891AbVLJDLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 22:11:08 -0500
Date: Fri, 9 Dec 2005 19:10:39 -0800 (PST)
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
X-X-Sender: nando@cmn37.stanford.edu
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <cc@ccrma.Stanford.EDU>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rt22 (acpi_pm vs tsc vs BIOS)
In-Reply-To: <1134181887.4002.7.camel@leatherman>
Message-ID: <Pine.LNX.4.44.0512091907220.11220-100000@cmn37.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, john stultz wrote:
> On Fri, 2005-12-09 at 17:21 -0800, Fernando Lopez-Lezcano wrote:
> > On Fri, 2005-12-09 at 15:48 -0800, Fernando Lopez-Lezcano wrote:
> > > Hi all, I'm running 2.6.14-rt22 and just noticed something strange. I
> > > have not installed it in all machines yet, but in some of them (same
> > > hardware as others that seems to work fine) the TSC was selected as the
> > > main clock for the kernel. Remember this is one of the Athlon X2
> > > machines in which the TCS's drift...
> > > 
> > > dmesg shows this:
> > >   PM-Timer running at invalid rate: 2172% of normal - aborting.
> > > 
> > > and after that the tsc is selected as the timing source.
> > >   Time: tsc clocksource has been installed.
> > > 
> > > The strange thing is that this is the same hardware as on other
> > > machines. 
> > 
> > Aha! Yes but no. The BIOS makes a difference. The first BIOS that has
> > support for the X2 processors on this particular motherboard works fine
> > with regards to the acpi_pm clock source, subsequent ones make linux say
> > things like:
> >   PM-Timer running at invalid rate: 2159% of normal - aborting.
> > and then tsc is selected as the clock source...
> 
> So you're saying the newer BIOS detects the PM timer as running too fast
> or is it the older ones?

Yes, newer ones are apparently broken. This is a GA-K8NS Ultra-939
(NForce3), acpi_pm is recognized with BIOS F7, gives an error with F8 or
F9...

-- Fernando

