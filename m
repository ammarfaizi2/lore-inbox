Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVBFSfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVBFSfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFSfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:35:37 -0500
Received: from gprs215-170.eurotel.cz ([160.218.215.170]:13034 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261272AbVBFSfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:35:08 -0500
Date: Sun, 6 Feb 2005 19:34:30 +0100
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
Message-ID: <20050206183430.GB1139@elf.ucw.cz>
References: <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206081137.GA994@elf.ucw.cz> <20050206171041.GC13936@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206171041.GC13936@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Ok, works slightly better: time no longer runs 2x too fast. When TSC
> > > > is used, I get same behaviour  as before ("sleepy machine"). With
> > > > "notsc", machine seems to work okay, but I still get 1000 timer
> > > > interrupts a second.
> > > 
> > > Sounds like dyn-tick did not get enabled then, maybe you don't have
> > > CONFIG_X86_PM_TIMER, or don't have ACPI PM timer on your board?
> > 
> > I do have CONFIG_X86_PM_TIMER enabled, but it seems by board does not
> > have such piece of hardware:
> > 
> > pavel@amd:/usr/src/linux-mm$ dmesg | grep -i "time\|tick\|apic"
> > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > pavel@amd:/usr/src/linux-mm$ 
> > 
> > [Strange, I should see some messages about apic, no?]
> 
> Yeah, looks like you don't have a local APIC then? Let me test the
> patch here with just PIT timer only.
> 
> It also looks like you don't have TSC either? Or do you still have
> notsc cmdline option?

It definitely does have TSC, it is athlon64. It was probably disabled
in this particular run.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
