Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVARBBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVARBBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVARBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:01:23 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:54153 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261375AbVARBBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:01:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pL8b5bkgqAfL8nm8lEMTWXyuS3BZGXvP7Ls2DmmBpO1/CkH8hTwhTEK/vXYylw93/cUe4aoHr5BX2lZRtg4Mmbn5zPHxTC0Oc0StVNqB6uV5j7XaQY1MmFENW80SzVQE+24i+mLX+j8ayug9xjZRRj3uIMhn3OeyMMHC4Lxcgjc=
Message-ID: <311601c9050117170161e65147@mail.gmail.com>
Date: Mon, 17 Jan 2005 18:01:07 -0700
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
Cc: linux-kernel@vger.kernel.org, Erik Steffl <steffl@bigfoot.com>
In-Reply-To: <200501170914.46344.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105830698.15835.16.camel@localhost.localdomain>
	 <41EB3F80.5050400@tmr.com> <41EB5ECC.1020105@bigfoot.com>
	 <200501170914.46344.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we don't use security torx screws, we use normal ones on our boards.

I wouldn't recommend swapping boards, since the code stored on the
physical media, the opti tables, and the asic on the board were all
processed together at one point and are specific to each other.  The
new board may not work properly with the heads in the other drive, and
could even cause damage, if both drives were several sigma to opposite
sides of each other in the spectrum of passing drives, or had a
different head vendor, etc.

If the data already appears lost and you've run out of other options,
it may prove useful to attempt writing to the entire device without
attempting reads.  If the drive then reads normally after that, the
damage was probably incurred in some transient fashion (excessive
vibration or heat, etc) and the replacement data may eliminate the
failures.

Either way, however, I would probably recommend just RMA'ing the
drives.  We should be able to get you a replacement in a few days from
the time you fill out the form.

--eric


On Mon, 17 Jan 2005 09:14:46 +0000, Mark Watts <m.watts@eris.qinetiq.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > Bill Davidsen wrote:
> > > Erik Steffl wrote:
> > >> Alan Cox wrote:
> > >>> On Sad, 2005-01-15 at 20:25, Erik Steffl wrote:
> > >>>>   I got these errors when accessing SATA disk (via scsi):
> > >>>>
> > >>>> Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59
> > >>>> host_stat 0x21
> > >>>> Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady
> > >>>> SeekComplete DataRequest Error }
> > >>>> Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }
> > >>>
> > >>> Bad sector - the disk has lost the data on some blocks. Thats a
> > >>> physical disk failure.
> > >>
> > >>   what's somewhat weird is that the disk _seemed_ OK (i.e. no errors
> > >> that I would notice, nothing in the syslog) and then suddenly the disk
> > >> does not respond at all, I tried dd_rescue and it ran for hours (more
> > >> than a day) and it rescued absolutely nothing. Is it possible that the
> > >> disk surface is OK but the electronics went bad? Is there anything
> > >> that can be done if that's the case? (I have another disk, same model).
> > >
> > > You probably void your waranty on both drives if you swap the control
> > > board, it may require special tools you don't have, and I have done it
> > > in the past. Can you get to the point where it fails and cool it with a
> > > shot of freon (or whatever is politically correct these days)? May be
> > > thermal, in which case you run it until you back it up, then waranty it.
> >
> >    it does not respond at all (right after I boot up the computer),
> > doesn't seem to be heat related. It is completely unreadable, I ran
> > rr_rescue on it for a long time, it didn't read absolutely anything. It
> > requires a star-shaped screwdriver, are those available somewhere?
> 
> Those are Torx drivers. You may need the 'security' version if the screws have
> a pin in the middle (utterly pointless since both types of driver are
> publicly available).
> 
> Mark.
> 
> - --
> Mark Watts
> Senior Systems Engineer
> QinetiQ Trusted Information Management
> Trusted Solutions and Services group
> GPG Public Key ID: 455420ED
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFB64IGBn4EFUVUIO0RAugkAJ4kmCDOsILhZLISR75ml2gch528AQCbB56r
> UJWFiujxQxI95TZEhIOKoWc=
> =7AkY
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
