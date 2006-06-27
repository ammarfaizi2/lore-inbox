Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWF0WvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWF0WvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161336AbWF0WvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:51:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46778 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161338AbWF0WvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:51:23 -0400
Date: Wed, 28 Jun 2006 00:51:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm)
Message-ID: <20060627225105.GC8642@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <200606280039.06296.sebas@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606280039.06296.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-06-28 00:38:59, Sebastian Kügler wrote:
> On Wednesday 28 June 2006 00:22, Pavel Machek wrote:
> > > > uswsusp is a great idea, really.. I love it.. but suspend2 is here, it
> > > > works, it's stable and it's now. Why continue to deprive the mainstream
> > > > of these features because "uswsusp should".. as yet it doesn't.. and
> > > > when it does then we can phase out the currently stable, working
> > > > alternative that has all these features that uswsusp _will_ have, after
> > > > it's had them for a year or so and its been proven stable. Not only
> > > > that, I'll be happy to migrate over to it. Until then however, you can
> > > > pry suspend2.. cold, dead.. blah blah..
> > >
> > > Given the above explanation, it's obvious that I'm an outside watcher
> > > now, but if swsusp2 success rate is clearly higher than the standard
> > > version, then I'd also strongly advocate this direction since, quite
> > > frankly,
> >
> > I do not think suspend2 works on more machines than in-kernel
> > swsusp. Problems are in drivers, and drivers are shared.
> >
> > That means that if you have machine where suspend2 works and swsusp
> > does not, please tell me. I do not think there are many of them.
> 
> Maybe not machines, but definitely usage scenarios. I've tried both 
> implementations lately, and swsusp would often -- especially under high 
> memory load -- just return from trying, while suspend2 succeeds in freeing 
> enough memory to be able to suspend _every_ time. 

Refrigerator fixes should help with this one. Does it still happen in
2.6.17?

> Is that something uswsusp is likely to change anytime soon?

Actually this is common code for both swsusp and uswsusp; yes this
should be fixed.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
