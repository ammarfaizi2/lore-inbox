Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUKCByW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUKCByW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbUKCByW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:54:22 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:16825 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261320AbUKCByE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:54:04 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and dmix plugin [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Christophe Saout <christophe@saout.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <200411021340.03164.jk-lkml@sci.fi>
References: <1099284142.11924.17.camel@nosferatu.lan>
	 <1099385872.21422.10.camel@leto.cs.pocnet.net>
	 <200411021340.03164.jk-lkml@sci.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LsE3kY+FVOYc1G1WrG0k"
Date: Wed, 03 Nov 2004 03:53:54 +0200
Message-Id: <1099446834.11924.34.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LsE3kY+FVOYc1G1WrG0k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-02 at 13:40 +0200, Jan Knutar wrote:
> On Tuesday 02 November 2004 10:57, Christophe Saout wrote:
>=20
> > I've tracked this down to what seems to be a bug in the libalsa dmix
> > code with mmap emulation. If the sound output was stopped for some
> > reason (stream paused or underrun) the library will accept more data
> > until the buffer is full but never restart the output.
>=20
> Strangely, I've observed these kinds of "Hangs" with bmp and mplayer,
> without mmap mode enabled in either. Also using dmix as in the other
> reports here. Could of course be some third application using alsa in
> mmap mode, I suppose.
>=20
> Unfortunately, I have no strace to offer right now as the bug is happenin=
g
> randomly and I haven't been able to find any method by which to reproduce
> it.
>=20
> What's strange is that almost always when it happens, either mplayer or
> beep-media-player will have an extra forked process. As bmp is threaded
> and I shouldn't see more than one bmp in ps aux on NPTL, this seemed a
> bit strange. Strace on the process that looked more recent makes it usual=
ly
> wake up from deep sleep, and then it promptly vanishes after only a few s=
yscalls.
> The strace itself seems to wake it up... After the 'extra' process is gon=
e,
> sound output usually resumes, but not always. Other times strace only rev=
eals
> the app doing nanosleep's and nothing else, and the only solution is to k=
ill
> all apps that might've touched sound.
>=20

I cannot say that I have seen this.  It always just resumes fine if I
click on play again, and I cannot remember it having an extra process.
But then I mostly tried it with mmap enabled (as without it also had
this issue), so I will have a look without mmap, and report if similar
issues happens this side.


Thanks,

--=20
Martin Schlemmer


--=-LsE3kY+FVOYc1G1WrG0k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiDoyqburzKaJYLYRAqOIAJ468tActiuIi+1qDpbQFwUUt/cxHgCfUdao
qOgVsEWKPeIJlbTwViJHpOk=
=yRdu
-----END PGP SIGNATURE-----

--=-LsE3kY+FVOYc1G1WrG0k--

