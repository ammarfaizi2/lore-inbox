Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTKQVLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKQVLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:11:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:61842
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261807AbTKQVLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:11:40 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Patrick's Test9 suspend code.
Date: Mon, 17 Nov 2003 15:11:32 -0600
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0311170844230.12994-100000@cherise>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311171511.32908.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You live!

Cool. :)

On Monday 17 November 2003 10:45, Patrick Mochel wrote:
> > Currently, patrick's code isn't working for me anymore either.  I think
> > it's because I haven't figured out how I had ACPI set up last time
> > (performance covernor, probably.  If I tell it to use the userspace
> > governor, there's still nothing in /sys/devices/system/cpu/cpu0, the
> > directory is empty.  Maybe the documentation isn't up to date anymore, I
> > don't know...)  When I tried to suspend with it, it sort of worked but
> > the writing to disk phase (which never caused a problem before) had a
> > visible pause between each sector written, and writing out the 3000
> > sectors took over 5 minutes, and the end result wasn't something it could
> > resume from anyway.  Sigh...
>
> Are you using preempt? There was a similar problem reported a while back
> that was solved by disabling it. Though it's not a true fix, it should at
> least get you going again.

That might explain some stuff.  I'm now getting messages from my orinoco card 
during the writing phase about negotiating to talk with the access point, 
which is interfering with the writing of the dots.  That didn't happen 
before.

Might it also be possible to just invent a new spinlock, grab it at the start 
of suspend, and release it at the end of resume?  (It's not like suspend 
really needs to be preempted.  I vaguely remember a "disable_preempt" call, 
but haven't a clue what it or its semantics might actually be.)

I have an appointment in half an hour but I'll give it a shot this evening. 

Thanks.

> Thanks,
>
>
> 	Pat

Rob
