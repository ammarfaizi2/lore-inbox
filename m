Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289378AbSAODJB>; Mon, 14 Jan 2002 22:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSAODIw>; Mon, 14 Jan 2002 22:08:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41715 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289370AbSAODIr>; Mon, 14 Jan 2002 22:08:47 -0500
Message-ID: <3C439D02.EBCD78C4@mvista.com>
Date: Mon, 14 Jan 2002 19:07:46 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com> <E16QC5P-0000nO-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> > UNIX generally tries to ensure liveness. So you know that
> >       cat lkarchive | grep feel | wc
> > will complete and not just that, it will run pretty reasonably because
> > for UNIX _every_ process is important and gets cpu and IO time.
> > When you start trying to add special low latency tasks, you endanger
> > liveness.  And preempt is especially corrosive because one of the
> > mechanisms UNIX uses to assure liveness is to make sure that once a
> > process starts it can do a significant chunk of work.
> 
If I read this right, your complaint is not with preemption but with
scheduler policy.  Clearly both are needed to "assure liveness". 
Another way of looking at preemption is that is enables a more
responsive and nimble scheduler policy (afterall it is the scheduler
that decided that task A should give way to task B.  All preemption does
is to allow that to happen with greater dispatch.)  Given that, we can
then discuss what scheduler policy should be.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
