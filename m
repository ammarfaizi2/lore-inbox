Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275208AbRIZODj>; Wed, 26 Sep 2001 10:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275207AbRIZODa>; Wed, 26 Sep 2001 10:03:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7942 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275203AbRIZODO>; Wed, 26 Sep 2001 10:03:14 -0400
Date: Wed, 26 Sep 2001 16:03:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Out of memory handling broken
Message-ID: <20010926160306.D7290@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010925003416.A151@bug.ucw.cz> <Pine.LNX.4.33L.0109251702540.26091-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109251702540.26091-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I need to allocate as much memory as possible (but not more).
> > Okay, so I use out_of_memory, right?
> 
> Nope, out_of_memory() is about virtual memory handling,
> not at all about physical memory.

Yes, so... What happens at physical memory exhaustion? System crash?

> > But, when I looked into out_of_memory... Of course its
> > wrong. out_of_memory() contains
> >
> >         if (nr_swap_pages > 0)
> >                 return 0;
> >
> > ...which is obviously wrong. It is well possible to have free
> > swap _and_ be out of memory -- eat_memory() loop gets system to
> > this state easily.
> 
> This is because you're using out_of_memory() for something
> it was never meant for.  ;)

Okay, okay. Is there any solution (in 2.4.10) in doing what I want to
do?

								Pavel
-- 
Causalities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
