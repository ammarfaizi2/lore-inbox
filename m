Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbREOW3I>; Tue, 15 May 2001 18:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbREOW26>; Tue, 15 May 2001 18:28:58 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51356 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261657AbREOW2n>; Tue, 15 May 2001 18:28:43 -0400
Date: Tue, 15 May 2001 16:28:26 -0600
Message-Id: <200105152228.f4FMSQw02343@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rgooch@ras.ucalgary.ca (Richard Gooch),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zn4x-0003CZ-00@the-village.bc.nu>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
	<E14zn4x-0003CZ-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > > 		exit (1);
> > > 
> > > And on my box cd is the cabbage dicer whoops
> > 
> > Actually, no, because it's guaranteed that a trailing "/cd" is a
> > CD-ROM. That's the standard.
> 
> And its back to /dev/disc versus /dev/disk. Dont muddle user picked
> file names with kernel namespace bindings please.

Even if we have per-device filesystems, we are going to have the same
issue, in one form or another. If we have a "/devicetype" trailing
component added on, then somewhere it has to report "CD-ROM" or "cd"
or "Compact Disc".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
