Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVDHKzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVDHKzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVDHKzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:55:02 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:29387 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262705AbVDHKy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:54:56 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 8 Apr 2005 03:54:13 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050408105411.GH4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <20050408102854.GB1392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408102854.GB1392@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050408 03:30]:
> Hi!
> 
> > > I think I have an idea on what's going on; Your system does not wake to
> > > APIC interrupt, and the system timer updates time only on other interrupts.
> > > I'm experiencing the same on a loaner ThinkPad T30.
> > > 
> > > I'll try to do another patch today. Meanwhile it now should work
> > > without lapic in cmdline.
> > 
> > Following is an updated patch. Anybody having trouble, please try
> > disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
> > 
> > I'm hoping this might work on Pavel's machine too?
> 
> The "volume hang" was explained: I was using CPU frequency scaling, it
> probably did not like that. After disabling CPU frequency scaling, it
> seems to work ok:

OK, good. I assume this was the same machine that did not work with
any of the earlier patches?

Tony
