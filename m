Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261989AbREPSXs>; Wed, 16 May 2001 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREPSXj>; Wed, 16 May 2001 14:23:39 -0400
Received: from [136.159.55.21] ([136.159.55.21]:23967 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262007AbREPSXY>; Wed, 16 May 2001 14:23:24 -0400
Date: Wed, 16 May 2001 12:22:50 -0600
Message-Id: <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven writes:
> On Tue, 15 May 2001, Richard Gooch wrote:
> > Alan Cox writes:
> > > > 	len = readlink ("/proc/self/3", buffer, buflen);
> > > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > > 		exit (1);
> > > 
> > > And on my box cd is the cabbage dicer whoops
> > 
> > Actually, no, because it's guaranteed that a trailing "/cd" is a
> > CD-ROM. That's the standard.
> 
> Then  check for `/cd' at the end instead of `cd' :-)

Argh! What I wrote in text is what I meant to say. The code didn't
match. No wonder people seemed to be missing the point. So the line of
code I actually meant was:
	if (strcmp (buffer + len - 3, "/cd") != 0) {

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
