Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285475AbRLYLuV>; Tue, 25 Dec 2001 06:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285481AbRLYLuM>; Tue, 25 Dec 2001 06:50:12 -0500
Received: from white.pocketinet.com ([12.17.167.5]:30112 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S285475AbRLYLuF>; Tue, 25 Dec 2001 06:50:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: minimizing swap usage
Date: Tue, 25 Dec 2001 03:50:07 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112200559350.8883-100000@shell1.aracnet.com> <WHITEp4nbukgQu0216A000005b2@white.pocketinet.com> <01122513421800.02101@manta>
In-Reply-To: <01122513421800.02101@manta>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITE9dmLgtgGbEauz0000005b7@white.pocketinet.com>
X-OriginalArrivalTime: 25 Dec 2001 11:48:27.0599 (UTC) FILETIME=[11011DF0:01C18D3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 December 2001 07:42 am, vda wrote:
> On Tuesday 25 December 2001 09:02, Nicholas Knight wrote:
> > > > What's with all the caching when my apps crawl because it's
> > > > swapping so much ? I've tried to adjust /proc/vm/kswapd
> > > > parameters but that doesn't seem to help..I'd like to postpone
> > > > the swapping until its almost out of physical memory..
> > >
> > > This may seem counterintuitive, but postponing swapping / cache
> > > flushing to disk till the last possible moment is
> > > counterproductive. It's a little like procrastination in the time
> > > management world --
> >
> > Why not add a config option to choose between code for two
> > behaviors: (1 being the default, of course)
> > 1. Current behavior.... [snip]
> > 2. Don't swap ANYTHING to disk until avalible RAM drops below, say,
> > 15%. And put cache on a sanity check; if the system is going to
> > swap to disk because avalible RAM drops below 15%, and  cache makes
> > up more than, say, 45%, start dropping the oldest stuff in the
> > cache to free up RAM instead of swapping. (I'm assuming 128-256MB+
> > of RAM here, for anything smaller, default is probably best.)
>
> There are actually two things which are usually referred to as
> 'excessive swap':
>
> (1) 'swap in'. pages which were unused for some time got swapped out
> over time, but now an app (imagine something big: Mozilla) wants them
> back and starts to read them all from swap space into RAM (+ possibly
> swapping out old pages of other apps to free that RAM first). This
> may feel sluggish but is actually correct behaviour.

*USUALY* correct.

>
> (2) 'bad cache'. Kernel swaps out and back in pages which are NOT old
> while obviously old pages are sitting in the disk cache. This is a
> kernel bug in page age calculations: kernel incorrectly thinks that
> those pages it swaps out are oldest pages in RAM, and cache pages are
> young.
>
> If you want to submit a bug report, please make sure you are seeing
> (2) and not (1).
>

This was not a bug report.

> If you want to improve swap strategy, talk to Andrea Arcangeli and/or
> Rik van Riel or search archives and read (long) 2.4.x VM battle
> threads first.

I didn't email either directly, because I doubt either has time to work 
on this, since default behavior is seen as "correct", and if they do, 
they will most likely notice this thread and read my message, or 
someone else will point it out to them that better knows if it's a pure 
waste of their time or not.

As for the VM battle threads, I read most of them as they were 
happening, and I really don't give a shit about them.
