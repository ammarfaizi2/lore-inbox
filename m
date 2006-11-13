Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933071AbWKMVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbWKMVgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933076AbWKMVgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:36:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:4760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933071AbWKMVgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:36:22 -0500
X-Authenticated: #5108953
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
Date: Mon, 13 Nov 2006 22:36:15 +0100
User-Agent: KMail/1.9.5
Cc: paulkf@microgate.com, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200611130943.42463.toralf.foerster@gmx.de> <4558860B.8090908@garzik.org>
In-Reply-To: <4558860B.8090908@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2125983.FRtDt0WzrY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611132236.18521.toralf.foerster@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2125983.FRtDt0WzrY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Monday 13 November 2006 15:49 schrieb Jeff Garzik:
> Toralf F=F6rster wrote:
> > Hello,
> >=20
> > the build with the attached .config failed, make ends with:
> > ...=20
> > UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `hdlcdev_open':
> > synclink.c:(.text+0x650d5): undefined reference to `hdlc_open'
> > synclink.c:(.text+0x6510d): undefined reference to `hdlc_open'
> > ...
> > synclink_cs.c:(.text+0x7aece): undefined reference to `hdlc_ioctl'
> > drivers/built-in.o: In function `hdlcdev_init':
> > synclink_cs.c:(.text+0x7b336): undefined reference to `alloc_hdlcdev'
> > drivers/built-in.o: In function `hdlcdev_exit':
> > synclink_cs.c:(.text+0x7b434): undefined reference to `unregister_hdlc_=
device'
> > make: *** [.tmp_vmlinux1] Error 1
>=20
> Does this patch work for you?
>=20
> 	Jeff
>=20
>=20
>=20
No, only the generated .config changed, but make failes again:


tfoerste@n22 ~/devel/linux-2.6 $ diff .config ../results/config.rnd.119
4c4
< # Mon Nov 13 17:45:00 2006
=2D--
> # Fri Nov 10 13:26:43 2006
514a515
> CONFIG_SYNCLINK_CS=3Dy

=2D-=20
MfG/Sincerely

Toralf F=F6rster

--nextPart2125983.FRtDt0WzrY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFWOVShyrlCH22naMRAgvgAKCR5zGrt+VN11O7wF8elopi2N5APgCfXg/L
UrpX/OfIrE4ZLo8KYabifF0=
=f7Sj
-----END PGP SIGNATURE-----

--nextPart2125983.FRtDt0WzrY--
