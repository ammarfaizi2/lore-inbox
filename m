Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288136AbSACCYh>; Wed, 2 Jan 2002 21:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288137AbSACCY1>; Wed, 2 Jan 2002 21:24:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:43396
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288136AbSACCYO>; Wed, 2 Jan 2002 21:24:14 -0500
Date: Wed, 2 Jan 2002 21:10:38 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102211038.C21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102174824.A21408@thyrsus.com> <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>; from davej@suse.de on Thu, Jan 03, 2002 at 12:10:28AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> Given decoding DMI isn't going to get you 100% fool proof way of
> detecting slots (See posts on laptops/other usually-with-crap-bios
> hardware), I think you're barking up the wrong tree with this
> anyway.

But at the least I could have logic that says: if you get a DMI
readout and there are no ISA slots listed, *then* do useful deductions.
 
> And if you don't know what hardware you've got in the box your
> configuring a kernel for, its questionable that you should be
> doing so in the first place.

That's exactly the bad assumption we need to dynamite.  Vaporize.  Nuke.

It should be possible to build a correctly customized kernel without
opening the case of your machine.  It should be possible for
non-technical people to customize kernels.  Kernel customization
should present an interface based on what you want to *do* with the
machine, not the specific hardware inside it (because the configurator
is smart enough to map from the intended-function domain to the hardware-
specifics domain).

Think useability.  On Macintoshes, you configure a kernel by moving the 
equivalents of modules in and out of a system folder.  Users tune their
kernels by moving files around -- no muttering of elaborate incantations
required.  *That's* the direction we should be moving in; there is no 
good technical reason for the process to be anywhere near as arcane as
it is now.

I have spent eighteen months thinking very hard about this problem, and
whacking a significant piece of it with actual code.  So I can say this:
the reason linux kernel configuration is still a black art is *only* 
that lots of people *want it to be that way*.  We have elected to
treat kernel-building as an initiatory rite that separates the worthy
geeks from the unwashed technopeasant masses.

This is fine if all we want is to impress each other with our wizardliness.
If, on the other hand, we are serious about world domination, it's an
attitude that's got to go.  We have enough real technical problems to solve 
without surrounding Linux with a thicket of pseudo-problems.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

During waves of terror attacks, Israel's national police chief will
call on all concealed-handgun permit holders to make sure they carry
firearms at all times, and Israelis have many examples where
concealed permit holders have saved lives.
	-- John R. Lott
Conservatism is the blind and fear-filled worship of dead radicals.
