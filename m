Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbREPX1M>; Wed, 16 May 2001 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbREPX1C>; Wed, 16 May 2001 19:27:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262134AbREPX0q>; Wed, 16 May 2001 19:26:46 -0400
Message-ID: <3B030C76.40BB4558@transmeta.com>
Date: Wed, 16 May 2001 16:25:42 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
		<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<3B02D6AB.E381D317@transmeta.com>
		<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
		<3B02DD79.7B840A5B@transmeta.com>
		<200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
		<3B02F2EC.F189923@transmeta.com>
		<20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
		<3B02FBA6.86969BDE@transmeta.com> <200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> H. Peter Anvin writes:
> > Ingo Oeser wrote:
> > >
> > > We do this already with ide-scsi. A device is visible as /dev/hda
> > > and /dev/sda at the same time. Or think IDE-CDRW: /dev/hda,
> > > /dev/sr0 and /dev/sg0.
> > >
> > > All at the same time.
> > >
> >
> > ... and if you don't know about this funny aliasing, you get screwed.
> > This is BAD DESIGN, once again.
> 
> We have this aliasing anyway. sg and sr are just one example. If you
> care about conflicts, then make sure the drivers lock each other out.
> It's got nothing to do with the mechanism to find out whether
> something can behave like a CD-ROM or not.
> 

No fscking way.  What you're saying "well, my design is broken, so break
your driver even further."  You're suggesting prohibiting legal (and
useful) operations because you're advocating an idiotic design to
identify devices?  Give me a break.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
