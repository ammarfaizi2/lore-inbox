Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262668AbSI1BMY>; Fri, 27 Sep 2002 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbSI1BMY>; Fri, 27 Sep 2002 21:12:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:30352 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262668AbSI1BMW>;
	Fri, 27 Sep 2002 21:12:22 -0400
Message-ID: <3D950329.848C85BE@digeo.com>
Date: Fri, 27 Sep 2002 18:17:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org, Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jordan Breeding <jordan.breeding@attbi.com>,
       Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: 2.5 Kernel Problem Reports as of 27 Sep
References: <Pine.LNX.4.44.0209271833280.12092-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 01:17:33.0350 (UTC) FILETIME=[D289DC60:01C2668C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> 
> This report can be accessed at
> http://members.cox.net/tmolina/kernprobs/020927-status.html
> 
> The latest update can always be accessed at
> http://members.cox.net/tmolina/kernprobs/status.html
> 
> I've changed the format somewhat for posting to lkml based on feedback and
> included comments and references.  I'm also cc'ing those mentioned
> requesting feedback.  Please let me know if this works.
> 
>   Problem Title                          Status             Discussion
> 
>    1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103166646702935&w=2
>    BUG at kernel/sched.c                  closed             15 Sep 2002
> 
>    2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103184045102066&w=2
>                                           closed             13 Sep 2002
> 
>    3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103220232808356&w=2
>                                           closed             18 Sep 2002
> ------------------------------------------------------------------------
>    4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170969316930&w=2
>    lockups under X                        open               21 Sep 2002

That's the tasklist_lock thing.  Should be fixed now.

>    5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103237870212293&w=2
>                                           additional reports 18 Sep 2002
> ------------------------------------------------------------------------
>    6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103260318814826&w=2
>    2.5.37 won't run X                     closed             23 Sep 2002
> ------------------------------------------------------------------------
>    7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170969316930&w=2
>    mouse locks up X                       open               11 Sep 2002

Duplicate of 4.

>    8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103274064128049&w=2
>                                           additional reports 23 Sep 2002

tasklist_lock again, probably.

>    9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170259412602&w=2
>    KVM/Mouse problem                      open               20 Sep 2002
> 
>   10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103299680529254&w=2
>    Mouse/keyboard problems                open               27 Sep 2002
> 
> Are any of the above problems related?  At least the last one appears to
> be related to the recent input layer changes.

Yes, mice and keyboards are flakey things; it'll take some time to
get everything working right I expect.  Mine are doing weird and
faintly irritating things wrt key rollover.

> ------------------------------------------------------------------------
>   11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103250741229189&w=2
>    AIC7XXX boot failure                   open               20 Sep 2002
> 
> This was reported by Lukasz Trabinski <lukasz@wsisiz.edu.pl>, but never
> responded to, and was never followed up. Should this be kept open?
> ------------------------------------------------------------------------
>   12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103238248416900&w=2
>    Dead loop on virtual device lo         open               18 Sep 2002
> 
> This was reported by Marc-Christian Petersen <m.c.p@wolk-project.de>, but
> never responded to, and was never followed up.  Should this be kept open?
> ------------------------------------------------------------------------
> 
>   13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103241914811779&w=2
>    nmi_watchdog problem                   open               19 Sep 2002
> 
> This was reported by Jordan Breeding <jordan.breeding@attbi.com>, but
> never responded to, and was never followed up.  Should this be kept open?

Ingo submitted a patch since then which fixed nmi_watchdog (although
I haven't tested it - I switched to nmi_watchdog=2 when it broke ;))

So "probably fixed"

> ...
> 
>   27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103278825525479&w=2
>    Oops in 2.5.38-mm2                     open               23 Sep 2002
> 
> Andrew Morton <akpm@digeo.com> says this is not an oops, it's a warning.
> Should this be kept open?
> ------------------------------------------------------------------------
>   28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282505101823&w=2
>    oops in vsnprintf (2.5-bk)             open               23 Sep 2002
>
>   29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103055061028368&w=2
>    loadlin boot failure                   open               27 Sep 2002
> 
>   30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2
>    semaphore.c calls sleeping function    open               23 Sep 2002

This one's odd, and I think Bill makes them up to taunt me.
 
>   31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296031616858&w=2
>    2.5.38-mm2 aha152x module fails        open               25 Sep 2002
> 
>   32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296919327682&w=2
>    oops with kernel LLC                   open               25 Sep 2002
> 
>   33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103315199307542&w=2
>    loop trying to go beyond end of device open               27 Sep 2002
