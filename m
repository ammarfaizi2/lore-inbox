Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVASRoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVASRoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVASRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:44:20 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:57834 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261797AbVASRna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:43:30 -0500
Date: Wed, 19 Jan 2005 09:41:40 -0800
From: Tony Lindgren <tony@atomide.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119174140.GE14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <1106155850.6310.161.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106155850.6310.161.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [050119 09:31]:
> On Wed, 2005-01-19 at 09:11 -0800, Tony Lindgren wrote:
> > * Pavel Machek <pavel@suse.cz> [050119 03:32]:
> > > Hi!
> > > 
> > > > As this patch is related to the VST/High-Res timers, there
> > > > are probably various things that can be merged. I have not
> > > > yet looked at what all could be merged.
> > > > 
> > > > I'd appreciate some comments and testing!
> > > 
> > > Good news is that it does seem to reduce number of interrupts. Bad
> > > news is that time now runs faster (like "sleep 10" finishes in ~5
> > > seconds) and that I could not measure any difference in power
> > > consumption.
> > 
> > Thanks for trying it out. I have quite accurate time here on my
> > systems, and sleep works as it should. I wonder what's happening on
> > your system? If you have a chance, could you please post the results
> > from following simple tests?
> 
> tsc is dangerous for this btw; several cpus go either slower or stop tsc
> entirely during hlt... eg when idle.
> I would suggest to not include a tsc driver for this (otherwise really
> cool) feature.

Yeah, I just started with what was running on my old box :)
I'll make it a separate Kconfig option with notes on that. The TSC
timer is currently as accurate as without dyn-tick, but the ACPI PM
timer's accuracy suffers a bit for some reason.

Tony
