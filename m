Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbREOXvW>; Tue, 15 May 2001 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbREOXvM>; Tue, 15 May 2001 19:51:12 -0400
Received: from HIC-SR1.hickam.af.mil ([131.38.214.15]:10374 "EHLO
	hic-sr1.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S261715AbREOXuw>; Tue, 15 May 2001 19:50:52 -0400
Message-ID: <4CDA8A6D03EFD411A1D300D0B7E83E8F697321@FSKNMD07.hickam.af.mil>
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: "'Richard Gooch'" <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ingo.oeser@informatik.tu-chemnitz.de, torvalds@transmeta.com,
        neilb@cse.unsw.edu.au, jgarzik@mandrakesoft.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: RE: LANANA: To Pending Device Number Registrants
Date: Tue, 15 May 2001 23:49:40 -0000
X-Mailer: Internet Mail Service (5.5.2650.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, just correct me if I get this wrong, but this code is taking the LAST 2
characters of the device name and verifying that it is "cd".  Which would
mean that the standard states that "/dev/ginsucd" would be a CD-ROM drive?

That is why I feel a "name" of a device handle shouldnt set how a driver
operates in this fashion... if you make a small error in your compare, you
might try to eject a Ginsu Cabbage Dicer instead of a cdrom drive... OOPS!

	Sam Bingner

Alan Cox writes:
> > 	len = readlink ("/proc/self/3", buffer, buflen);
> > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > 		exit (1);
> 
> And on my box cd is the cabbage dicer whoops

Actually, no, because it's guaranteed that a trailing "/cd" is a
CD-ROM. That's the standard.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
