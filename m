Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVBBOOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVBBOOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVBBONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:13:37 -0500
Received: from gprs215-137.eurotel.cz ([160.218.215.137]:5301 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262674AbVBBONZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:13:25 -0500
Date: Wed, 2 Feb 2005 15:11:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050202141105.GA1316@elf.ucw.cz>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201230357.GH14274@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > > > I used your config advices from second mail, still it does not work as
> > > > expected: system gets "too sleepy". Like it takes a nap during boot
> > > > after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
> > > > needed to make it continue boot. Then cursor stops blinking and
> > > > machine is hung at random intervals during use, key is enough to awake
> > > > it.
> > > 
> > > Hmmm, that sounds like the local APIC does not wake up the PIT
> > > interrupt properly after sleep. Hitting the keys causes the timer
> > > interrupt to get called, and that explains why it keeps running. But
> > > the timer ticks are not happening as they should for some reason.
> > > This should not happen (tm)...
> > 
> > :-). Any ideas how to debug it? Previous version of patch seemed to work better...
> 
> I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
> local APIC timer is working.

I turned off CONFIG_PREEMPT, but nothing changed :-(.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
