Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbULNWLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbULNWLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULNWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:09:14 -0500
Received: from gprs214-149.eurotel.cz ([160.218.214.149]:35456 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261712AbULNWHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:07:13 -0500
Date: Tue, 14 Dec 2004 23:06:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214220646.GC19218@elf.ucw.cz>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz> <20041214013924.GB14617@atomide.com> <20041214093735.GA1063@elf.ucw.cz> <20041214211814.GA31226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214211814.GA31226@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The patch in question is at:
> > > 
> > > http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18
> > 
> > Wow, that's basically 8 lines of code plus driver for new
> > hardware... Is it really that simple?
> 
> Yeah, the key things are reprogramming the timer in the idle loop
> based on next_timer_interrupt(), and calling timer_interrupt from
> other interrupts as well :)
> 
> Should we try a similar patch for x86/amd64? I'm not sure which timers
> to use though? One should be programmable length for the interrupt, 
> and the other continuous for the timekeeping.

Yes, it would certainly be interesting. 5% power savings, and no
singing capacitors, while keeping HZ=1000. Sounds good to me.

There are about 1000 timers available in PC, each having its own
quirks. CMOS clock should be able to generate 1024Hz periodic timer
(we currently do not use) and TSC we currently use for periodic timer
should be usable in single-shot mode.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
