Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUATI6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUATI6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:58:11 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:24971 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265350AbUATI6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:58:05 -0500
Date: Tue, 20 Jan 2004 08:58:00 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: manu <hislen@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiI2112 + Seagate + nFroce2: no DMA!
Message-ID: <20040120085800.GB31330@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	manu <hislen@mindspring.com>, linux-kernel@vger.kernel.org
References: <3E1282EF.30300@mindspring.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <3E1282EF.30300@mindspring.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2002 at 09:55:59PM -0800, manu wrote:

   Incidentally, did you know that the date on your computer is very,
very wrong?

> I'm about to give up on my SATA drive as I can't get it to work properly.
> So I thought I may try asking the experts before falling back to PATA.
> 
> I have seen many mails reporting the same issue, some of them 6-month old:
> 
> - SATA drive comes up in pio mode, not in dma
> - trying to turn on dma with hdparm is a nightmare: I/O errors, crash 
> with data corruption... I tried both:
> 
>  hddarm -d1 /dev/hde
> 
> and:
> 
>  hdparm -u1 -c3 -d1 -X66 /dev/hde
> 
> crash in both cases :-((
> 
> 
> Here's my equipment:
> 
> 
> ABIT AN7 motherboard (nForce2 chipset, SiI3112 SATA controller)
> AMD Athlon XP 2600+ (+ 512 DDR / 400 MHz)
> SATA HD Seagate Barracuda 160 Gb
> 
> The SATA HD is my only drive. The only thing connected to my IDE 
> controllers is a DVD/CD combo.
> 
> Running Linux Redhat 9.0
> kernel 2.4.20-28.9
  ^^^^^^^^^^^^^^^^^^
   This is your problem. There have been a number of bug-fixes to the
SiI drivers since 2.4.20. Try it again with a newer kernel -- such as
2.4.24.

> I've been googling for days now and could not come accross a solution, 
> on the contrary I came under the impression that the combination of 
> SiI3112 +and Seagate was doomed.

   Not so. I have a SiI3112 controller and a 120GiB Seagate drive, and
they work very well together. I'm using 2.6.1, although 2.4.23 also
worked well for me.

[snip]
> Isn't there a solution??
> 
> I am willing to try patches of experimental code. At this point I am 
> looking at reinstalling everything on a PATA drive anyway, so  I have 
> nothing to loose.

   Try using 2.4.24 or 2.6.1.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
           --- All hope abandon,  Ye who press Enter here. ---           

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADO2YssJ7whwzWGARAiQCAKCaT/ksPx23udVjqxhiTkAWKA+4ewCgrx2M
PiO6Mr8k/JK4QoB6mrnv0R4=
=G+SO
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
