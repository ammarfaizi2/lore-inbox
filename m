Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136139AbRDVOB4>; Sun, 22 Apr 2001 10:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136142AbRDVOBr>; Sun, 22 Apr 2001 10:01:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24753 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S136139AbRDVOB0>; Sun, 22 Apr 2001 10:01:26 -0400
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        lse-tech-admin@lists.sourceforge.net, nigel@nrg.org,
        rusty@rustcorp.com.au
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF59B5FB6C.92BDC5D6-ON88256A36.004AEFF8@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Sun, 22 Apr 2001 06:38:37 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/22/2001 08:01:10 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > But if you are suppressing preemption in all read-side critical
sections,
> > then wouldn't any already-preempted tasks be guaranteed to -not- be in
> > a read-side critical section, and therefore be guaranteed to be
unaffected
> > by the update (in other words, wouldn't such tasks not need to be
waited
> > for)?
>
> Ah, if you want to inc and dec all the time, yes.  But even if the
> performance isn't hurt, it's unneccessary, and something else people
> have to remember to do.

I must admit that free is a very good price.

> Simplicity is very nice.  And in the case of module unload, gives us
> the ability to avoid the distinction between "am I calling into a
> module?" and "is this fixed in the kernel?" at runtime.  A very good
> thing 8)

Is it also desireable to avoid the distinction between "the currently
executing code is in a module" and "the currently executing code is
fixed in the kernel"?

> Rusty.

                              Thanx, Paul

