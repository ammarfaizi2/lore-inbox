Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTGMTOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270351AbTGMTOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:14:49 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:63441 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270350AbTGMTOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:14:47 -0400
Date: Sun, 13 Jul 2003 21:29:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713192919.GC570@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <200307140207.47711.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307140207.47711.mflt1@micrologica.com.hk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > - user can abort at any time during suspend (oh, I forgot, I wanted
> > > > > to...) by just pressing Escape
> > > >
> > > > That seems like missfeature. We don't want joe random user that is at
> > > > the console to prevent suspend by just pressing Escape. Maybe magic
> > > > key to do that would be acceptable...
> 
> Dumb question applicable to 9x% of computers: how do you secure the suspend 
> switch and OFF switch, not to mention the power plug or the battery?
> 
> As to security many portables have a bios password and no other passwords 
> thereafter for the user account. The abort feature events could be enabled 
> via swsusp proc entry mainly for (desktop) security. Also, then you ought 
> to think about securing suspend events (don't swsusp the webserver
> please)!

Only root can write to /proc/acpi/sleep, so there's no problem.

And having config variable just for escape during suspend is ugly.

> In practice, when suspending, in many cases one would like to abort. Suspend 
> should be abortable by ESC and post 1.0: the lid switch and/or suspend switch. 
> If you think about it it makes sense to abort suspend instead of having 
> to wait 15-40 seconds and reenter the bios password and wait another 10-30 
> seconds. (assuming 2.4 speeds)
> 
> The way I would use S3/S4 is reboot only for a new kernel, and really use the 
> machine portably much more. S3 would be used for short suspends and S4 for 
> longer suspends.
> 
> In short, this is an _important_ feature _as_ much as S3 and S4.

If you say that aborting with Esc is as important as having swsusp in
the first place... that's not true.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
