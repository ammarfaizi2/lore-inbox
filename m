Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTLZXWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbTLZXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:22:43 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:47232 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265258AbTLZXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:22:40 -0500
Date: Sat, 27 Dec 2003 00:03:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Message-ID: <20031226230300.GF197@elf.ucw.cz>
References: <200312231138.21734.kernel@kolivas.org> <3FE7AF24.40600@cyberone.com.au> <200312231415.38611.kernel@kolivas.org> <200312231416.58998.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312231416.58998.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >>>I discussed this with Ingo and that's the sort of thing we thought of.
> > > >>>Perhaps a relative crossover of 10 dynamic priorities and an absolute
> > > >>>crossover of 5 static priorities before things got queued together.
> > > >>> This is really only required for the UP HT case.
> > > >>
> > > >>Well I guess it would still be nice for "SMP HT" as well. Hopefully the
> > > >>code can be generic enough that it would just carry over nicely.
> > > >
> > > >I disagree. I can't think of a real world scenario where 2+ physical
> > > > cpus would benefit from this.
> > >
> > > Well its the same problem. A nice -20 process can still lose 40-55% of
> > > its performance to a nice 19 process, a figure of 10% is probably too
> > > high and we'd really want it <= 5% like what happens with a single
> > > logical processor.
> >
> > I changed my mind just after I sent that mail. 4 physical cores running
> > three nice 20 and one nice -20 task gives the nice -20 task only 25% of the
> > total cpu and 25% to each of the nice 20 tasks.
> 
> Err that should read 4 logical cores.

Actually, for 4 physical cores it is going to be true, too. And if you
are memory-bound, stopping those 3 task can speed your important
task, too. Its really same.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
