Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVAMHDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVAMHDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVAMHDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:03:38 -0500
Received: from waste.org ([216.27.176.166]:59781 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261179AbVAMHDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:03:36 -0500
Date: Wed, 12 Jan 2005 23:03:14 -0800
From: Matt Mackall <mpm@selenic.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Message-ID: <20050113070314.GL2995@waste.org>
References: <Pine.LNX.4.58.0501122101420.13738@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501122101420.13738@skynet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 09:09:24PM +0000, Mel Gorman wrote:
> I stress-tested this patch very heavily and it never oopsed so I am
> confident of it's stability, so what is left is to look at the results of
> this patch were and I think they look promising in a number of respects. I
> have graphs that do not translate to text very well, so I'll just point you
> to http://www.csn.ul.ie/~mel/projects/mbuddy-results-1 instead.

This graph rather hard to comprehend.

> The results were not spectacular but still very interesting. Under heavy
> stresing (updatedb + 4 simultaneous -j4 kernel compiles with avg load 15)
> fragmentation is consistently lower than the standard allocator. It could
> also be a lot better if there was some means of purging caches, userpages
> and buffers but thats in the future. For the moment, the only real control
> I had was the buffer pages.

You might stress higher order page allocation with a) 8k stacks turned
on b) UDP NFS with large read/write.
 
> Opinions/Feedback?

Looks interesting.

-- 
Mathematics is the supreme nostalgia of our time.
