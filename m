Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262066AbREPUzM>; Wed, 16 May 2001 16:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbREPUzC>; Wed, 16 May 2001 16:55:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4256 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262091AbREPUyw>; Wed, 16 May 2001 16:54:52 -0400
Date: Wed, 16 May 2001 14:54:36 -0600
Message-Id: <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B02DD79.7B840A5B@transmeta.com>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
	<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
	<3B02D6AB.E381D317@transmeta.com>
	<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
	<3B02DD79.7B840A5B@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Richard Gooch wrote:
> > 
> > H. Peter Anvin writes:
> > > Richard Gooch wrote:
> > > > Argh! What I wrote in text is what I meant to say. The code didn't
> > > > match. No wonder people seemed to be missing the point. So the line of
> > > > code I actually meant was:
> > > >         if (strcmp (buffer + len - 3, "/cd") != 0) {
> > >
> > > This is still a really bad idea.  You don't want to tie this kind of
> > > things to the name.
> > 
> > Why do you think it's a bad idea?
> 
> Because you are now, once again, tying two things that are
> completely and utterly unrelated: device classification and device
> name.  It breaks every time someone comes out with a new device
> which is "kind of like an old device, but not really," like
> CD-writers (which was kind-of-like WORM, kind-of-like CD-ROM) and
> DVD (kind-of-like CD)...

But all devices which export a CD-ROM interface will do so. So the
device node that is associated with the CD-ROM driver will export
CD-ROM semantics, and the trailing name will be "/cd".

Other interfaces a device exports, such as a CD-RW, appear as a
different device node ("generic" for SCSI, because we have no CD-RW
classification at this point).

My scheme works already, and works reliably. Nothing had to be done to
support the CD-ROM interface to CD-RW and DVD devices.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
