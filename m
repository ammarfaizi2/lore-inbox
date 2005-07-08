Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVGHHC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVGHHC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGHHC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:02:27 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36502 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261542AbVGHHC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:02:26 -0400
Date: Fri, 8 Jul 2005 03:02:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <20050707164831.GA25696@elte.hu>
Message-ID: <Pine.LNX.4.58.0507080242560.8133@localhost.localdomain>
References: <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu>
 <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu>
 <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu>
 <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain>
 <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707164831.GA25696@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Jul 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > It did the trick.  I got a network. But I also got a hell of a lot of
> > 'enqueued dead tasks'. But stupid me forgot to turn on capture in
> > minicom, and haven't been able to reproduce the problem. I rebooted
> > the machine which blew away all evidence of what occured, and it's now
> > fine. I'll reboot a few more times to see if I can get it to break
> > again.
>
> minicom has a scrollback feature (Alt-B), does that have the oops in
> history perhaps? It can cache a couple of bootups typically.
>

Is there also a scrollback for after you log out of minicom and turn off
the machine ;-)

Thanks, I didn't know about that feature of minicom. I should really start
reading the fine manuals.  Unfortunately, the minicom was on my laptop
which I turned off yesterday and only today did I see your note.

To try and reproduce it again, I've added in /etc/rc3.d an S98reboot that
will switch the system to runlevel 6 again, and repeat the process over
and over. All this while connect to minicom and capturing.  Hopefully it
will eventually show the same bug.  If not, maybe it was just a fluke.

-- Steve
