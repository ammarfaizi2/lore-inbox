Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310157AbSCAXJ3>; Fri, 1 Mar 2002 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310162AbSCAXJ0>; Fri, 1 Mar 2002 18:09:26 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:30910 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S310157AbSCAXIq>; Fri, 1 Mar 2002 18:08:46 -0500
Date: Fri, 01 Mar 2002 15:17:46 -0800
From: Shaun Jackman <sjackman@shaw.ca>
Subject: Re: swsusp list
In-Reply-To: <20020228094035.GB4760@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <E16gwHa-0000B7-00@quince.jackman>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <E16gLkD-0000KR-00@quince.jackman>
 <20020228094035.GB4760@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have to have just one swap partition. Disable one of them.
Ok, I did that. Now I'm getting an error there's not enough swap space 
(logical enough I think).

/critical section: Counting pages to copy[nosave] (pages needed
:18062+152=18574 free 14689)
Couldn't get enough free pages, on 3885 pages short.
Kernel panic: Not enough free pages

If both swap partitions is disallowed, and one swap partition isn't enough 
space, is there anything I can do now to make this work? I'd really like to 
get suspend working.
I know at one point 128MB was the limit on a swap partition. Is this limit 
gone now?
How technically difficult is it to make swsusp work with multiple swap 
partitions?

Cheers,
Shaun

[entire thread follows for the linux-kernel mailing list]
On Thu February 28, 2002 01h40, you wrote:
> Hi!
>
> > I've been trying to reach the swsusp mail list, but the webpage seems to
> > be down (I cannot access it).
> > http://lister.fornax.hu/mailman/listinfo/swsusp
> >
> > Is this site/list active? Where should I send technical questions?
>
> Well, don't know, probably linux-kernel@vger.kernel.org.
>
> > In any case, here's my Q. I patched my 2.4.17 kernel with the 2.5.1 patch
> > available on the web site. There were only minor rejects that I fixed
> > manually. I compiled and installed the kernel. Then I tried a SysRq-d and
> > got the following output (this was recorded by hand, so it may not be
> > perfect, but it should be close).
> >
> > Stopping Processes
> > Waiting... ok
> > Freeing...
> > Syncing disks before copy
> > /critical section: Counting pages to copy[nosave]
> >   (pages needed: 13251+512=13763 free:19500)
> > Alloc pagedir
> > [nosave] critical section/: done (13251 pages copied)
> > writing data to swap (13251 pages):... done
> > Writing pagedir (52 pages):...,header,signature<0>
> > Kernel panic: Need just one swapfile
> >
> > Pentium III 450 w/ 128 MB ram
> > 128 MB swap partition on each ide disk (256 MB total)
>
> You have to have just one swap partition. Disable one of them.
>
> 							Pavel
