Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135968AbRDTQg5>; Fri, 20 Apr 2001 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135966AbRDTQgr>; Fri, 20 Apr 2001 12:36:47 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:39920
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S135968AbRDTQgd>; Fri, 20 Apr 2001 12:36:33 -0400
Date: Fri, 20 Apr 2001 12:35:12 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Tom Rini <trini@kernel.crashing.org>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, <parisc-linux@parisc-linux.org>
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is
 anyone paying attention?
In-Reply-To: <20010420085148.V13403@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0104201206250.12186-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Tom Rini wrote:

> On Fri, Apr 20, 2001 at 10:59:34AM -0400, Eric S. Raymond wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > > well, though.  One is the kind I'm bumping into right now, where
> > > > somebody legitimately needs to make small (almost trivial) changes
> > > > scattered all through the tree.
> > >
> > > Yep. But such changes are rare. Or should be.
> >
> > Knowing that doesn't help me much, since I'm trying to fix up a global
> > namespace that touches everybody :-(.
>
> Which does boil down to having to work with trees other than Linus or
> Alans.  Remember, the official tree is not always the up-to-date tree,
> or in the case of other arches, the most relevant tree.  But if you send
> something off to a maintainer, there's a good chance (if they're still active)
> they'll do what you ask, and it'll get to Linus/Alan the next time they sync.
> As long as the problem gets fixed, it shouldn't be as important if it's fixed
> in everyones tree right now, or in a release or two.  If it's some sort of
> huge bug it just might get fixed sooner.

Guys,

There is kind of a ridiculous situation here where people want to withhold
their own changes in their own trees for all good reasons until it is mature
and stable enough to be fed upstream in the appropriate way, while insisting
for Linus' tree to remain incomplete and inconsistent.  And we're not
talking about deep architectural changes here -- only about configure
symbols and help text.

Why not having everybody's tree consistent with themselves and have whatever
CONFIGURE_* symbols and help text be merged along with the very code it
refers to?  It's worthless to have config symbols be merged into Linus' or
Alan's tree if the code isn't there (yet).  It simply makes no sense.

This might shift some of the namespace consistency work to architecture
maintainers (which is a good thing IMHO) and establish the basis for yet a
more sanitized kernel.org tree at all times for before and after any
further patches are merged.

I'm myself maintainer of a subarchitecture and removing currently
unreferenced SA1100 config symbols from the official Linux tree would
probably give me a one-time effort to bring them back in my tree but this is
certainly for a saner code/namespace distribution in general.  Why should
the symbols I maintain remain there if I'm not ready yet to sync up the code
they refer to?

Hey this is only CONFIG_ symbols after all.  If they get removed now, they
will only reappear _with_ the code they refer to eventually when it'll get
merged.


Nicolas

