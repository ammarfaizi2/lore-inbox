Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbSAPXID>; Wed, 16 Jan 2002 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSAPXHn>; Wed, 16 Jan 2002 18:07:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:37126 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282511AbSAPXHg>; Wed, 16 Jan 2002 18:07:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Jan 2002 15:13:45 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [o(1) sched J0] higher priority smaller timeslices, in fact
In-Reply-To: <Pine.LNX.4.44.0201161501430.3828-100000@chemcca18.ucsd.edu>
Message-ID: <Pine.LNX.4.40.0201161509460.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Alexei Podtelezhnikov wrote:

> man nice helped. Thanks!
>
> On Wed, 16 Jan 2002, Davide Libenzi wrote:
>
> > On Wed, 16 Jan 2002, Alexei Podtelezhnikov wrote:
> >
> > >
> > > The comment and the actual macros are inconsistent.
> > > positive number * (19-n) is a decreasing function of n!
> >
> > # man nice
> >
> >
> > > + * The higher a process's priority, the bigger timeslices
> > > + * it gets during one round of execution. But even the lowest
> > > + * priority process gets MIN_TIMESLICE worth of execution time.
> > > + */
> > >
> > > -#define NICE_TO_TIMESLICE(n)   (MIN_TIMESLICE + \
> > > -	((MAX_TIMESLICE - MIN_TIMESLICE) * (19 - (n))) / 39)
> > > +#define NICE_TO_TIMESLICE(n) (MIN_TIMESLICE + \
> > > +	((MAX_TIMESLICE - MIN_TIMESLICE) * (19-(n))) / 39)
> > >
> > > I still suggest a different set as faster and more readable at least to
> > > me. Just two operations instead of 4!
> >
> > this seems quite readable to me, it's the equation at page 1 of any know
> > linear geometry book.

and this macro gets called about every 80ms, that is nothing. try to run a
cycle counter between the two implementation, get the time difference
using the CPU speed and weight it with 80ms. you'll get a percent that
compared to that, the probability of having snow in Miami in August is a
big number :-)




- Davide


