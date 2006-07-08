Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWGHNA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWGHNA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGHNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:00:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37022 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964807AbWGHNA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:00:28 -0400
Date: Sat, 8 Jul 2006 15:00:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sharpsl_pm refactor
Message-ID: <20060708130015.GB1762@elf.ucw.cz>
References: <20060707114818.GA5423@elf.ucw.cz> <1152274600.5548.67.camel@localhost.localdomain> <20060707140148.GB4239@ucw.cz> <1152285850.5548.102.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152285850.5548.102.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm unconvinced as to why collie needs an ifdef in there and looking at
> > > what I think you're leading to, its ugly. Perhaps you could change the 2
> > > to a variable set by the machine instead or something, depending upon
> > > your intention.
> > 
> > Well, I hate the if/else maze -- IMO returns are more readable. Anyway
> > collie needs both count and time checks disabled, AFAICT.
> 
> To me it looks much worse after you changed it as I can understand it at
> the moment and afterwards with the ifdefs in, I can't.

Well, maybe you'll not get the ifdefs after all... They were just
handy in my tree and code with returns (vs. code with if/else maze)
looked better to me.

> Ignoring that issue, why does collie need them disabled? Do they break
> collie somehow or is this just because the sharp driver didn't do
> it?

Sharp driver did not do it, and forcing charge 3 times when charger
tells me that it is done seems a bit cruel. What is worse, if I get
charge-too-fast timeout too long, it will keep charging battery
over-and-over-and-over-and-over. 

> I'd prefer to keep the charging techniques the same across as many of
> the devices as we can and I can't see how this technique causes a
> problem. The charging hardware and the battery is very similar across
> the models (although you wouldn't believe it looking at the charging
> driver).

Okay, you may be right here. I am just trying to be careful -- hot
lithium scares me a bit ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
