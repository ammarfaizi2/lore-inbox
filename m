Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWAEBu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWAEBu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWAEBu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:50:27 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:48058 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751166AbWAEBu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:50:26 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 4 Jan 2006 17:50:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060105015010.GG4286@atomide.com>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com> <1136406837.2839.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136406837.2839.67.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [060104 12:34]:
> On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
> > On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
> >  > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
> >  >  >  +2.6.15-dynticks-060101.patch
> >  >  >  +dynticks-disable_smp_config.patch
> >  >  > Latest version of the dynticks patch. This is proving stable and effective on 
> >  >  > virtually all uniprocessor machines and will benefit systems that desire 
> >  >  > power savings. SMP kernels (even on UP machines) still misbehave so this 
> >  >  > config option is not available by default for this stable kernel.
> >  > 
> >  > I've been curious for some time if this would actually show any measurable
> >  > power savings. So I hooked up my laptop to a gizmo[1] that shows how much
> >  > power is being sucked.
> >  > 
> >  > both before, and after, it shows my laptop when idle is pulling 21W.
> >  > So either the savings here are <1W (My device can't measure more accurately
> >  > than a single watt), or this isn't actually buying us anything at all, or
> >  > something needs tuning.
> > 
> > Ah interesting. It needs to be totally idle for a period of time before
> > anything starts to happen at all. After about a minute of doing nothing,
> > it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22 etc..
> 
> 
> sounds like we need some sort of profiler or benchmarker or at least a
> tool that helps finding out which timers are regularly firing, with the
> aim at either grouping them or trying to reduce their disturbance in
> some form.

Take a look at timertop for that.

Tony
