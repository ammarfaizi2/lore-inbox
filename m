Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRCIT4E>; Fri, 9 Mar 2001 14:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130644AbRCITzx>; Fri, 9 Mar 2001 14:55:53 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15354 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130636AbRCITzg>; Fri, 9 Mar 2001 14:55:36 -0500
Date: Sat, 10 Mar 2001 00:02:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010309204243.E13320@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.33.0103100001200.2283-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Jamie Lokier wrote:
> Rik van Riel wrote:
> > > > Of course. Now we just need the code to determine when a task
> > > > is holding some kernel-side lock  ;)
> > >
> > > couldn't it just be indicated on actual locking the resource?
> >
> > It could, but I doubt we would want this overhead on the locking...
>
> Just raise the priority whenever the task's in kernel mode.  Problem solved.

Remember that a task schedules itself out at the timer interrupt,
in kernel/sched.c::schedule() ... which is kernel mode ;)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

