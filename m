Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUE0H7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUE0H7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 03:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUE0H7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 03:59:01 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261712AbUE0H66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 03:58:58 -0400
Date: Thu, 27 May 2004 09:05:58 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405270805.i4R85wn4000373@81-2-122-30.bradfords.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
In-Reply-To: <F81057AD-AF6C-11D8-AF0E-000393ACC76E@mac.com>
References: <MDEHLPKNGKAHNMBLJOLKMEAEMEAA.davids@webmaster.com>
 <200405261658.i4QGwiYX000121@81-2-122-30.bradfords.org.uk>
 <F81057AD-AF6C-11D8-AF0E-000393ACC76E@mac.com>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Kyle Moffett <mrmacman_g4@mac.com>:
> On May 26, 2004, at 12:58, John Bradford wrote:
> >> 	A lot of people feel subjectively that swap makes a system slow. 
> >> There's
> >> anecdotal evidence that swap does horrible things or "must be badly 
> >> broken
> >> because the machine gets slow" on almost every operating system that
> >> supports swapping. In most cases, it's just a case where the real 
> >> working
> >> set has exceeded physical memory, and in that case, swap is just 
> >> doing what
> >> it's supposed to be doing.
> > It's true that physical RAM or swap, over and above the minimum needed 
> > for
> > the working set is usually beneficial.  However where there is 
> > physical RAM
> > which will never be touched during normal usage, adding swap will not 
> > be
> > beneficial.
> 
> If your RAM happens to be large enough to contain not only everything 
> on disk
> you ever want to even read *and* all the space you need for 
> calculations, then
> you have nothing to gain from using swap.  On the other hand, if you 
> are say,
> grepping through a kernel source tree, the first time it is read from 
> disk, but after
> that it is stored in cache in your RAM.  If you have swap, anonymous 
> pages of
> RAM that are not in use can be paged out while you do your grepping, 
> even if
> you are grepping through a 900MB+ dataset and only have 1GB RAM.  Swap
> allows non-filesystem-backed pages to be pushed to disk for some 
> filesystem
> backed pages to be loaded and used.

Think about it - you seem to be suggesting that adding more and more swap will
free up more and more physical RAM to be used as cache, but that it not really
true, because once you've freed up all of the physical RAM, there is no more
to free up.

That it not to say that there is no point in having more swap than physical
RAM at all, rather that once all non-filesystem-backed pages apart from cache
have been pushed out to swap, (and note that executables can and will be pushed
out to swap independently of swap space anyway), all that additional swap
space will allow is to run more processes, or move cache out to swap, which
admittedly could give a performance benefit in some instances, but in most
cases I think it would be minimal.

John.
