Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSHJTzL>; Sat, 10 Aug 2002 15:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHJTzK>; Sat, 10 Aug 2002 15:55:10 -0400
Received: from main.tellink.net ([208.3.160.2]:34042 "EHLO main.tellink.net")
	by vger.kernel.org with ESMTP id <S317299AbSHJTzI>;
	Sat, 10 Aug 2002 15:55:08 -0400
Date: Sat, 10 Aug 2002 15:58:46 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@localhost.localdomain
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dirty words on linux-kernel
In-Reply-To: <20020810203004.A666@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208101558060.19369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look to me like it'd be "_pussy_ foot" in the second one. Didn't someone 
else get the same kind of message before? Was it from the same host?

On Sat, 10 Aug 2002, Jamie Lokier wrote:

> Sorry folks, but I found this bounce from a message I sent to
> linux-kernel both funny and slightly disturbing.  Note that the bounce
> comes from a subscriber to linux-kernel, not the mailing list
> management! (:-)
> 
>   Subject: ScanMail Message: To Sender, sensitive content found and action taken.
>   From: System Attendant <WLVEXC01-SA@digitalinsight.com>
> 
>   Trend SMEX Content Filter has detected sensitive content.
> 
>   Place = Linus Torvalds; Andrew Morton; lkml;
>   Sender = Jamie Lokier
>   Subject = Re: [patch 6/12] hold atomic kmaps across generic_file_read
>   Delivery Time = August 10, 2002 (Saturday) 10:59:18
>   Policy = Dirty Words
>   Action on this mail = Quarantine message
> 
>   Warning message from administrator:
>   Sender, Content filter has detected a sensitive e-mail.
> 
> I wonder if anyone can spot "Dirty Words" in the text below!  (I don't
> see any).  The bounce doesn't say which message; it must be one of the
> two below.
> 
> enjoy,
> -- Jamie
> 
> ----------------- possible dirty talk #1 --------------------
> 
> Linus Torvalds wrote:
> > Imagine doing a
> >
> >       fstat(fd..)
> >       buf = aligned_malloc(st->st_size)
> >       read(fd, buf, st->st_size);
> >
> > and having it magically populate the VM directly with the whole file
> > mapping, with _one_ failed page fault. And the above is actually a fairly
> > common thing. See how many people have tried to optimize using mmap vs
> > read, and what they _all_ really wanted was this "populate the pages in
> > one go" thing.
> 
> This will only provide the performance benefic when `aligned_malloc'
> return "fresh" memory, i.e. memory that has never been written to.
> 
> Assuming most programs use plain old `malloc', which could be taught to
> align nicely, then the optimisation might occur when a program starts
> up, but later on it's more likely to return memory which has been
> written to and previously freed.  So the performance becomes
> unpredictable.
> 
> But it's a nice way to optimise if you are _deliberately_ optimising a
> user space program.  First call mmap() to get some fresh pages, then
> call read() to fill them.  Slower on kernels without the optimisation,
> fast on kernels with it. :-)
> 
> -- Jamie
> 
> ----------------- possible dirty talk #2 --------------------
> 
> Linus Torvalds wrote:
> > For people like that, wouldn't it be nice to just be able to tell them: if
> > you do X, we guarantee that you'll get optimal zero-copy performance for
> > reading a file.
> 
> Don't forget to include the need for mmap(... MAP_ANON ...) prior to the
> read.
> 
> Given the user will need to establish a new mapping anyway, why pussy
> foot around with subtleties?  Just add a MAP_PREFAULT flag to mmap(),
> which reads the whole file and maps it before returning.
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

