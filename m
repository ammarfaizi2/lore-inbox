Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVBQXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVBQXfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBQXfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:35:30 -0500
Received: from cantor.suse.de ([195.135.220.2]:4522 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261249AbVBQXex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:34:53 -0500
Date: Fri, 18 Feb 2005 00:34:48 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
Message-ID: <20050217233448.GB3115@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> <20050217230342.GA3115@wotan.suse.de> <1108682463.28873.1.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108682463.28873.1.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 10:21:03AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-02-18 at 00:03 +0100, Andi Kleen wrote:
> 
> > And to be honest we only have about 6 or 7 of these walkers
> > in the whole kernel. And 90% of them are in memory.c
> > While doing 4level I think I changed all of them around several
> > times and it wasn't that big an issue.  So it's not that we
> > have a big pressing problem here... 
> 
> We have about 50% of them in memory.c :) But my main problem is more
> that every single of them is implemented slightly differently.

No much more. But I only count real walkers, not stuff like vmalloc. 

The ioremap duplication over architectures is a bit annoying, but
the fix for that would be to factor the code out completely, not
only improve walking.

-Andi
