Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319087AbSHFMwy>; Tue, 6 Aug 2002 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319086AbSHFMwy>; Tue, 6 Aug 2002 08:52:54 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:24018 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S319087AbSHFMww>; Tue, 6 Aug 2002 08:52:52 -0400
Date: Tue, 6 Aug 2002 15:52:25 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: weird padding in linux/timex.h, struct timex
Message-ID: <20020806125224.GP29139@alhambra.actcom.co.il>
References: <20020806111549.GL29139@alhambra.actcom.co.il> <1028640964.18130.145.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
Content-Disposition: inline
In-Reply-To: <1028640964.18130.145.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2002 at 02:36:04PM +0100, Alan Cox wrote:
> On Tue, 2002-08-06 at 12:15, Muli Ben-Yehuda wrote:
> > Hi,=20
> >=20
> > struct timex in include/linux/timex.h is defined as=20
> >=20
> > struct timex=20
> > {
> > 	...
> > 	int  :32; int  :32; int  :32; int  :32;
> > 	int  :32; int  :32; int  :32; int  :32;
> > 	int  :32; int  :32; int  :32; int  :32;
> > };=20
> >=20
> > I assume that this is used as padding. Is there any reason for using
> > bitfields as padding? If there is, a comment to that effect would be
> > nice. If there isn't, the following patch makes the padding explicit.=
=20
> >=20
>=20
> That is how the interface has always been defined. I think we inherited
> that from the world of xntpd but I may be wrong. Your __pad is not
> always the same thing - you assume 4 byte ints and ints aligned the same
> way as char [], which may not always be true.

I assume 4 byte ints, because I assume that the length of a 32 bit
bitfield will be 32 bits. As for alignment, you're correct.=20

I guess my question becomes: is the original code defined in any
special way, in regards to padding and size? If it isn't, my __pad
patch would be cleaner and just as correct in principle. If it is, I
can make a __pad which will behave exactly the same way.=20

Thanks, Muli.=20
--=20
I am PINK, hear me ROAR

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9T8aIKRs727/VN8sRAiyVAJ9eQ94VqvV/SSRlOYRHMMtascNyxwCeLjpn
DQSSKlU0r9rox0tHlaCjoQM=
=Sisj
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--
