Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbULMUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbULMUxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbULMUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:50:38 -0500
Received: from gprs215-194.eurotel.cz ([160.218.215.194]:12161 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261156AbULMUt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:49:56 -0500
Date: Mon, 13 Dec 2004 21:49:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213204933.GA4693@elf.ucw.cz>
References: <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102970039.1281.415.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > But that does not matter, right? Yes, one-shot timer will not fire
> > > > exactly at right place, but as long as you are reading TSC and basing
> > > > next shot on current time, error should not accumulate.
> > > 
> > > As said in the rest of the message, the error (or some other error)
> > > accumulates heavily today in the tick-loss compensation/adjustment
> > > algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> > > about
> > 
> > I do not see how it should accumulate. Lets have working TSC. You want
> > to emulate fixed-period timer with single-shot timer.
> 
> Its caused by the fact that we don't use the the TSC to accumulate time.
> We are instead interpolating between timer ticks and the TSC, where

Yes, it was supposed to be simple, so that Andrea understands that
there's nothing inherently broken with single-shot timers.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
