Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVLJCba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVLJCba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVLJCba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:31:30 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:43196 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932533AbVLJCb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:31:29 -0500
Subject: Re: 2.6.14-rt22 (acpi_pm vs tsc vs BIOS)
From: john stultz <johnstul@us.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134177671.4811.4.camel@cmn3.stanford.edu>
References: <1134172105.12624.27.camel@cmn3.stanford.edu>
	 <1134177671.4811.4.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 18:31:26 -0800
Message-Id: <1134181887.4002.7.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 17:21 -0800, Fernando Lopez-Lezcano wrote:
> On Fri, 2005-12-09 at 15:48 -0800, Fernando Lopez-Lezcano wrote:
> > Hi all, I'm running 2.6.14-rt22 and just noticed something strange. I
> > have not installed it in all machines yet, but in some of them (same
> > hardware as others that seems to work fine) the TSC was selected as the
> > main clock for the kernel. Remember this is one of the Athlon X2
> > machines in which the TCS's drift...
> > 
> > dmesg shows this:
> >   PM-Timer running at invalid rate: 2172% of normal - aborting.
> > 
> > and after that the tsc is selected as the timing source.
> >   Time: tsc clocksource has been installed.
> > 
> > The strange thing is that this is the same hardware as on other
> > machines. 
> 
> Aha! Yes but no. The BIOS makes a difference. The first BIOS that has
> support for the X2 processors on this particular motherboard works fine
> with regards to the acpi_pm clock source, subsequent ones make linux say
> things like:
>   PM-Timer running at invalid rate: 2159% of normal - aborting.
> and then tsc is selected as the clock source...

So you're saying the newer BIOS detects the PM timer as running too fast
or is it the older ones?

thanks
-john


