Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRCITyc>; Fri, 9 Mar 2001 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRCITyX>; Fri, 9 Mar 2001 14:54:23 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23273 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130471AbRCITyN>;
	Fri, 9 Mar 2001 14:54:13 -0500
Date: Fri, 9 Mar 2001 23:58:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: george anzinger <george@mvista.com>
cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <3AA93124.EC22CC8A@mvista.com>
Message-ID: <Pine.LNX.4.33.0103092358010.2283-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, george anzinger wrote:
> Rik van Riel wrote:
> > On Thu, 8 Mar 2001, Boris Dragovic wrote:
> >
> > > > Of course. Now we just need the code to determine when a task
> > > > is holding some kernel-side lock  ;)
> > >
> > > couldn't it just be indicated on actual locking the resource?
> >
> > It could, but I doubt we would want this overhead on the locking...
>
> Seems like you are sneaking up on priority inherit mutexes.
> The locking over head is not so bad (same as spinlock, except in
> UP case, where it is the same as the SMP case).  The unlock is,
> however, the same as the lock overhead.  It is hard to beat the
> store of zero which is the spin_unlock.

Hmmm, what would this look like ?

(we need the same code if we want to do decent load
control for the VM, where we suspend tasks when the
load gets too high)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

