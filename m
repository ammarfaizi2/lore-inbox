Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUK0RXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUK0RXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUK0RWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:22:02 -0500
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:54401 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261269AbUK0RTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:19:44 -0500
Date: Sat, 27 Nov 2004 18:18:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041127171825.GA1330@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams> <20041125183332.GJ1417@openzaurus.ucw.cz> <1101420616.27250.65.camel@desktop.cunninghams> <20041125223610.GC2711@elf.ucw.cz> <1101422986.27250.106.camel@desktop.cunninghams> <20041125232519.GI2711@elf.ucw.cz> <1101426572.27250.151.camel@desktop.cunninghams> <20041126000502.GK2711@elf.ucw.cz> <1101427927.27250.182.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101427927.27250.182.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > Silently doing nothing when user asked for sync is not nice,
> > > > > > either. BUG() is better solution than that.
> > > > > 
> > > > > I don't think we should BUG because the user presses Sys-Rq S while
> > > > > suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
> > > > > when suspending. Sound reasonable?
> > > > 
> > > > Yes, that's better. ... only that it means just another hook somewhere
> > > > :-(.
> > > 
> > > :<. But we're only talking two or three lines. Let's keep it in
> > > perspective.
> > 
> > I think even three lines are bad. It means that swsusp is no longer
> > self-contained subsystem, but that it has its hooks all over the
> > place. And those hooks need to be maintained, too.
> 
> Yes, but suspending can't practically be a self contained system. We can
> try to convince ourselves that we're making it self contained by hiding
> behind the driver model, but in reality, the driver model is just a nice
> name for our sticky little fingers in all the other drivers, ensuring
> they do the right thing when we want to go to sleep. Hooks in other code
> is just the equivalent, but without the nice name. Perhaps I should
> invent one. How about the "quiescing subsystem"? :>

Actually, "quiescing subsystem" with defined (and documented!)
interface might be an improvement ;-).
								Pavel 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
