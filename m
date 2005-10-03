Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVJCUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVJCUWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJCUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:22:47 -0400
Received: from free.hands.com ([83.142.228.128]:14304 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932384AbVJCUWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:22:47 -0400
Date: Mon, 3 Oct 2005 21:22:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003202239.GE8548@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:20:46PM +0100, Jon Masters wrote:
> On 10/2/05, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 
> > as i love to put my oar in where it's unlikely that people
> > will listen, and as i have little to gain or lose by doing
> > so, i figured you can decide for yourselves whether to be
> > selectively deaf or not:
> 
> Hi Luke,

 hellooo jon.

> Haven't seen you since I believe you gave a somewhat interesting talk
> on FUSE at an OxLUG a year or more back. 

 good grief, that long ago?

> I don't think anyone here is
> selectively deaf, but some might just ignore you for such comments :-)
 
 pardon?  oh - yes, i'm counting on it, for a good signal/noise
 ratio.  sad to recount, the strategy ain't workin too well,
 oh well.  i've received about 10 hate mails so far, i _must_
 be doing _something_ right.


> > i think it safe to say that a project only nears completion
> > when it fulfils its requirements and, given that i believe that
> > there is going to be a critical shift in the requirements, it
> > logically follows that the linux kernel should not be believed
> > to be nearing completion.
> 
> Whoever said it was?
 
 istrc it was in andrew morton's interview / comments :)

> > the basic premise: 90 nanometres is basically... well...
> > price/performance-wise, it's hit a brick wall at about 2.5Ghz, and
> > both intel and amd know it: they just haven't told anyone.
> 
> But you /know/ this because you're a microprocessor designer as well
> as a contributor to the FUSE project?
 
 i have been speaking on a regular basis with someone who
 has been dealing for nearly twenty years now with processor
 designs (from a business perspective, for assessing high-tech
 companies for investment and recruitment purposes).  i have
 been fortunate enough to have the benefit of their experience
 in assessing the viability of chip designs.

 i haven't created silicon, but i've studied processor designs until
 they were coming out of my ears.

 ... you are mistaken on one point, though: my work on fuse proved
 unsuccessful because i was a) running out of time b) running out of
 reasons to continue (the deal fell through) c) i ran into an error
 message in selinux: the "please try later" one, which flummoxed me but
 i now believe to be due to a crash in the userspace stuff.  maybe.
 urk.  it's been a year.

 anyway, we digress.



 

> > anyone (big) else has a _really_ hard time getting above 2Ghz,
> > because the amount of pipelining required is just... insane
> > (see recent ibm powerpc5 see slashdot - what speed does it do?
> > surprise: 2.1Ghz when everyone was hoping it would be 2.4-2.5ghz).
> 
> I think there are many possible reasons for that and I doubt slashdot
> will reveal any of those reasons. 

 probably :)

> The main issue (as I understand it)
> is that SMT/SMP is taking off for many applications and manufacturers
> want to cater for them while reducing heat output - so they care less
> about MHz than about potential real world performance.

 pipelining.  pipelining.  latency between blocks.

 halving the microns should quadruple the speed: the distance is halved
 so light has half the distance to travel and ... darn, can't remember
 the other reason for the other factor-of-two.

 if the latency between sub-blocks is large (or becomes
 relevant), then it doesn't matter _what_ microns you attempt to
 run in, your design will asymtote towards an upper speed limit.

 if you're having to pipeline down to the level of 2-bit adders with 16
 stages in order to do 32-bit adds at oh say 4ghz, you _know_ you're in
 trouble.


> > so, what's the solution?
> 
> > well.... it's to back to parallel processing techniques, of course.
> 
> Yes. Wow! Of course! Whoda thunk it? I mean, parallel processing!
> Let's get that right into the kern...oh wait, didn't Alan and a bunch
> of others already do that years ago? Then again, we might have missed
> all of the stuff which went into 2.2, 2.4 and then 2.6?

 jon, jon *sigh* :)  i meant _hardware_ parallel processing - i wasn't
 referring to anything led or initiated by the linux kernel, but instead
 to the simple conclusion that if hardware is running out of steam in
 uniprocessor (monster-pipelined; awful-prediction;
 let's-put-five-separately-designed-algorithms-for-divide-into-the-chip-and-take-the-answer-of-the-first-unit-that-replies sort of design)
 then chip designers are forced to parallelise.
 
> > well - intel is pushing "hyperthreading".
> 
> Wow! Really? I seem to have missed /all/ of those annoying ads. But
> please tell me some more about it!
 
 make me.  nyer :)

> > and, what is the linux kernel?
> 
> > it's a daft, monolithic design that is suitable and faster on
> > single-processor systems, and that design is going to look _really_
> > outdated, really soon.
> 
> Why? I happen to think Microkernels are really sexy in a Computer
> Science masturbatory kind of way, but Linux seems to do the job just
> fine in real life. Do we need to have this whole
> Microkernel/Monolithic conversation simply because you misunderstood
> something about the kind of performance now possible in 2.6 kernels as
> compared with adding a whole pointless level of message passing
> underneath?

 i'll answer rik's point later when i've thought about it some
 more: in short, rik has concluded that because i advocated
 message passing that somehow his SMP improvement work
 (isolating data structures) is irrelevant - far from it: such
 improvements would prove, i believe, to be a significant additional
 augmentation, unburdening both a monolithic _and_ a microkernel'd linux
 kernel from some of the cru-joze nastiness of SMP.

 if there are better ways, _great_.

 love to hear them.

 l.
