Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVISWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVISWsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVISWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:48:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964776AbVISWsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:48:12 -0400
Date: Mon, 19 Sep 2005 15:48:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been
 merged
Message-Id: <20050919154813.52f5b706.akpm@osdl.org>
In-Reply-To: <200509192356.56300.ak@suse.de>
References: <200509101120.19236.ak@suse.de>
	<20050919194038.GB12810@verdi.suse.de>
	<Pine.LNX.4.62.0509191426250.26388@schroedinger.engr.sgi.com>
	<200509192356.56300.ak@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Monday 19 September 2005 23:32, Christoph Lameter wrote:
> > On Mon, 19 Sep 2005, Andi Kleen wrote:
> > > On Mon, Sep 19, 2005 at 10:11:20AM -0700, Christoph Lameter wrote:
> > > > However, one still does not know which memory section (vma) is
> > > > allocated on which nodes. And this may be important since critical data
> > > > may need to
> > >
> > > Maybe. Well sure of things could be maybe important. Or maybe not.
> > > Doesn't seem like a particularly strong case to add a lot of ugly
> > > code though.
> >
> > We gradually need to fix the deficiencies of the policy layer. Calling
> > fixes "ugly code" and refusing to discuss solutions does not help anyone.
> 
> I'm happy to discuss solutions given a clear use case what you want
> to do, why you want to do it etc. 

Yes.  A clear explanation of the requirements and usecases based on
real-world experience from real-world users and/or application developers. 
I asked Christoph for that last week.  The answers were, iirc, a bit
half-baked, but believeable.

> > Have you ever had the challenge to work with large HPC applications on a
> > large NUMA system? 
> 
> Ah - my code is better because my credentials are better.

No fair.  I've never worked on big HPC systems and any feedback from the
field which Christoph can provide is really important in helping us
understand what features the kernel needs to offer.  I would expect that
SGI engineering have a better understanding of HPC users' needs than pretty
much anyone else in the world.

It's a shame that SGI engineering aren't better at communicating those
needs to wee little kernel developers.  And we need to get better at this
because, as you say, external policy control is going to be a ton harder to
swallow than /proc/pid/numa_maps.
