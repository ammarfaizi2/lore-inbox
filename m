Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbUKZXyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbUKZXyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUKZTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:42:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262444AbUKZT1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:41 -0500
Date: Fri, 26 Nov 2004 00:25:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041125232519.GI2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams> <20041125183332.GJ1417@openzaurus.ucw.cz> <1101420616.27250.65.camel@desktop.cunninghams> <20041125223610.GC2711@elf.ucw.cz> <1101422986.27250.106.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101422986.27250.106.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Included in this patch is a new try_to_freeze() macro Andrew M suggested
> > > > > a while back. The refrigerator declarations are put in sched.h to save
> > > > > extra includes of suspend.h.
> > > > 
> > > > try_to_freeze looks nice. Could we get it in after 2.6.10 opens?
> > > 
> > > I'm hoping to get the whole thing in mm once all these replies are dealt
> > > with. Does that sound unrealistic?
> > 
> > Yes, a little ;-).
> 
> I'm not talking about talking about problems and then doing nothing :>
> I'm writing a list of changes as I look at each of these responses.
> Assuming they're all addressed (or not changed for good reasons), and
> the code is actually useful, why shouldn't it go into mm?

It has chance to go into mm, but I do not think all 51 patches will go
at once. And I expect few more rounds of patches / comments. (And then
some patch / "it is too big" flamewar, too :-).

> > Silently doing nothing when user asked for sync is not nice,
> > either. BUG() is better solution than that.
> 
> I don't think we should BUG because the user presses Sys-Rq S while
> suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
> when suspending. Sound reasonable?

Yes, that's better. ... only that it means just another hook somewhere
:-(.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
