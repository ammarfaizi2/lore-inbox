Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUHFWiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUHFWiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268318AbUHFWiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:38:02 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:18817 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268316AbUHFWhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:37:50 -0400
Date: Sat, 7 Aug 2004 00:37:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@linuxmail.org, David Brownell <david-b@pacbell.net>,
       Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806223731.GN30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston> <200408031928.08475.david-b@pacbell.net> <1091586381.3189.14.camel@laptop.cunninghams> <1091587985.5226.74.camel@gaston> <1091587929.3303.38.camel@laptop.cunninghams> <1091592870.5226.80.camel@gaston> <20040806212909.GI30518@elf.ucw.cz> <1091831227.9271.254.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091831227.9271.254.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Very easy... with the current code, just use state 4 for the round
> > > of suspend callbacks, ide-disk will then avoid spinning down.
> > 
> > There are some network drivers that test for "4" and fails suspend
> > with something like "invalid suspend state" :-(.
> 
> Easily fixed. Again, i'm not afraid of fixing driver, few enough of
> them care at all at this point. I'll send some patches this week-end
> to patrick for his bk tree adding the basic ppc support and renumbering
> the PM callbacks, I havne't changed the type yet though, that's a more
> tedious work and I'm a lazy guy ;)

Well, changing "int" to "enum something" as you go might serve you as
"I've already fixed this one" marker ;-). And as it does not even
create a warning, it might be feasible to do incrementally...

Or even typedef suspend_state_t u32...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
