Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSDXNkq>; Wed, 24 Apr 2002 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSDXNkp>; Wed, 24 Apr 2002 09:40:45 -0400
Received: from h195202190178.med.cm.kabsi.at ([195.202.190.178]:45198 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S312178AbSDXNko>; Wed, 24 Apr 2002 09:40:44 -0400
Subject: Re: An IPsec tunnel implementation for Linux using CryptoAPI
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: linux-crypto@nl.linux.org, cryptoapi-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204232355060.32300-100000@boris.prodako.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-k+BRfHtZMgsQ24/nGtKP"
X-Mailer: Ximian Evolution 1.0.3 
Date: 24 Apr 2002 15:40:25 +0200
Message-Id: <1019655625.8169.167.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k+BRfHtZMgsQ24/nGtKP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello!

On Wed, 2002-04-24 at 00:17, Tobias Ringstrom wrote:
> A little bit off-topic perhaps, but I'd like to congratulate you all on a=
n
> extremely useable piece of software!  When I decicided to make a
> light-weight IPsec tunnel implementation some time ago I decided very
> early on to use your CryptoAPI, and found it really easy to use.
>=20
> I now have a version of my IPsec tunnel implementation that seems to work
> just fine, and I think it's time to let you guys have a peek at it.  You
> can find the code and a first stab at actual documentation at
>=20
> 	http://ringstrom.mine.nu/ipsec_tunnel/
>=20
> Please remeber that this is an early version, and I do not guarantee
> anything.  It does seem to interoperate with OpenBSD's IPsec though, and =
I
> have been using it for several weeks myself.
>=20
> And yes, I've heard about FreeS/WAN...  :-)
>=20
> I'm interested in any comments or questions!

I decided to CC this reply to the lkml, since IMO more people should
know about this implementation of yours.

I've taken a quick look at your webpage and the source code itself...
one thing I saw is, that your implementation doesn't require any
modification to the main kernel -- i.e. no patching required -- it's a
plugin... just like CIPE... (which btw uses cryptoapi as well in its
latest code base)
(thus you don't even need to reboot your system in order to enable
lightweight IPSEC in your kernel...)
-- this fits well with the cryptoapi, which can add modular crypto
support without needing to patch or reboot your kernel...

I think, some people will like this lightweight IPSEC/IPv4
implementation, since it doesn't have the eroute/route-filtering
facility of frees/wan...=20

on the other hand, it's not a complete IPSEC implementation (yet)... it
only implements ESP for tunneling purposes, and lacks AH and IKE....
and frees/wan offers some advanced features like compression and icmp
handling, which ipsec_tunnel may still lack...

regards,
--=20
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

--=-k+BRfHtZMgsQ24/nGtKP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8xrXJSYHgZIg/QUIRAtMIAJ4lKT+WDq/lcHP7NIRZS49OsHFnhQCgp8jw
t1idJYbMmMj9Ts9jUEr6Cq8=
=4M/f
-----END PGP SIGNATURE-----

--=-k+BRfHtZMgsQ24/nGtKP--

