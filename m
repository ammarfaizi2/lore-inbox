Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWAGLww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWAGLww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 06:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWAGLww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 06:52:52 -0500
Received: from mail.gmx.de ([213.165.64.21]:20457 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030290AbWAGLwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 06:52:51 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 12:53:09 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107115309.GA20748@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107110004.GU3389@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20060107110004.GU3389@suse.de>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sa, Jan 07, 2006 at 12:00:04 +0100, Jens Axboe wrote:
>=20
> One more question - when using ide-scsi, does it use the SG_IO ioctl to
> rip cdda, or does it use CDROMREADAUDIO like I'm assuming it does with
> ide-cd? Is there a way to force SG_IO usage with a given device in
> cdparanoia? If so, please try ide-cd with SG_IO usage instead.
>=20

There's one reference in cdparanoia to CDROMREADAUDIO, none at all to SG_IO:

interface/cooked_interface.c line 89:

  do {
    if((err=3Dioctl(d->ioctl_fd, CDROMREADAUDIO, &arg))){
      if(!d->error_retry)return(-7);
      switch(errno){
      ...

http://svn.xiph.org/trunk/cdparanoia/interface/cooked_interface.c

Sebastian

--=20
"When the going gets weird, the weird turn pro." (HST)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDv6ulTWouIrjrWo4RAgltAJ47mvfCmKqsZ7DrSRitP8ZOyBVzqACfZdj3
KF1xt8l1CyktV7E/D79rCSY=
=EFg2
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

