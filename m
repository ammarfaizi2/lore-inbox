Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbREPXhc>; Wed, 16 May 2001 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbREPXhW>; Wed, 16 May 2001 19:37:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31648 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261345AbREPXhK>; Wed, 16 May 2001 19:37:10 -0400
Date: Wed, 16 May 2001 17:37:00 -0600
Message-Id: <200105162337.f4GNb0j12743@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B030C76.40BB4558@transmeta.com>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
	<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
	<3B02D6AB.E381D317@transmeta.com>
	<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
	<3B02DD79.7B840A5B@transmeta.com>
	<200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
	<3B02F2EC.F189923@transmeta.com>
	<20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
	<3B02FBA6.86969BDE@transmeta.com>
	<200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
	<3B030C76.40BB4558@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> > We have this aliasing anyway. sg and sr are just one example. If you
> > care about conflicts, then make sure the drivers lock each other out.
> > It's got nothing to do with the mechanism to find out whether
> > something can behave like a CD-ROM or not.
> 
> No fscking way.  What you're saying "well, my design is broken, so
> break your driver even further."  You're suggesting prohibiting
> legal (and useful) operations because you're advocating an idiotic
> design to identify devices?  Give me a break.

Erm, let's start again. My central point is that you can use devfs
names to reliably figure out what kind of device a FD is, as a cleaner
alternative to comparing major numbers. Therefore, I'm challenging the
notion that you need to reserve magic major numbers in order to
distinguish devices.

I suspect you're thinking about a different problem, which is finding
out what a device can do. Implementing some kind of capability list
may well be a good approach to *that* problem. There are some details
to figure out, like how multiple drivers interact with each other.
They could be tricky.

Now, with the above said, what operations do you think I'm
prohibiting?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
