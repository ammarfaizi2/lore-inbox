Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVJCBUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVJCBUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVJCBUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:20:39 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:53138 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932106AbVJCBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:20:38 -0400
Date: Sun, 2 Oct 2005 18:20:38 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051003005400.GM6290@lkcl.net>
Message-ID: <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
 <20051003005400.GM6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:

> On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:
>
> > >  what if, therefore, someone comes up with an architecture that is
> > >  better than or improves greatly upon SMP?
> >
> > Like NUMA?
>
>  yes, like numa, and there is more.

The beauty of capitalization is that it makes it easier for others to
read what you have to say.

>  i had the honour to work with someone who came up with a radical
>  enhancement even to _that_.
>
>  basically the company has implemented, in hardware (a
>  nanokernel), some operating system primitives, such as message
>  passing (based on a derivative by thompson of the "alice"
>  project from plessey, imperial and manchester university
>  in the mid-80s), hardware cache line lookups (which means
>  instead of linked list searching, the hardware does it for
>  you in a single cycle), stuff like that.

That sounds awesome, but I have something better -- a quantum computer.
And it's about as parallel as you're going to get anytime in the
foreseeable future!

...

Moral of the story: There are thousands of hardware doodads all around.
People only start to become interested when they have actual "metal"
freely available on the market, that they can play with and code to.

>  the message passing system is designed as a parallel message bus -
>  completely separate from the SMP and NUMA memory architecture, and as
>  such it is perfect for use in microkernel OSes.

You're making an implicit assumption here that it will benefit _only_
microkernel designs. That is not at all immediate or obvious to me (or,
I suspect, others also) -- where's the proof?

>  (these sorts of things are unlikely to make it into the linux kernel, no
>  matter how much persuasion and how many patches they would write).

No, the kernel hackers are actually very sensible people. When they push
back, there's usually a darn good reason for it. See above point
regarding availability of hardware.

>  _however_, a much _better_ target would be to create an L4 microkernel
>  on top of their hardware kernel.

Perfect. You can do that, and benefit from the oodles of fame that
follow. Others might be less-than-convinced.

>  this company's hardware is kinda a bit difficult for most people to get
>  their heads round: it's basically parallelised hardware-acceleration for
>  operating systems, and very few people see the point in that.

That just sounds condescending.

>  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
>  and to get any faster you _have_ to go parallel.

Sure, it's going to stop somewhere, but you have to be a heck of a
visionary to predict that it will stop _there_. People have been
surprised before on such matters, so don't go around yelling about the
impending doom quite yet.

>  and the drive for "faster", "better", "more sales" means more and more
>  parallelism.
>
>  it's _happening_ - and SMP ain't gonna cut it (which is why
>  these multi-core chips are coming out and why hyperthreading
>  is coming out).

"Rah, rah, parallelism is great!" -- That's a great slogan, except...

Users, who also happen to be the target of those sales, care about
_userland_ applications. And the bitter truth is that the _vast_
majority of userland apps are single-threaded. Why? Two reasons --
first, it's harder to write a multithreaded application, and second,
some workloads simply can't be expressed "in parallel". Your kernel
might (might, not will) run like a speed-demon, but the userland stuff
will still be lackluster in comparison.

And that's when your slogan hits a wall, and the marketing hype dies.
The reality is that parallelism is something to be desired, but is not
always achievable.

>  so.
>
>  this is a heads-up.
>
>  what you choose to do with this analysis is up to you.

I choose to wait for actual, concrete details and proofs of your design,
instead of the ambiguous "visionary" hand-waving so far. As has already
been said, -ENOPATCH.

>  l.
>

-Vadim Lobanov
