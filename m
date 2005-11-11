Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVKKTUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVKKTUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVKKTUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:20:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50067 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751035AbVKKTUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:20:01 -0500
Date: Fri, 11 Nov 2005 20:18:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: sharpsl_pm: using milivolts instead of custom units?
Message-ID: <20051111191839.GA29471@elf.ucw.cz>
References: <20051111120300.GA29251@elf.ucw.cz> <1131712513.7794.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131712513.7794.7.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #ifdef CONFIG_SA1100_COLLIE
> > struct battery_thresh spitz_battery_levels_noac[] = {
> >         { 368, 100},
> >         { 358,  25},
> >         { 356,   5},
> >         {   0,   0},
> > ...
> > 
> > ...so it could get very confusing. Would it be feasible to convert to
> > mV as soon as possible and have all constants in milivolts? I realize
> > they may be slightly different for different models, but they should
> > at least be comparable.
> 
> The battery levels are totally different between the models and each is
> going to need a levels translation table as its an extremely none linear
> decay curve. Using ADC values here makes a lot of sense as that's as
> granular as the information ever gets and you don't start to lose
> accuracy anywhere with rounding.

Well, all the models have li-ion batteries, so levels (in milivolts)
for stuff like "battery empty" should be very similar. If conversion
from ADC to voltage is non-trivial, that's a show stopper I guess.

> I still think you've much bigger problems to worry about as this code is
> heavily PXA biased and is going to need a lot of changes to work on the
> SA1100. Its why I've put it in mach-pxa rather than common and a
> separate driver for collie based on this code might be easier.

Actually I think I can refactor in a way that a common core can be
share. I'd hate to copy 1000 lines...
								Pavel

-- 
Thanks, Sharp!
