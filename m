Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbVBCNIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbVBCNIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVBCNIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:08:41 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:4028 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263708AbVBCNHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:07:54 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <20050203040542.GQ2493@waste.org>
References: <20050202211916.GJ2493@waste.org>
	 <1107394381.10497.16.camel@server.cs.pocnet.net>
	 <20050203015236.GO2493@waste.org>
	 <1107398069.11826.16.camel@server.cs.pocnet.net>
	 <20050203040542.GQ2493@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7zvMZ/+XBpAbYpvAxlGK"
Date: Thu, 03 Feb 2005 14:07:48 +0100
Message-Id: <1107436068.22902.12.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7zvMZ/+XBpAbYpvAxlGK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 02.02.2005, 20:05 -0800 schrieb Matt Mackall:

> On Thu, Feb 03, 2005 at 03:34:29AM +0100, Christophe Saout wrote:
> > The keyring API seems very flexible. You can define your own type of
> > keys and give them names. Well, the name is probably irrelevant here an=
d
> > should be chosen randomly but it's less likely to collide with someone
> > else.
> =20
> Dunno here, seems that having one tool that gave the kernel a key named
> "foo" and then telling dm-crypt to use key "foo" is probably not a bad
> way to go. Then we don't have stuff like "echo <key> | dmsetup create"
> and the like and the key-handling smarts can all be put in one
> separate place.

Yes. I could also change cryptsetup to not mlockall the whole
application just because the key is passed down to libdevmapper which
does not treat parameters with special care.

> Getting from here to there might be interesting though. Perhaps we can
> teach dm-crypt to understand keys of the form "keyname:<foo>"? in
> addition to raw keys to keep compatibility. Might even be possible to
> push this down into crypt_decode_key() (or a smarter variant of same).
>=20
> Meanwhile, I'd still like to hide the raw key in crypt_status().

Well, I don't. I don't know any tools that actually use the
DM_DEVICE_TABLE command except cryptsetup. I don't like to make the
interface inconsistent just because there might be an incompetent root
sitting in front of the machine.


--=-7zvMZ/+XBpAbYpvAxlGK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAiIkZCYBcts5dM0RAvXdAKCn5/F1mM55B79HGE4GyKKgXQ44VACeJsm6
QlAXWXH3rXKvwyK1K5O13cg=
=pYTJ
-----END PGP SIGNATURE-----

--=-7zvMZ/+XBpAbYpvAxlGK--
