Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUHMUWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUHMUWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUHMUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:22:52 -0400
Received: from colin2.muc.de ([193.149.48.15]:27914 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267466AbUHMUQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:16:13 -0400
Date: 13 Aug 2004 22:16:12 +0200
Date: Fri, 13 Aug 2004 22:16:12 +0200
From: Andi Kleen <ak@muc.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <20040813201612.GB35817@muc.de>
References: <2sxuC-429-3@gated-at.bofh.it> <m3657nu9dl.fsf@averell.firstfloor.org> <200408130904.00537.jbarnes@engr.sgi.com> <Pine.SGI.4.58.0408131220460.27384@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.58.0408131220460.27384@kzerza.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:31:41PM -0500, Brent Casavant wrote:
> On Fri, 13 Aug 2004, Jesse Barnes wrote:
> 
> > On Thursday, August 12, 2004 6:14 pm, Andi Kleen wrote:
> > > I don't like this approach using a dynamic counter. I think it would
> > > be better to add a new function that takes the vma and uses the offset
> > > into the inode for static interleaving (anonymous memory would still
> > > use the vma offset). This way you would have a good guarantee that the
> > > interleaving stays interleaved even when the system swaps pages in and
> > > out and you're less likely to get anomalies in the page distribution.
> >
> > That sounds like a good approach, care to show me exactly what you mean
> > with a
> > patch? :)

I put it on my todo list. 

> 
> Make sure to have some sort of offset for the static interleaving that
> is random or semi-random for each inode, as we discussed on linux-mm last

inode number (possible with some bits of dev_t, although that is probably
not needed) 

-Andi
