Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSDSLeS>; Fri, 19 Apr 2002 07:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDSLeR>; Fri, 19 Apr 2002 07:34:17 -0400
Received: from [213.38.169.194] ([213.38.169.194]:29445 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S311749AbSDSLeP>; Fri, 19 Apr 2002 07:34:15 -0400
Message-ID: <AFE36742FF57D411862500508BDE8DD004639E64@cordelia.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: "'Matt'" <matt@progsoc.uts.edu.au>, linux-kernel@vger.kernel.org
Subject: RE: [RFC] 2.5.8 sort kernel tables
Date: Fri, 19 Apr 2002 12:38:05 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This variation on Quicksort seems superior...  Must look at the libc
sources someday to see how it does it...

http://www.neubert.net/Flapaper/9802n.htm

For small arrays, Insertion Sort has the least overhead.

Cheers,

Phil

P.S. A google for quickersort yields loads of interesting references.

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Matt [mailto:matt@progsoc.uts.edu.au]
> Sent: 19 April 2002 06:00
> To: linux-kernel@vger.kernel.org
> Subject: Re: [RFC] 2.5.8 sort kernel tables
> 
> 
> On Thu, Apr 18, 2002 at 03:20:17PM -0500, Oliver Xymoron wrote:
> > On Thu, 18 Apr 2002, William Lee Irwin III wrote:
> 
> >> On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:
> 
> >>> The use of __init and __exit sections breaks the assumption that
> >>> tables such as __ex_table are sorted, it has already broken the
> >>> dbe table in mips on 2.5.  This patch against 2.5.8 adds a generic
> >>> sort routine and sorts the i386 exception table.  This sorting
> >>> needs to be extended to several other tables, to all
> >>> architectures, to modutils (insmod loads some of these tables for
> >>> modules) and back ported to 2.4.  Before I spend the rest of the
> >>> time, any objections?
> 
> >> It doesn't have to be an O(n lg(n)) method but could you use
> >> something besides bubblesort? Insertion sort, selection sort,
> >> etc. are just as easy and they don't have the horrific stigma of
> >> being "the worst sorting algorithm ever" etc.
> 
> > Combsort is a trivial modification of bubblesort that's O(n log(n)).
> 
> >  http://cs.clackamas.cc.or.us/molatore/cs260Spr01/combsort.htm
> 
> > Though we should probably just stick a simple qsort in the library
> > somewhere.
> 
> but isn't qsort's worst case behaviour for an already sorted list? i
> cant remember how bad it is but i thought it was like O(n^2) for worst
> case, ie just as bad as bubble sort..
> 
> 	matt
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
