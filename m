Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270691AbVBFItl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbVBFItl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbVBFItl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:49:41 -0500
Received: from gprs215-233.eurotel.cz ([160.218.215.233]:38801 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S270021AbVBFItc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:49:32 -0500
Date: Sun, 6 Feb 2005 09:41:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206084141.GA3192@elf.ucw.cz>
References: <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206035417.GB15853@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206035417.GB15853@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok, works slightly better: time no longer runs 2x too fast. When TSC
> > > is used, I get same behaviour  as before ("sleepy machine"). With
> > > "notsc", machine seems to work okay, but I still get 1000 timer
> > > interrupts a second.
> 
> ...
> 
> > 
> > Sounds like your system is not running with the dyn-tick... I'll try
> > to fix that TSC bug.
> 
> The following patch fixes TSC timer with dyn-tick, and local APIC
> timer on UP system with CONFIG_SMP.

Tried that and got same "sleepy machine" behaviour. But now I realized
that I have PREEMPT and CPUFREQ enabled; I'll try disabling them.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
