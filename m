Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752760AbWKCHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbWKCHpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 02:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbWKCHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 02:45:10 -0500
Received: from holoclan.de ([62.75.158.126]:13743 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1752760AbWKCHpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 02:45:08 -0500
Date: Fri, 3 Nov 2006 08:44:47 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.18] Suspend to ram and SATA
Message-ID: <20061103074447.GB23150@gimli>
Mail-Followup-To: Maciej Rutecki <maciej.rutecki@gmail.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <454A61B0.9010306@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <454A61B0.9010306@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Nov 02, 2006 at 10:22:56PM +0100, Maciej Rutecki
	wrote: > I have problem with suspend to ram, and my SATA drive. When I
	try: > > echo mem > /sys/power/state > > system goes standby, but when
	doing the resume it > would come back and have I/O errors similar like
	this ((copied from > paper notes, the disk is no longer writable when
	the error happens) > > kernel: journal commit I/O error > end_request:
	I/O error, dev sda, sector xxxxxxxx > sd 0:0:0:0: SCSI error return
	code: 0xxxxxx > > Problem is similar like this: >
	http://marc.theaimsgroup.com/?l=linux-kernel&m=111409309804068&w=2 >
	http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux >
	http://lkml.org/lkml/2005/9/23/97 > > I test it in 2.6.18.1 (with
	initrd) and 2.6.18 (with and without initrd). [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2006 at 10:22:56PM +0100, Maciej Rutecki wrote:
> I have problem with suspend to ram, and my SATA drive. When I try:
>=20
> echo mem > /sys/power/state
>=20
> system goes standby, but when doing the resume it
> would come back and have I/O errors similar like this ((copied from
> paper notes, the disk is no longer writable when the error happens)
>=20
> kernel: journal commit I/O error
> end_request: I/O error, dev sda, sector xxxxxxxx
> sd 0:0:0:0: SCSI error return code: 0xxxxxx
>=20
> Problem is similar like this:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D111409309804068&w=3D2
> http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux
> http://lkml.org/lkml/2005/9/23/97
>=20
> I test it in 2.6.18.1 (with initrd) and 2.6.18 (with and without initrd).

for 2.6.18 there is a patch which makes AHCI sata behave correctly on
suspend/resume. it was originally written by Forrest Zhao and is now
included in the 2.6.19-rcX tree

you can apply the libata patch that went into 2.6.18-mm1. it is to be found
in the broken-out dir of 2.6.18-mm1 and named
git-libata-all-2.6.18-mm1.patch

when applying it to 2.6.18.1 you will get three rejects because the patches
are already in 2.6.18.1. simply say 'n' -> 'n' on those three.=20


>=20
> Hardware: HP/Compaq nx6310
>=20
> --=20
> Maciej Rutecki <maciej.rutecki@gmail.com>
> http://www.unixy.pl
> LTG - Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/wiki/)











gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty=20
	    to obtain a little temporary safety=20
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=3Dget&search=3D0xF1AAD37D

ICQ UIN: 33588107

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSvNvR1ITOvGq030RAs/xAJ9hK4fvvLD7eFB5vbvD7nGIK9kSFwCgpwlC
XQ5oZYHNWvEYF2o12HnbxlE=
=YVak
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
