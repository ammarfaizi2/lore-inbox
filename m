Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133031AbRDLAjz>; Wed, 11 Apr 2001 20:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133033AbRDLAjf>; Wed, 11 Apr 2001 20:39:35 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:35365 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133031AbRDLAjZ>; Wed, 11 Apr 2001 20:39:25 -0400
Date: Wed, 11 Apr 2001 20:40:37 -0400
From: esr@thyrsus.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Elizabeth Chastain <chastain@cygnus.com>, davej@suse.de,
        hch@caldera.de, esr@snark.thyrsus.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
Message-ID: <20010411204037.B9081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Michael Elizabeth Chastain <chastain@cygnus.com>, davej@suse.de,
	hch@caldera.de, esr@snark.thyrsus.com,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com> <E14nT3T-0007gI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14nT3T-0007gI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 11, 2001 at 11:25:36PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> CML2 seems to have two other problems in my mind. Inability to parse
> the existing config files.

I gave upon that early for two reasons.  One was practical; Michael tried this
with mconfig, and (apparently) failed.  Or, at least, appeared to have decided
that path was not worth pursuing.

The other was the procedural vs. declarative problem.  I spent about a
month after the kbuild team originally encouraged me to tackle the
problem working on a design which I later labeled Thesis.  This was an
attempt to build a cleaned-up CML1, basically the existing language
without the syntactic warts.  I got as far as spinning up an
incomplete implementation that could check toy configurations.

But the design basically didn't work.  The problem is that a
procedural language imposes a kind of time order that makes it very
difficult to (a) do backtracking and (b) prove the correctness of your
result.  Perhaps a clearer way to put it is that configuration (like, say,
screen widget layout) is fundamentally a constraint problem rather
than a control problem.

A constraint problem needs a declarative rather than imperative
language, and it needs a baby reasoning engine to generate a
constraint-satisfying solution (Tk approaches screen-widget layout
this way; that's thye source of its power).  Neither of my strawman
designs had significant advantage over CML1 until I bit the bullet and
wrote a theorem prover to reason about timeless constraints.

>                        Also the draw ordering in the menu based
> config doesnt appear right. Menuconfig has a rather undocumented but
> very important property of doing roughly the right thing with
> screenreaders. Something to bear in mind when fixing the menu
> redrawing stuff.

Yes, I have plans for this.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Militias, when properly formed, are in fact the people themselves and
include all men capable of bearing arms. [...] To preserve liberty it is
essential that the whole body of the people always possess arms and be
taught alike, especially when young, how to use them.
        -- Senator Richard Henry Lee, 1788, on "militia" in the 2nd Amendment
