Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVJCBxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVJCBxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJCBxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:53:20 -0400
Received: from free.hands.com ([83.142.228.128]:45255 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932118AbVJCBxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:53:19 -0400
Date: Mon, 3 Oct 2005 02:53:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003015302.GP6290@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 06:20:38PM -0700, Vadim Lobanov wrote:

> On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> 
> > On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:
> >
> > > >  what if, therefore, someone comes up with an architecture that is
> > > >  better than or improves greatly upon SMP?
> > >
> > > Like NUMA?
> >
> >  yes, like numa, and there is more.
> 
> The beauty of capitalization is that it makes it easier for others to
> read what you have to say.
 
 sorry, vadim: haven't touched a shift key in over 20 years.

> >  basically the company has implemented, in hardware (a
> >  nanokernel), some operating system primitives, such as message
> >  passing (based on a derivative by thompson of the "alice"
> >  project from plessey, imperial and manchester university
> >  in the mid-80s), hardware cache line lookups (which means
> >  instead of linked list searching, the hardware does it for
> >  you in a single cycle), stuff like that.
> 
> That sounds awesome, but I have something better -- a quantum computer.
> And it's about as parallel as you're going to get anytime in the
> foreseeable future!

 :)

 *sigh* - i _so_ hope we don't need degrees in physics to program
 them...

> >  the message passing system is designed as a parallel message bus -
> >  completely separate from the SMP and NUMA memory architecture, and as
> >  such it is perfect for use in microkernel OSes.
> 
> You're making an implicit assumption here that it will benefit _only_
> microkernel designs. 

 ah, i'm not: i just left out mentioning it :)

 the message passing needs to be communicated down to manage
 threads, and also to provide a means to manage semaphores and
 mutexes: ultimately, support for such an architecture would
 work its way down to libc.


 and yes, if you _really_ didn't want a kernel in the way at all, you
 could go embedded and just... do everything yourself.

 or port reactos, the free software reimplementation of nt,
 to it, or something :)

 *shrug*.

> >  this company's hardware is kinda a bit difficult for most people to get
> >  their heads round: it's basically parallelised hardware-acceleration for
> >  operating systems, and very few people see the point in that.
> 
> That just sounds condescending.
 
 i'm very sorry about that, it wasn't deliberate and ... re-reading
 my comment, i should say that my comment isn't actually entirely true!

 a correction/qualification: the people whom the startup company
 contacted before they were put in touch with me had found that
 everybody they had previously talked to just simply _did_ not
 get it: this was presumably because of their choice of people
 whom they were seeking funding from were not technically up
 to the job of understanding the concept.

 i didn't mean to imply that _everyone_ - or more specifically the
 people reading this list - would not get it.

 sorry.

> >  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
> >  and to get any faster you _have_ to go parallel.
> 
> Sure, it's going to stop somewhere, but you have to be a heck of a
> visionary to predict that it will stop _there_. 

 okay, i admit it: you caught me out - i'm a mad visionary.

 but seriously.

 it won't stop - but the price of 90nm mask charges, at approx
 $2m, is already far too high, and the number of large chips
 being designed is plummetting like a stone as a result - from
 like 15,000 per year a few years ago down to ... damn, can't remember -
 less than a hundred (i think!  don't quote me on that!)

 when 90 nm was introduced, some mad fabs wanted to make 9
 metre lenses, dude!!! until carl zeiss were called in and
 managed to get it down to 3 metres.

 and that lens is produced on a PER CHIP basis.

 basically, it's about cost.

 the costs of producing faster and faster uniprocessors is
 getting out of control.

 i'm not explaining things very well, but i'm trying.  too many words,
 not concise enough, too much to explain without people misunderstanding
 or skipping things and getting the wrong end of the stick.

 argh.


> >  and the drive for "faster", "better", "more sales" means more and more
> >  parallelism.
> >
> >  it's _happening_ - and SMP ain't gonna cut it (which is why
> >  these multi-core chips are coming out and why hyperthreading
> >  is coming out).
> 
> "Rah, rah, parallelism is great!" -- That's a great slogan, except...
> 
> Users, who also happen to be the target of those sales, care about
> _userland_ applications. And the bitter truth is that the _vast_
> majority of userland apps are single-threaded. Why? Two reasons --
> first, it's harder to write a multithreaded application, and second,
> some workloads simply can't be expressed "in parallel". Your kernel
> might (might, not will) run like a speed-demon, but the userland stuff
> will still be lackluster in comparison.
> 
> And that's when your slogan hits a wall, and the marketing hype dies.
> The reality is that parallelism is something to be desired, but is not
> always achievable.

 okay: i will catch up on this bit, another time, because it is late
 enough for me to be getting dizzy and appearing to be drunk.

 this is one answer (and there are others i will write another time.
 hint: automated code analysis tools, auto-parallelising tools, both
 offline and realtime):

 watch what intel and amd do: they will support _anything_ - clutch at
 straws - to make parallelism palable, why?  because in order to be
 competitive - and realistically priced - they don't have any choice.

 plus, i am expecting the chips to be thrown out there (like
 the X-Box 360 which has SIX hardware threads remember) and
 the software people to quite literally _have_ to deal with it.

 i expect the hardware people to go: this is the limit, this is what we
 can do, realistically price-performance-wise: lump it, deal with it.

 when intel and amd start doing that, everyone _will_ lump it.
 and deal with it.

 ... why do you think intel is hyping support for and backing
 hyperthreads support in XEN/Linux so much?

 l.

