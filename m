Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTCOSMS>; Sat, 15 Mar 2003 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCOSMP>; Sat, 15 Mar 2003 13:12:15 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61106 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261520AbTCOSJy>;
	Sat, 15 Mar 2003 13:09:54 -0500
Message-Id: <200303150103.h2F13gj1001131@eeyore.valparaiso.cl>
To: Daniel Phillips <phillips@arcor.de>
cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Thu, 13 Mar 2003 03:00:54 +0100."
             <20030313015658.4008E414D3@mx01.nexgo.de> 
Date: Fri, 14 Mar 2003 21:03:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:
> On Wed 12 Mar 03 21:37, Horst von Brand wrote:
> > Daniel Phillips <phillips@arcor.de> said:

[...]

> > Versioned how? Have different versions of a changeset? Don't see the point.

> So that fix.foobar-2.5.64 that you got from davem applies to 2.5.64 that
> you got from Linus, and a later version of it, e.g., with some macro
> respelled by you (in line with Linus's recent changes) applies correctly
> to 2.5.69.

This is "keep the original change + the merged change". Sounds logical, but
OTOH if it is Linus' tree, you'll add _tons_ of irrelevant (rejected/fixed)
changes. Plus why should I send out changes that can be gotten directly?

At the very least, I'd need the ability to throw away original changes
deemed irrelevant.

> > ...The changeset should be seen as a (conceptually atomic)
> > change to the _local_ repository.

> No argument there, and no inconsistency.  Well, except that it's entirely
> ok to "soften" a changeset by adding context and send it off to somebody
> else.

I don't see the need to decide on "softening". A changeset sent around will
get applied to different trees (that is its idea, anyway), so it has to be
"soft" (like patches carry context, while e.g. RCS doesn't keep context
internally).

>       That somebody else may need to massage it to get it to apply,

Merging.

>                                                                     and
> so they end up with the exact changeset you sent them, which conflicts,
> and their own version of it, which works.  Then, when somebody asks them
> to forward the same changeset , they've got two chances to send one that
> works on the first try.  And so on forth.

If they follow my tree (I've got no clue of why somebody would want to do
that ;-), my change is fine. If not, they'll be following another tree, and
my version of the change isn't relevant.

[...]

> Yes, but I fail to see why that means you can't send the thing on to someone 
> else to accomplish something useful.  This has always worked well with 
> patches, why did it stop working with changesets?

Where did you get patches? Either from the original author directly, or
from somebody who fixed it somehow. With the ubiquitous Internet, there
should be little need to pass changesets around.

> > >                                  and recombined.

> > Recombined how? Take changesets A and B, create C from half of each? Better
> > keep A, B, and create another one that gets rid of the junk.
> 
> Yes of course.  Why would you throw any changeset away?  It's all good data. 
> C would be a recombination of A and B, and all of them end up in the 
> repository, though not necessarily all applied.

I'd prefer applying A and B and then making D that fixes up the mess,
instead of creating an artificial C. That is the way people do the work,
plus A, B, D will make sense even for A's author or some third party who
picked A and B up.

[...]

> > > slightly differing changesets from a variety of sources, *merge
> > > the changesets* and carry the result forward in my repository.  This
> > > way, no changeset needs to lose its identity until I explicity want it
> > > to.

> > This is doing merging among changesets, not merging changesets into the
> > repository.

> No, I meant merging the changesets into the repository.  Then the system 
> regenerates the changeset, and understands it to be a descendant version of 
> the original changeset.  The result is a "merged" changeset, i.e., one that 
> applies correctly, whereas the original didn't.

Why do this? Just merge A, B, C in (fixing "rejects"), then fix up the
result (create D). You can then ship (your versions of) A, B, C, plus D

> > I'd prefer the later (as it reduces this special-purpose
> > operation to others that have to be there anyway).
> 
> I suppose that we're violently agreeing, and just haggling over
> terminology.

Maybe; but it makes sense to get the set of basic operations and their
meaning crystal clear, then hash out what non-basic operations can be faked
in terms of them (without going too much against the natural flow of work).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
