Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVLUMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVLUMvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVLUMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:51:17 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:52682 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932395AbVLUMvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:51:16 -0500
Date: Wed, 21 Dec 2005 07:50:39 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Lameter <christoph@lameter.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <20051221063607.GA766@elte.hu>
Message-ID: <Pine.LNX.4.58.0512210743480.28477@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
 <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain>
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain> <Pine.LNX.4.62.0512201346550.20807@graphe.net>
 <1135116715.13138.409.camel@localhost.localdomain> <20051221063607.GA766@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=113510997009883&w=2
> > >
> > > Quite a long list of unsupported features. These academic papers
> > > usually only focus on one thing. The SLAB allocator has to work
> > > for a variety of situations though.
> > >
> > > It would help to explain what ultimately will be better in the new slab
> > > allocator. The complexity could be taken care of by reorganizing the code.
> >
> > Honestly, what I would like is a simpler solution, whether we go with
> > a new approach or reorganize the current slab.  I need to get -rt
> > working, and the code in slab is pulling my resources more than they
> > can extend. I'm capable to convert slab today as it is for RT but it
> > will probably take longer than I can afford.
>
> please, lets let the -rt tree out of the equation. The SLAB code is fine
> on upstream, and it was a pure practical maintainance decision to go for
> SLOB in the -rt tree. Yes, the SLAB code is complex, but i could hardly
> list any complexity in it tht isnt justified with a performance
> argument. _Maybe_ the SLAB code could be further cleaned up, maybe it
> could even be replaced, but we'd have to see the patches first. In any
> case, the -rt tree is not an argument that matters.

You're right about the -rt tree not being an argument for upstream.  I
used it as an example of the complexities.  This is not limited to -rt,
but for any other changes as well.  Years ago I tried changing the slab to
run on a small embedded device with very little memory, and I was pretty
much overwhelmed.

Now I see that people are converting it for NUMA. I give them a lot of
credit, since they must be smarter than I ;)

-- Steve

