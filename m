Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSAGVLm>; Mon, 7 Jan 2002 16:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287089AbSAGVLc>; Mon, 7 Jan 2002 16:11:32 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:8463 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S287098AbSAGVLX>;
	Mon, 7 Jan 2002 16:11:23 -0500
Date: Mon, 7 Jan 2002 13:11:33 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade
 performance still suck :-(
In-Reply-To: <E16NcnC-0001RM-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201071259550.31385-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Daniel Phillips wrote:

> On January 7, 2002 05:06 pm, Alan Cox wrote:
> > You can make it right for most people but the last few percent you
> > will always get by tuning knobs - either directly or via GUI tools like
> > powertweak
>
> Except, as you and others have pointed out, we are far from knowing what the
> knobs should be.

Hauling out my Gilbert and Sullivan: "I've got a little list" :-)

1. The time slice. Currently this is a #define. Make it a variable and
give me a sysctl to set it.

2. The processor change penalty in the scheduler. Again a #define. Make
it a variable and give me a sysctl to set it.

3. The "memory map" change penalty in the scheduler. Currently
hard-coded to 1 in "sched.c". Make it a variable and give me a sysctl to
set it.

4. The DMA, lowmem and highmem balance ratios and maxima in
"page_alloc.c". Currently these are hard coded. From the code, it looks
like the values I *really* want to change, the watermarks for each zone,
are computed at boot time and can't be changed once the system boots.
But I'd like to be able to change the watermarks at run time if at all
possible.

5. The minimum and maximum fraction of memory that can be allocated to
page cache for each zone.
--
M. Edward "Lord High Executioner" Borasky

znmeb@borasky-research.net
http://www.borasky-research.net
http://groups.yahoo.com/group/meta-trading-coach

How to Stop A Folksinger Cold # 5
"Where have all the flowers gone..."
Beats me.

