Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263282AbUKBI7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbUKBI7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291442AbUKBI7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:59:30 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:17599 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S385124AbUKBI6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:58:00 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and dmix plugin [u]
From: Christophe Saout <christophe@saout.de>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <1099284142.11924.17.camel@nosferatu.lan>
References: <1099284142.11924.17.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bjoNkaIKW3o75zomvhNI"
Date: Tue, 02 Nov 2004 09:57:52 +0100
Message-Id: <1099385872.21422.10.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bjoNkaIKW3o75zomvhNI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 01.11.2004, 06:42 +0200 schrieb Martin Schlemmer [c]:

> I have mailed below to alsa-user a time or two already, but no
> response as of yet, so I am wondering if anybody here have had
> similar issues.  Not much has changed, but I have also tried
> BMP, and alsa-player, with similar results.

I've tracked this down to what seems to be a bug in the libalsa dmix
code with mmap emulation. If the sound output was stopped for some
reason (stream paused or underrun) the library will accept more data
until the buffer is full but never restart the output.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D209


--=-bjoNkaIKW3o75zomvhNI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBh0wQZCYBcts5dM0RAmpjAJ9/p94kTAHRCViQ9gPAVUbLUKuJBgCeJuLk
+1+RGcP4KYERfMexkV3+Xak=
=+Nwa
-----END PGP SIGNATURE-----

--=-bjoNkaIKW3o75zomvhNI--

