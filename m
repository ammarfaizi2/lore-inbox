Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbTICRtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTICRtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:49:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5844 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263860AbTICRtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:49:05 -0400
Date: Wed, 3 Sep 2003 19:49:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030903174904.GH30629@atrey.karlin.mff.cuni.cz>
References: <20030902094701.GD145@elf.ucw.cz> <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -void software_resume(void)
> > +int __init swsusp_restore(void)
> >  {
> > -       if (num_online_cpus() > 1) {
> > -               printk(KERN_WARNING "Software Suspend has
> > malfunctioning SMP support. Disabled :(\n");
> > -               return;
> > -       }
> > 
> > I can not easily see where you moved this check.
> 
> Read the rest of the patches, and the changelogs (I do believe it's in 
> them). It's in kernel/power/main.c::enter_state(), so all PM handlers can 
> use it. 

Notice that this is done during resume. You are free to suspend with 1
cpu, then attempt to resume with 2 cpus. Not *too* likely to happen,
but....
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
