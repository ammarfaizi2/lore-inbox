Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131318AbRCHLSb>; Thu, 8 Mar 2001 06:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRCHLSW>; Thu, 8 Mar 2001 06:18:22 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:59787 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131318AbRCHLSF>; Thu, 8 Mar 2001 06:18:05 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <3AA76A53.CEC1B234@i.am>
Date: Thu, 8 Mar 2001 11:17:39 GMT
To: ludovic <ludovic.fernandez@sun.com>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <3AA6A97A.1EDE6A0B@sun.com>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac19-RTL3.11b i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ludovic wrote:
> 
> Oswald Buddenhagen wrote:
> >
> > > The problem with these things it that sometimes such a task may hold
> > > a lock, which can prevent higher-priority tasks from running.
> > >
> > true ... three ideas:
> > - a sort of temporary priority elevation (the opposite of SCHED_YIELD)
> >   as long as the process holds some lock
> > - automatically schedule the task, if some higher-priorized task wants
> >   the lock
> > - preventing the processes from aquiring locks at all (obviously this
> >   is not possible for required locks inside the kernel, but i don't
> >   know enough about this)
> >
> > > A solution would be to make sure that these tasks get at least one
> > > time slice every 3 seconds or so, so they can release any locks
> > > they might be holding and the system as a whole won't livelock.
> > >
> > did "these" apply only to the tasks, that actually hold a lock?
> > if not, then i don't like this idea, as it gives the processes
> > time for the only reason, that it _might_ hold a lock. this basically
> > undermines the idea of static classes. in this case, we could actually
> > just make the "nice" scale incredibly large and possibly nonlinear,
> > as mark suggested.
> >
> 
> Since the linux kernel is not preemptive, the problem is a little
> bit more complicated; A low priority kernel thread won't lose the
> CPU while holding a lock except if it wants to. That simplifies the
> locking problem you mention but the idea of background low priority
> threads that run when the machine is really idle is also not this
> simple.

You seem to have a sence for black humor right :) ?
As this is purely a complete nonsence 
- you were talking about M$Win3.11 right ?
(are you really the employ of Sun ??)

