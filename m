Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293668AbSCPCUu>; Fri, 15 Mar 2002 21:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293670AbSCPCUk>; Fri, 15 Mar 2002 21:20:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25326 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S293668AbSCPCUc>;
	Fri, 15 Mar 2002 21:20:32 -0500
Message-ID: <3C929BF0.3CDC58AB@mvista.com>
Date: Fri, 15 Mar 2002 17:12:16 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] Re: futex and timeouts
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <20020315151507.2370C3FE0C@smtp.linux.ibm.com> <20020315160444.P4836@parcelfarce.linux.theplanet.co.uk> <20020315185844.8883E3FE06@smtp.linux.ibm.com> <20020315192818.R4836@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 
> On Fri, Mar 15, 2002 at 01:59:38PM -0500, Hubertus Franke wrote:
> > > > What I would like to see is an interface that lets me pass optional
> > > > parameters to the syscall interface, so I can call with different number
> > > > of parameters.
> > >
> > >     Is this to lock multiple futexes "atomically"?  If we are
> > > looking for a fast path stack-wise, this seems extra work.
> >
> > No, take for example...
> >
> > syscall3(int,futex,int,op, struct futex*, futex, int opt_arg);
> 
I don't think there is anything "broken" in defining more than one
syscall stub to the same system call, each with a different parameter
count (or completely different arguments).  The call code will need to
be able to figure it out, but there is nothing in the way as far as
doing it.

-g

> --
> 
> Life's Little Instruction Book #347
> 
>         "Never waste the oppourtunity to tell someone you love them."
> 
>                         http://www.jlbec.org/
>                         jlbec@evilplan.org
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
