Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272703AbTG1HIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272704AbTG1HIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:08:31 -0400
Received: from pop.gmx.de ([213.165.64.20]:41353 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272703AbTG1HIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:08:25 -0400
Message-Id: <5.2.1.1.2.20030728091801.01b83538@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 28 Jul 2003 09:27:49 +0200
To: Andre Hedrick <andre@linux-ide.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307272338160.30891-100000@master.linux-ide
 .org>
References: <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:45 PM 7/27/2003 -0700, Andre Hedrick wrote:

>On Mon, 28 Jul 2003, Mike Galbraith wrote:
>
> > At 09:18 PM 7/27/2003 +0200, Felipe Alfaro Solana wrote:
> > >On Sun, 2003-07-27 at 15:40, Ingo Molnar wrote:
> > > > my latest scheduler patchset can be found at:
> > > >
> > > >       redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6
> > > >
> > > > this version takes a shot at more scheduling fairness - i'd be 
> interested
> > > > how it works out for others.
> > >
> > >This -G6 patch is fantastic, even without nicing the X server. I didn't
> > >even need to tweak any kernel scheduler knob to adjust for maximum
> > >smoothness on my desktop. Response times are impressive, even under
> > >heavy load. Great!
> >
> > Can you try the following please?
> >
> > This one I just noticed:
> > 1.  start top.
> > 2.  start dd if=/dev/zero | dd of=/dev/null
> > 3.  wiggle a window very briefly.
> > Here, X becomes extremely jerky, and I think this is due to two
> > things.  One, X uses it's sleep_avg very quickly, and expires.  Two, the
> > piped dd now is highly interactive due to the ns resolution clock (uhoh).
>
>What kind of LAME test is this?  If "X becomes extremely jerky" ?

Huh?  The point is that piped cpu hogs just became high priority.

>Sheesh, somebody come up with a build class solution.
>
>CONFIG_SERVER
>CONFIG_WORKSTATION
>CONGIG_IAMAGEEKWHOPLAYSGAMES
>CONFIG_GENERIC_LAMER
>
>Determining quality of the scheduler based on how a mouse responds is ...
>
>Sorry but this is just laughable, emperical subjective determination
>based on a random hardware combinations for QA/QC for a test?
>
>Don't bother replying cause last thing I want to know is why.

Oh, I see, you just felt like doing some mindless flaming.

         -Mike 

