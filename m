Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUK0HCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUK0HCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUK0HAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:00:16 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41881 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261184AbUKZTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:02:44 -0500
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041126000502.GK2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296026.5805.275.camel@desktop.cunninghams>
	 <20041125183332.GJ1417@openzaurus.ucw.cz>
	 <1101420616.27250.65.camel@desktop.cunninghams>
	 <20041125223610.GC2711@elf.ucw.cz>
	 <1101422986.27250.106.camel@desktop.cunninghams>
	 <20041125232519.GI2711@elf.ucw.cz>
	 <1101426572.27250.151.camel@desktop.cunninghams>
	 <20041126000502.GK2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101427927.27250.182.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 11:12:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 11:05, Pavel Machek wrote:
> Hi!
> 
> > > > > Silently doing nothing when user asked for sync is not nice,
> > > > > either. BUG() is better solution than that.
> > > > 
> > > > I don't think we should BUG because the user presses Sys-Rq S while
> > > > suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
> > > > when suspending. Sound reasonable?
> > > 
> > > Yes, that's better. ... only that it means just another hook somewhere
> > > :-(.
> > 
> > :<. But we're only talking two or three lines. Let's keep it in
> > perspective.
> 
> I think even three lines are bad. It means that swsusp is no longer
> self-contained subsystem, but that it has its hooks all over the
> place. And those hooks need to be maintained, too.

Yes, but suspending can't practically be a self contained system. We can
try to convince ourselves that we're making it self contained by hiding
behind the driver model, but in reality, the driver model is just a nice
name for our sticky little fingers in all the other drivers, ensuring
they do the right thing when we want to go to sleep. Hooks in other code
is just the equivalent, but without the nice name. Perhaps I should
invent one. How about the "quiescing subsystem"? :>
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

