Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbTIEPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTIEPq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:46:59 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:42737 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263123AbTIEPqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:46:03 -0400
Subject: Re: 2.6.0-test4-mm5
From: Martin Schlemmer <azarah@gentoo.org>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Nick Piggin <piggin@cyberone.com.au>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904202319.7f9947c9.diegocg@teleline.es>
References: <20030902231812.03fae13f.akpm@osdl.org>
	 <20030904010852.095e7545.diegocg@teleline.es>
	 <3F569641.9090905@cyberone.com.au>
	 <20030904202319.7f9947c9.diegocg@teleline.es>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1062776174.3376.26.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 17:36:15 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 20:23, Diego Calleja García wrote:
> El Thu, 04 Sep 2003 11:32:49 +1000 Nick Piggin <piggin@cyberone.com.au> escribió:
> 
> > Hmm... what's heavy gcc load?
> 
> make -j25 with 256 MB RAM.
> 
> My X server is reniced at -1; but reniced X to -10 and it didn't helped;
> -j15 was better (less swapping) but still I saw various mp3 & mouse skips.
> -

Without trying to be insulting, don't you think that you might
be expecting too much ?  I have a P4-2.4C (HT) on a i785 board
with 1GB DDR400 memory running dual channel, and if I run two
or three compile jobs at -j12 (more for testing Nick/Con's stuff,
usually use -j[46] and never really more than 2 of 3 of them), I
do not expect everything to be blazing fast.  Yes, while it is
not swapping (rare if ever do swap), I do expect xmms not to
skip, I do not expect the mouse to jerk, and yes I do expect
changing desktops to be fairly smooth and responsive.  I do not
however expect apps to still start with the same speed, or doing
the "window wiggle thing" to still be 100% smooth.

Nick's stuff with X reniced to -10 do fix the "window wiggle"
issue as far as I am concerned, as it is relative smooth (not
croaking like in vanilla), although not 100% as great as Con's,
but then Nick's finish the two make jobs at -j12 faster than
Con's stuff, and fairly close to vanilla (yes not 100% scientific),
and that is what I expect, even though it is a fairly ok machine.

Point I want to make, is that yes, for desktop you want you xmms
to not skip, you window switching to be ok while compiling a new
kernel at make -j[246], but come on, this is like expecting a
mini to out drag a F1 car because you fitted it with a turbo.
Especially when you start to swap heavily, you cannot really
expect the system to be responsive, especially when it is something
that needs to access memory that is swapped, or need to come out
of free swap, or that need to access the disk.

Con/Nick do need feedback, but really, expecting the scheduler to
be nice while your disk/memory is thrashing and whatever also need
a slice of that pie.  Can we try to keep it real ?


Thanks,

-- 
Martin Schlemmer


