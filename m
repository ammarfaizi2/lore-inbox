Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbREPS1S>; Wed, 16 May 2001 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREPS06>; Wed, 16 May 2001 14:26:58 -0400
Received: from [136.159.55.21] ([136.159.55.21]:26783 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261802AbREPS0s>; Wed, 16 May 2001 14:26:48 -0400
Date: Wed, 16 May 2001 12:25:59 -0600
Message-Id: <200105161825.f4GIPxN09278@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org,
        kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox)
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105160710.JAA01305@kufel.dom>
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697321@FSKNMD07.hickam.af.mil>
	<200105160710.JAA01305@kufel.dom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz writes:
> > 
> > OK, just correct me if I get this wrong, but this code is taking the LAST 2
> > characters of the device name and verifying that it is "cd".  Which would
> > mean that the standard states that "/dev/ginsucd" would be a CD-ROM drive?
> > 
> > That is why I feel a "name" of a device handle shouldnt set how a driver
> > operates in this fashion... if you make a small error in your compare, you
> > might try to eject a Ginsu Cabbage Dicer instead of a cdrom drive... OOPS!
> > 
> > 	Sam Bingner
> > 
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
> Sure, you no longer support /dev/sdcd (eighty-second SCSI disk)...

Then you haven't looked at what devfs actually does. *All* CD-ROMs
will have a trailing pathname component of "/cd". In other words, the
name of the leaf node in it's parent directory is "cd".
The FAQ describes this.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
