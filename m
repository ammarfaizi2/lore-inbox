Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283097AbRLDPlR>; Tue, 4 Dec 2001 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283096AbRLDPlJ>; Tue, 4 Dec 2001 10:41:09 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:678 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283075AbRLDPky>; Tue, 4 Dec 2001 10:40:54 -0500
Date: Tue, 4 Dec 2001 08:40:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@caldera.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204154021.GG17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204142958.A14069@caldera.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 02:29:58PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 04, 2001 at 08:16:40AM -0500, Eric S. Raymond wrote:
> > N separate implementations means N dialects and N**2 compatibility problems.
> > Nicer just to have *one* parser, *one* compiler, and *one* service class that
> > supports several thin front-end layers, yes?  No?
> 
> Oh man.  When you think one implementation of a 'standard' is better then
> multiple go to the MS world.

Wouldn't multiple tools which don't quite work to a 'standard' better
represent the MS world?  Which is what all of the cml1 tools do.

> > > All of these tools just require the runtime contained in the LSB and no
> > > funky additional script languages.  Also none needs a binary intermediate
> > > representation of the config.
> > 
> > I quote Linus at the 2.5 kernel summit: "Python is not an issue."
> > Unless and until he changes his mind about that, waving around this
> > kind of argument is likely to do your case more harm than good.
> 
> For me (and others) it is an issues.

Why?

> > If you want to re-open the case for saving CML1, you'd be better off
> > demonstrating how CML1 can be used to (a) automatically do implied 
> > side-effects when a symbol is changed,
> 
> With mconfig it can be implemented easily - I don't see the point in
> doing it, though.

To show that CML1 doesn't need to die yet.

> > (b) guarantee that the user
> > cannot generate a configuration that violates stated invariants, and 
> 
> What do you mean with that?

That you can't turn on CONFIG_FOO_BAR unless CONFIG_FOO is on.  This is
getting at things like USB V4L devices which need CONFIG_USB and
CONFIG_VIDEODEV set to !n.  This is done poorly in CML1.

> > (c) unify the configuration tree so that the equivalents of arch/*
> > files never suffer from lag or skew when an architecture-independent
> > feature is added to the kernel.
> 
> One toplevel config file can be implemented in CML1 easily,
> using mconfig or the old and ugly tools, it's just a question of changeing
> the rule base in tree.

Lots of changing of the Config.in files.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
