Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSGBPM4>; Tue, 2 Jul 2002 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGBPMz>; Tue, 2 Jul 2002 11:12:55 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55211
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316794AbSGBPMy>; Tue, 2 Jul 2002 11:12:54 -0400
Date: Tue, 2 Jul 2002 08:12:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020702151206.GK20920@opus.bloom.county>
References: <20020701181228.GF20920@opus.bloom.county> <Pine.LNX.3.96.1020702103924.27954A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020702103924.27954A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 10:46:56AM -0400, Bill Davidsen wrote:
> On Mon, 1 Jul 2002, Tom Rini wrote:
> 
> > On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
> > 
> > > What's the issue?
> > 
> > a) We're at 2.4.19-rc1 right now.  It would be horribly
> > counterproductive to put O(1) in right now.
> > b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
> > to 2.4, it'd be just like 2.5 :)
> > c) I also suspect that it hasn't been as widley tested on !x86 as the
> > stuff currently in 2.4.  And again, 2.4 is the stable tree.
> 
> Since 2.5 feature freeze isn't planned until fall, I think you can assume
> there will be releases after 2.4.19...

I sure hope so, I've got a whole bunch of PPC stuff that's been around
for ages now that just might make it into 2.4.20 :)

> Since it has been as heavily tested
> as any feature not in a stable release kernel can be, there seems little
> reason to put it off for a year, assuming 2.6 releases within six months
> of feature freeze.

Sure there is.  It's called stopping feature creep.  O(1) is a nice
feature, but so is the bio stuff, the initcall levels, and other things
in 2.5 as well.  But should we back port all of these to 2.4 as well?

> Stable doesn't mean moribund, we are working Andrea's VM stuff in, and
> that's a LOT more likely to behave differently on hardware with other word
> length.

Being someone who actually works on !x86 hardware all of the time, I'm
slightly warry of Andrea's VM work as well.  But it's also something
which has been split into numerous small chunks, so hopefully problems
will be spotted.

> Keeping inferior performance for another year and then trying to
> separate 2.5 other unintended features from any possible scheduler issues
> seems like a reduction in stability for 2.6.

It's no more of a reduction in stability than not back porting
everything else.  And making things stable is why eventually Linus says
'enough' and kicks out 2.stable.0-test1.  Anyhow, since this isn't a
subsystem backport, but part of the core kernel, I would think that you
could only get limited use out of the testing (I remember reading some
of the O(1) announcments for 2.4.then-current and reading about small
bugs that weren't in the 2.5 version).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
