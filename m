Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLERmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTLERma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:42:30 -0500
Received: from alhya.freenux.org ([213.41.137.38]:17553 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S264314AbTLERmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:42:21 -0500
From: Mickael Marchand <marchand@kde.org>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Fri, 5 Dec 2003 18:42:15 +0100
User-Agent: KMail/1.5.93
References: <20031203204445.GA26987@gtf.org> <20031204081732.GC5376@launay.org> <3FCF4C32.5040101@pobox.com>
In-Reply-To: <3FCF4C32.5040101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312051842.26599.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

as I was too impatient, I wrote a quick hack for it.
Now I can see my drives on the 3114 controller.
RAID does not seem to work but I can access my SATA drives in normal mode.

hdparm gives a 57 Mb/s output.
I had no error/crash/corruption, it appears to work correctly.

It works on 2.4.23 and 2.6.0-test11 with libata.
basically, you just need to add the PCI id for 3114 just like 3112 in 
sata_sil.c, load the module and enjoy.
I presume 3112 and 3114 chips are mostly identical.

I have tested this on 2 Tyan motherboards with Sil 3114 inside

I can generate a patch in a few moments if you want it.

cheers,
Mik


Le Thursday 04 December 2003 16:01, Jeff Garzik a écrit :
> Arnaud Launay wrote:
> > Le Wed, Dec 03, 2003 at 03:44:46PM -0500, Jeff Garzik a écrit:
> >>Intel ICH5
> >>----------
> >>Summary:  No TCQ.  Looks like a PATA controller, but with a few
> >>added, non-standard SATA port controls.
> >
> > No plan to add the so-called "raid" capabilities of the 82801EB ?
>
> AFAIK the raid capabilities are entirely in software.
>
> And Intel just wrote and posted this component.  Look for "iswraid" in
> the linux-kernel archives.
>
> >>Silicon Image 3112
> >
> > Same here, is support for the 3114 underway ? Saw a message from
>
> Underway, but beyond that cannot comment :)
>
> 	Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0MN5yOYzc4nQ8j0RApGlAJ9WZxYY5wos+epXPsz4W/SPgOa7rQCfcKx1
lbblGOkp3DKKQUcRyN978us=
=KBJD
-----END PGP SIGNATURE-----
