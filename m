Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270576AbRHNLxV>; Tue, 14 Aug 2001 07:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRHNLwg>; Tue, 14 Aug 2001 07:52:36 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:6404 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270581AbRHNLwN>; Tue, 14 Aug 2001 07:52:13 -0400
Date: Sat, 11 Aug 2001 12:06:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Black <mblack@csihq.com>, tridge@valinux.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.8preX VM problems
Message-ID: <20010811120604.C35@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva> <20010801105419.8F078424A@lists.samba.org> <020001c11a803297110@csihq.com> <01080120392200.00933@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01080120392200.00933@starship>; from phillips@bonn-fries.net on Wed, Aug 01, 2001 at 08:39:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have come to the opinion that kswapd needs to be a little smarter
> > -- if it doesn't find anything to swap shouldn't it go to sleep a
> > little longer before trying again?  That way it could gracefully
> > degrade itself when it's not making any progress.
> >
> > In my testing (on a dual 1Ghz/2G machine) the machine "locks up" for
> > long periods of time while kswapd runs around trying to do it's
> > thing. If I could disable kswapd I would just to test this.
> 
> Your wish is my command.  This patch provides a crude-but-effective 
> method of disabling kswapd, using:
> 
>   echo 1 >/proc/sys/kernel/disable_kswapd
> 
> I tested this with dbench and found it runs about half as fast, but 
> runs.  This is reassuring because kswapd is supposed to be doing 
> something useful.

Why not just killall -STOP kswapd?

What is expected state of system without kswapd, BTW? Without kflushd, 
I give up guaranteed time to get data safely to disk [and its usefull
for spindown]. What happens without kswapd?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

