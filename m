Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272287AbRIVVqV>; Sat, 22 Sep 2001 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272295AbRIVVqL>; Sat, 22 Sep 2001 17:46:11 -0400
Received: from as1-5-2.tbg.s.bonet.se ([217.215.34.209]:61607 "EHLO
	flashdance.cx") by vger.kernel.org with ESMTP id <S272287AbRIVVp7>;
	Sat, 22 Sep 2001 17:45:59 -0400
Date: Sat, 22 Sep 2001 23:46:50 +0200 (CEST)
From: Peter Magnusson <iocc@linux-kernel.flashdance.cx>
X-X-Sender: <iocc@flashdance>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010922164645.D15681@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33L2.0109222313420.29748-100000@flashdance>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001, Jan Harkes wrote:

> Only when the wrong pages have been swapped out and need to be swapped
> in again. Swapped out pages should be relatively inactive, the amount of
> swap space allocated number that you see in 'free' is not the same as
> the amount of pages that are actually swapped out and removed from
> memory, any active ones should still be around in the pagecache.
>
> > Use the swap as little as possible == good.
>
> Nope, Use the swap-in as little as possible == good, I don't mind having
> 4GB of data in swap, as long as I typically don't need to load it back
> into in memory. And every page that is in swap that I don't really need
> means another page that can be used to avoid paging out an executable,
> or purging the dentry lookup caches, or dropping one of those files I
> access once every 5 minutes.

I think we are talking about somewhat different things. U talk about
swapping in general. I talk about the changes 2.4.7 > now (2.4.9 for
example) in the VM system that makes linux to swap alot.

In kernel 2.4.7 maybe 5 Mbyte was put on the swap over a week. It didnt
had any need to put more on the swap because i got 512 Mbyte RAM.

Then that changed... In for example 2.4.9 it put ALOT of Mbyte on the swap
very fast, like 100-200 Mbyte. And then it will slowly swap it back to RAM
when they are needed. If it didnt put it on the swap in the first place and
keept it in RAM like under 2.4.7 it would not swap it back to RAM later and
it would go faster. I know alot of others that are very annoyed about this
and is complaing about it. I just doesnt reach the linux-kernel
mailinglist.

