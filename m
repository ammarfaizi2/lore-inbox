Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVJCCbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVJCCbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVJCCbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:31:38 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:18305 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932128AbVJCCbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:31:37 -0400
Date: Sun, 2 Oct 2005 19:31:36 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051003015302.GP6290@lkcl.net>
Message-ID: <Pine.LNX.4.58.0510021910230.21329@shell2.speakeasy.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
 <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net>
 <20051003015302.GP6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:

> On Sun, Oct 02, 2005 at 06:20:38PM -0700, Vadim Lobanov wrote:
>
> > On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> >
> > > On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:
> > >
> > > > >  what if, therefore, someone comes up with an architecture that is
> > > > >  better than or improves greatly upon SMP?
> > > >
> > > > Like NUMA?
> > >
> > >  yes, like numa, and there is more.
> >
> > The beauty of capitalization is that it makes it easier for others to
> > read what you have to say.
>
>  sorry, vadim: haven't touched a shift key in over 20 years.

It's not going to bite you. I promise.

> > >  basically the company has implemented, in hardware (a
> > >  nanokernel), some operating system primitives, such as message
> > >  passing (based on a derivative by thompson of the "alice"
> > >  project from plessey, imperial and manchester university
> > >  in the mid-80s), hardware cache line lookups (which means
> > >  instead of linked list searching, the hardware does it for
> > >  you in a single cycle), stuff like that.
> >
> > That sounds awesome, but I have something better -- a quantum computer.
> > And it's about as parallel as you're going to get anytime in the
> > foreseeable future!
>
>  :)
>
>  *sigh* - i _so_ hope we don't need degrees in physics to program
>  them...
>
> > >  the message passing system is designed as a parallel message bus -
> > >  completely separate from the SMP and NUMA memory architecture, and as
> > >  such it is perfect for use in microkernel OSes.
> >
> > You're making an implicit assumption here that it will benefit _only_
> > microkernel designs.
>
>  ah, i'm not: i just left out mentioning it :)
>
>  the message passing needs to be communicated down to manage
>  threads, and also to provide a means to manage semaphores and
>  mutexes: ultimately, support for such an architecture would
>  work its way down to libc.
>
>
>  and yes, if you _really_ didn't want a kernel in the way at all, you
>  could go embedded and just... do everything yourself.
>
>  or port reactos, the free software reimplementation of nt,
>  to it, or something :)
>
>  *shrug*.

No, for reliability and performance reasons, I very much want a kernel
in the way. After all, kernel code is orders of magnitude better tuned
than almost all userland code.

The point I was making here is that, from what I can see, the current
Linux architecture is quite alright in anticipation of the hardware that
you're describing. It _could_ be better tuned for such hardware, sure,
but so far there is no need for such work at this particular moment.

> > >  this company's hardware is kinda a bit difficult for most people to get
> > >  their heads round: it's basically parallelised hardware-acceleration for
> > >  operating systems, and very few people see the point in that.
> >
> > That just sounds condescending.
>
>  i'm very sorry about that, it wasn't deliberate and ... re-reading
>  my comment, i should say that my comment isn't actually entirely true!
>
>  a correction/qualification: the people whom the startup company
>  contacted before they were put in touch with me had found that
>  everybody they had previously talked to just simply _did_ not
>  get it: this was presumably because of their choice of people
>  whom they were seeking funding from were not technically up
>  to the job of understanding the concept.
>
>  i didn't mean to imply that _everyone_ - or more specifically the
>  people reading this list - would not get it.
>
>  sorry.
>
> > >  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
> > >  and to get any faster you _have_ to go parallel.
> >
> > Sure, it's going to stop somewhere, but you have to be a heck of a
> > visionary to predict that it will stop _there_.
>
>  okay, i admit it: you caught me out - i'm a mad visionary.
>
>  but seriously.
>
>  it won't stop - but the price of 90nm mask charges, at approx
>  $2m, is already far too high, and the number of large chips
>  being designed is plummetting like a stone as a result - from
>  like 15,000 per year a few years ago down to ... damn, can't remember -
>  less than a hundred (i think!  don't quote me on that!)
>
>  when 90 nm was introduced, some mad fabs wanted to make 9
>  metre lenses, dude!!! until carl zeiss were called in and
>  managed to get it down to 3 metres.
>
>  and that lens is produced on a PER CHIP basis.
>
>  basically, it's about cost.

I can guarantee one thing here -- the cost, as is, is absolutely
bearable. These companies make more money doing this than they spend in
doing it, otherwise they wouldn't be in business. From an economics
perspective, this industry is very much alive and well, proven by the
fact that these companies haven't bailed out of it yet.

>  the costs of producing faster and faster uniprocessors is
>  getting out of control.
>
>  i'm not explaining things very well, but i'm trying.  too many words,
>  not concise enough, too much to explain without people misunderstanding
>  or skipping things and getting the wrong end of the stick.
>
>  argh.
>
>
> > >  and the drive for "faster", "better", "more sales" means more and more
> > >  parallelism.
> > >
> > >  it's _happening_ - and SMP ain't gonna cut it (which is why
> > >  these multi-core chips are coming out and why hyperthreading
> > >  is coming out).
> >
> > "Rah, rah, parallelism is great!" -- That's a great slogan, except...
> >
> > Users, who also happen to be the target of those sales, care about
> > _userland_ applications. And the bitter truth is that the _vast_
> > majority of userland apps are single-threaded. Why? Two reasons --
> > first, it's harder to write a multithreaded application, and second,
> > some workloads simply can't be expressed "in parallel". Your kernel
> > might (might, not will) run like a speed-demon, but the userland stuff
> > will still be lackluster in comparison.
> >
> > And that's when your slogan hits a wall, and the marketing hype dies.
> > The reality is that parallelism is something to be desired, but is not
> > always achievable.
>
>  okay: i will catch up on this bit, another time, because it is late
>  enough for me to be getting dizzy and appearing to be drunk.
>
>  this is one answer (and there are others i will write another time.
>  hint: automated code analysis tools, auto-parallelising tools, both
>  offline and realtime):

We don't need hints. We need actual performance statistics --
verifiable numbers that we can point to and say "Oh crap, we're losing."
or "Hah, we kick butt.", as the case may be.

>  watch what intel and amd do: they will support _anything_ - clutch at
>  straws - to make parallelism palable, why?  because in order to be
>  competitive - and realistically priced - they don't have any choice.

As stated earlier, I doubt they're in such dire straits as you predict.
Ultimately, the only reason why they need to advance their designs is to
be able to market it better. This means that truly innovative designs
may not be pursued because the up-front cost is too high.

There's a saying: "Let your competitor do your R&D for you."

>  plus, i am expecting the chips to be thrown out there (like
>  the X-Box 360 which has SIX hardware threads remember) and
>  the software people to quite literally _have_ to deal with it.
>
>  i expect the hardware people to go: this is the limit, this is what we
>  can do, realistically price-performance-wise: lump it, deal with it.
>
>  when intel and amd start doing that, everyone _will_ lump it.
>  and deal with it.

Hardware without software is just as useless as software without
hardware. Any argument from any side that goes along the lines of "deal
with it" can be countered in kind.

What this boils down to is that hardware people try to make their
products appealing to program to, from _both_ a speed and a usability
perspective. That's how they get mindshare.

>  ... why do you think intel is hyping support for and backing
>  hyperthreads support in XEN/Linux so much?

At the risk of stepping on some toes, I believe that hyperthreading is
going out of style, in favor of multi-core processors.

>  l.
>

In conclusion, you made claims that Linux is lagging behind. However,
such claims are rather useless without data and/or technical discussions
to back them up.

-Vadim Lobanov
