Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJ1RMf>; Mon, 28 Oct 2002 12:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSJ1RMf>; Mon, 28 Oct 2002 12:12:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:4854 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261384AbSJ1RMd>;
	Mon, 28 Oct 2002 12:12:33 -0500
Message-ID: <3DBD7176.BAC2BCD3@digeo.com>
Date: Mon, 28 Oct 2002 09:18:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.44-mm6
References: <3DBCD3D3.8DDA3982@digeo.com> <Pine.LNX.4.44L.0210281051440.1697-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2002 17:18:47.0959 (UTC) FILETIME=[13AD4A70:01C27EA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 27 Oct 2002, Andrew Morton wrote:
> 
> > . Spent some time tuning up 2.5's StupidSwapStorm throughput.  It's
> >   on par with 2.4 for single-threaded things, but not for multiple
> >   processes.
> >
> >   This is because 2.4's virtual scan allows individual processes to
> >   hammer all the others into swap and to make lots of progress then
> >   exit.  In the 2.5 VM all processes make equal progress and just
> >   thrash each other to bits.
> >
> >   This is an innate useful side-effect of the virtual scan, although
> >   it may have significant failure modes.  The 2.5 VM would need an
> >   explicit load control algorithm if we care about such workloads.
> 
> 1) 2.4 does have the failure modes you talk about ;)

Shock :)  How does one trigger them?


> 2) I have most of an explicit load control algorithm ready,
>    against an early 2.4 kernel, but porting it should be very
>    little work
> 
> Just let me know if you're interested in my load control mechanism
> and I'll send it to you.

It would be interesting if you could send out what you have.

It would also be interesting to know if we really care?  The
machine is already running 10x slower than it would be if it
had enough memory; perhaps it is just not a region of operation
for which we're interested in optimising.  (Just being argumentitive
here ;))

>  Note that I never got the load control _policy_ right yet ...

mm.  Tricky.  This is interesting:
http://www.unet.univie.ac.at/aix/aixbman/prftungd/vmmov.htm
