Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTL0DNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbTL0DNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:13:10 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:45250
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265303AbTL0DNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:13:00 -0500
Date: Fri, 26 Dec 2003 19:12:57 -0800
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
Message-ID: <20031227031257.GG12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FECD2FB.4070008@ntlworld.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <3FECD2FB.4070008@ntlworld.com>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2003 at 12:31:55AM +0000, Matt wrote:
> If you are on debian i have noticed recently that gnomevfs (on unstable)=
=20
> requires famd. famd will open /cdrom after it is mounted and run a dir=20
> notification on it. now i think famd needs some fixing, firstly to not=20
> bother running dir notice on ro filesystems, and secondly allow an=20
> authorised user (other than the original program (in this case=20
> nautilus)) to drop specific mount point dirs from the notification list.=
=20
> so yes this is a userland problem as far as i can see.

I am using Debian. This is a good point. However, I have no component of
fam installed on this Debian machine at all.

And why does the eject command work? I decided to strace it to see where
it gets this invalid argument from..

open("/dev/hdc", O_RDONLY|O_NONBLOCK)   =3D 3
ioctl(3, 0x5309, 0xbffff948)            =3D -1 EIO (Input/output error)
ioctl(3, FIBMAP, 0xbffff7f0)            =3D 0
ioctl(3, FIBMAP, 0xbffff7f0)            =3D 0
ioctl(3, FIBMAP, 0xbffff7f0)            =3D 0
ioctl(3, BLKRRPART, 0xbffff7f0)         =3D -1 EINVAL (Invalid argument)
ioctl(3, FDEJECT, 0xbffff948)           =3D -1 EINVAL (Invalid argument)
ioctl(3, SNDCTL_MIDI_MPUMODE, 0xbffff900) =3D -1 EINVAL (Invalid argument)

It wasn't as revealing as I thought it would be, but does this mean
anything to someone more knowledgeable than I?

Note that as mentioned in a previous message, eject _does_ eject the CD.

--=20
Joshua Kwan

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+z4t6OILr94RG8mAQLWrQ//dBcRFusQG9QOmzq6S+yQrRGZdC0Yfe55
YbHm1Hm6/Oj3CLs6U3qYwhr7gGqESLRSiXC4IHyWnTb7Bg1OPHbPhjmldUfuTCvA
Gt90WyD+3GZIOsBbdULN2N4mF0ymJow1kSfbA7CteDYXNqXT6PpOEn++agQIz/HF
h8v/Napup1r+yrevXUX6nk5jUlTBcGbBkvZH4xndIHY4j77yYrPB6kF/vOndK9tr
q9wVSNvzNeQRELHby8y2xIS6KxcphSk6Uy38qV7b+ySTAsAYBXPr9bGL1sm9to8j
ERK1tUmsHyybRDXWJQnm/GjYzLC6qUa93L6OBWws6YbIrcGtF2jzP6pSlCZiKbuK
DsaFLRRMzqh5hnpjduOaiX2gaUDt5zmPGkmQxoYpRKlEWOkwCfhEwaE5fB7juuoS
l3ky3N/CCmpecYQlSaZjULSVjGJJmaDyh1Y0LAhLuFllvfqmch2EhcHJUbJ45wvZ
gsayxSTjXNRI1XWyEDQ43BURaozf0FonWH2QQuFjy0fgve6t/mtnA4NO17A1+whG
LpvhJGVNDjvAEUfyhe5LA5Q1TjajF4DYHHazUQ5shIaJ9qUAjgUclTBEsQbObZoQ
8egVmbRAQMz4vanRBPfUrAgpKlhOgMv6ID4yw6J/z+uiQHJQJmmsEufs5HegSjxe
uFWvW17WGzQ=
=CFtv
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
