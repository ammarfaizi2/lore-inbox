Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWAEB5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWAEB5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAEB5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:57:47 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:2486 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751176AbWAEB5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:57:47 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 4 Jan 2006 17:57:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Dave Jones <davej@redhat.com>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060105015731.GH4286@atomide.com>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com> <200601051010.54156.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051010.54156.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [060104 15:23]:
> On Thursday 05 January 2006 06:57, Dave Jones wrote:
> > On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
> >  > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
> >  >  >  +2.6.15-dynticks-060101.patch
> >  >  >  +dynticks-disable_smp_config.patch
> >  >  > Latest version of the dynticks patch. This is proving stable and
> >  >  > effective on virtually all uniprocessor machines and will benefit
> >  >  > systems that desire power savings. SMP kernels (even on UP machines)
> >  >  > still misbehave so this config option is not available by default for
> >  >  > this stable kernel.
> >  >
> >  > I've been curious for some time if this would actually show any
> >  > measurable power savings. So I hooked up my laptop to a gizmo[1] that
> >  > shows how much power is being sucked.
> >  >
> >  > both before, and after, it shows my laptop when idle is pulling 21W.
> >  > So either the savings here are <1W (My device can't measure more
> >  > accurately than a single watt), or this isn't actually buying us
> >  > anything at all, or something needs tuning.
> >
> > Ah interesting. It needs to be totally idle for a period of time before
> > anything starts to happen at all. After about a minute of doing nothing,
> > it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22
> > etc..
> >
> > Goes no lower than 18W, and only occasionally peaks above the old idle
> > power usage. Not bad at all.
> >
> > Causing any activity at all puts it back to the 'have to wait a while
> > for things to start happening' state again.
> 
> Thanks for testing it. Indeed skipping the ticks alone does not really save 
> any significant amount of power. The real chance for power savings comes from 
> using this period for smarter C state programming. The other thing as you've 
> noticed is that timers need to be curbed or minimised to get the maximum 
> benefit and the ondemand governor alone, which unfortunately shows up as 
> something not obvious in timertop, polls at 140HZ itself - fiddling with 
> ondemand/ settings in sys can drop this but slows the rate at which it 
> adapts.

Device specific power states will help with getting power savings too.

Tony
