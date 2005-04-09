Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVDNNAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDNNAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDNNAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:00:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5015 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261493AbVDNNAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:00:37 -0400
Date: Sat, 9 Apr 2005 11:56:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050409095608.GA5158@openzaurus.ucw.cz>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <20050408102854.GB1392@elf.ucw.cz> <20050408105411.GH4477@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408105411.GH4477@atomide.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I think I have an idea on what's going on; Your system does not wake to
> > > > APIC interrupt, and the system timer updates time only on other interrupts.
> > > > I'm experiencing the same on a loaner ThinkPad T30.
> > > > 
> > > > I'll try to do another patch today. Meanwhile it now should work
> > > > without lapic in cmdline.
> > > 
> > > Following is an updated patch. Anybody having trouble, please try
> > > disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
> > > 
> > > I'm hoping this might work on Pavel's machine too?
> > 
> > The "volume hang" was explained: I was using CPU frequency scaling, it
> > probably did not like that. After disabling CPU frequency scaling, it
> > seems to work ok:
> 
> OK, good. I assume this was the same machine that did not work with
> any of the earlier patches

I did testing on that machine today, and yes it works okay if I disable the
NO_IDLE_HZ_USE_APIC (or how is it called) option. Time problems are gone.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

