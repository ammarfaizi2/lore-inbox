Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUK0F25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUK0F25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUK0DzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262514AbUKZTda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:30 -0500
Date: Fri, 26 Nov 2004 01:05:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041126000502.GK2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams> <20041125183332.GJ1417@openzaurus.ucw.cz> <1101420616.27250.65.camel@desktop.cunninghams> <20041125223610.GC2711@elf.ucw.cz> <1101422986.27250.106.camel@desktop.cunninghams> <20041125232519.GI2711@elf.ucw.cz> <1101426572.27250.151.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101426572.27250.151.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Silently doing nothing when user asked for sync is not nice,
> > > > either. BUG() is better solution than that.
> > > 
> > > I don't think we should BUG because the user presses Sys-Rq S while
> > > suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
> > > when suspending. Sound reasonable?
> > 
> > Yes, that's better. ... only that it means just another hook somewhere
> > :-(.
> 
> :<. But we're only talking two or three lines. Let's keep it in
> perspective.

I think even three lines are bad. It means that swsusp is no longer
self-contained subsystem, but that it has its hooks all over the
place. And those hooks need to be maintained, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
