Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286693AbRLVFm7>; Sat, 22 Dec 2001 00:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286694AbRLVFmv>; Sat, 22 Dec 2001 00:42:51 -0500
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:42256 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S286693AbRLVFme>; Sat, 22 Dec 2001 00:42:34 -0500
Date: Sat, 22 Dec 2001 00:42:28 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - 2.4.17 - if_arp.h - Add the Prism2 ARP type
Message-ID: <20011222004228.A22793@shaftnet.org>
In-Reply-To: <20011222000105.A22554@shaftnet.org> <20011221.210655.91756024.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221.210655.91756024.davem@redhat.com>; from davem@redhat.com on Fri, Dec 21, 2001 at 09:06:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2001 at 09:06:55PM -0800, David S. Miller wrote:
>    From: Stuffed Crust <pizza@shaftnet.org>
>    Date: Sat, 22 Dec 2001 00:01:05 -0500
>=20
>    Hey, this one-line patch (I diffed it against 2.4.17-rc2) defines the
>    ARPHRD_IEEE80211_PRISM arp type.
>=20
> Is the allocation of this number standardized somewhere?

Yes and no.  There are a handful of standard hardware ARP types defined
in RFC826, I believe.  [checks.]  No, I guess not.   But those are
definately standardized, probably by the IEEE or somesuch.

Meanwhile, the "Dummy types for non ARP hardware" list in if_arp.h seems
to be the authoratitive non-standard standard, as it starts at 256 and
seems to pretty much sequentially count up with the occasional large
gap.  =20

Linux's PF_SOCKET code uses this to identify the packet type
coming off the wire.

The ARPHRD_IEEE80211 type was defined in 2.4.6 by incrementing the
number by one and appending it to the end of the list.  I just
incremented the protocol number by one for the _PRISM type.

I have no idea if there was some master list somewhere; google didn't
seem to return any hits other than the linux source.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JB1EysXuytMhc5ERAsw2AKCRN+ulH8xu+L9c1G1F0L+UZFExdQCaAzEk
utFUaJljD4zCtGfHKfSFThI=
=qSJY
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
