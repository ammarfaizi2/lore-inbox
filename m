Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSEaTla>; Fri, 31 May 2002 15:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSEaTl3>; Fri, 31 May 2002 15:41:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316673AbSEaTl2>; Fri, 31 May 2002 15:41:28 -0400
Date: Fri, 31 May 2002 21:41:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Ian Collinson <icollinson@imerge.co.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020531194125.GK1172@dualathlon.random>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 11:28:47AM -0700, Mike Kravetz wrote:
> On Thu, May 30, 2002 at 06:54:46PM +0100, Ian Collinson wrote:
> > 
> > 	We're having problems with realtime scheduling (SCHED_RR and
> > SCHED_FIFO), on 2.4 kernels >= 2.4.10 (built for i386, no SMP).  We have an
> > app that uses real-time scheduled threads. To aid debugging, in case of
> > realtime threads spinning and locking the system, we always keep a bash
> > running on a (text) console, at SCHED_RR, priority 99 (a higher priority
> > than any threads in our app).  We test that this is a valid approach by
> > running a lower priority realtime app, on another console, that sits in an
> > infinite busy loop.  This has always worked, and we've been able to
> > successfully use the high-priority bash to run gdb, and so on.  This is also
> > what the man page for sched_setscheduler suggests, to avoid total system
> > lock up.
> 
> <snip>
> 
> > 	Then I switch back to the first console, with its priority 99 bash.
> > I am able to type away for 10 seconds, until the priority 50 process starts,
> > at which point the shell locks up.   I can get the same effect on one
> > console with:
> > 
> > 	> ( sleep 10; realtime -rr 50 eat_cpu ) & realtime -rr 99 bash
> > 
> > 	Previously, the high-priority shell would never lock up.  Now it
> > does.
> 
> This works fine for me on 2.4.17 with a SERIAL console.  Could this
> be related to some differences (new features) in the VGA console?
> I am totally ignorant of how the consoles work.

I tried it under uml on 2.4.19pre9aa2 and it worked fine there too.

Andrea
