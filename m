Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSAPXCN>; Wed, 16 Jan 2002 18:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSAPXCE>; Wed, 16 Jan 2002 18:02:04 -0500
Received: from mccammon.ucsd.edu ([132.239.16.211]:10404 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S286161AbSAPXB4>; Wed, 16 Jan 2002 18:01:56 -0500
Date: Wed, 16 Jan 2002 15:02:37 -0800 (PST)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: apodtele@chemcca18.ucsd.edu
To: Davide Libenzi <davidel@xmailserver.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [o(1) sched J0] higher priority smaller timeslices, in fact
In-Reply-To: <Pine.LNX.4.40.0201161458370.934-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0201161501430.3828-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man nice helped. Thanks!

On Wed, 16 Jan 2002, Davide Libenzi wrote:

> On Wed, 16 Jan 2002, Alexei Podtelezhnikov wrote:
> 
> >
> > The comment and the actual macros are inconsistent.
> > positive number * (19-n) is a decreasing function of n!
> 
> # man nice
> 
> 
> > + * The higher a process's priority, the bigger timeslices
> > + * it gets during one round of execution. But even the lowest
> > + * priority process gets MIN_TIMESLICE worth of execution time.
> > + */
> >
> > -#define NICE_TO_TIMESLICE(n)   (MIN_TIMESLICE + \
> > -	((MAX_TIMESLICE - MIN_TIMESLICE) * (19 - (n))) / 39)
> > +#define NICE_TO_TIMESLICE(n) (MIN_TIMESLICE + \
> > +	((MAX_TIMESLICE - MIN_TIMESLICE) * (19-(n))) / 39)
> >
> > I still suggest a different set as faster and more readable at least to
> > me. Just two operations instead of 4!
> 
> this seems quite readable to me, it's the equation at page 1 of any know
> linear geometry book.
> 
> 
> 
> 
> - Davide
> 
> 
> 

