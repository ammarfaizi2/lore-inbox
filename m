Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271724AbTHMJlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271747AbTHMJlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:41:22 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:23739 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271724AbTHMJlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:41:20 -0400
Date: Wed, 13 Aug 2003 11:41:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mike Galbraith <efault@gmx.de>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
Message-ID: <20030813094106.GE247@elf.ucw.cz>
References: <5.2.1.1.2.20030810084805.01a0dfa8@pop.gmx.net> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <5.2.1.1.2.20030810084805.01a0dfa8@pop.gmx.net> <5.2.1.1.2.20030813081904.019e4608@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030813081904.019e4608@pop.gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> 2.   It's not useful for video (I see no difference between realtime
> >> >> component of video vs audio), and if the cpu restriction were opened 
> >up
> >> >> enough to become useful, you'd end up with ~pure SCHED_RR, which you 
> >can
> >> >no
> >> >> way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it
> >> >> might be useful, but I wonder how useful.
> >> >
> >> >Why shouldn't it be useful with video, is a frame processing burst 
> >longer
> >> >than
> >> >a time slice? The rule for when to and how to revert a SCHED_SOFTRR can 
> >be
> >> >changed.
> >>
> >> Everything I've seen says "you need at least a 300Mhz cpu to decode".  My
> >> little cpu is 500Mhz, so I'd have to make more than half of my total
> >> computational power available for SCHED_SOFTRR tasks for video decode in
> >> realtime to work.  Even on my single user box, I wouldn't want to have to
> >> fight for cpu because some random developer decided to use
> >> SCHED_SOFTRR.  If I make that much cpu available, someone will try to use
> >> it.  Personally, I think you should need authorization for even tiny
> >> amounts of cpu at this priority.
> >
> >What about only offering SCHED_SOFTRR to people logged in on console,
> >similar to way cdrom and /dev/dsp is handled on newer boxes?
> 
> I'm always logged in on console, so with no authorization required, it'd 
> always be available to every task I start.

Which is pretty much okay. Remember that UID (not PID) is security
barier. If one of your processes is able to do X, all other processes
running under your PID are able to do X, too. (Modulo processes with
few differend PIDs, its more complicated then.)

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
