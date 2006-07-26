Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWGZA36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWGZA36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWGZA36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:29:58 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:3991 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1030295AbWGZA35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:29:57 -0400
Message-ID: <44C6B784.5050507@slaphack.com>
Date: Tue, 25 Jul 2006 19:29:56 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060708)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Mike Benoit <ipso@snappymail.ca>, Matthias Andree <matthias.andree@gmx.de>,
       Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
In-Reply-To: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig4B0280BFA9A06FE0593F60FC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B0280BFA9A06FE0593F60FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Horst H. von Brand wrote:

> 18GiB =3D 18 million KiB, you do have a point there. But 40 million fil=
es on
> that, with some space to spare, just doesn't add up.

Right, ok...

Here's a quick check of my box.  I've explicitly stated which root-level
directories to search, to avoid nfs mounts, chrooted OSes, and virtual
filesystems like /proc and /sys.

elite ~ # find /bin/ /boot/ /dev/ /emul/ /etc/ /home /lib32 /lib64 /opt
/root /sbin /tmp /usr /var -type f -size 1 | wc -l
246127

According to the "find" manpage:

-size n[bckw]
      File uses n units of space.  The units are  512-byte  blocks  by
      default  or  if `b' follows n, bytes if `c' follows n, kilobytes
      if `k' follows n, or 2-byte words if `w' follows  n.   The  size
      does  not  count  indirect  blocks,  but it does count blocks in
      sparse files that are not actually allocated.


And I certainly didn't plan it that way.  And this is my desktop box,
and I'm just one user.  Most of the space is taken up by movies.

And yet, I have almost 250k files at the moment whose size is less than
512 bytes.  And this is a normal usage pattern.  It's not hard to
imagine something prone to creating lots of tiny files, combined with
thousands of users, easily hitting some 40 mil files -- and since none
of them are movies, it could fit in 18 gigs.

I mean, just for fun:

elite ~ # find /bin/ /boot/ /dev/ /emul/ /etc/ /home /lib32 /lib64 /opt
/root /sbin /tmp /usr /var | wc -l
866160

It may not be a good idea, but it's possible.  And one of the larger
reasons it's not a good idea is that most filesystems can't handle it.
Kind of like how BitTorrent is a very bad idea on dialup, but a very
good idea on broadband.


--------------enig4B0280BFA9A06FE0593F60FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMa3hHgHNmZLgCUhAQp16w/+KXL68lp1E9pGqd4IQCNEiXNVKsTCkTKy
I/FQsNTiH1qjJtsRf7APVL7EYnGvtGDKpM2Z3HMk4DXdiS8yYD3qxTKJ4jcBKX97
69eme7R7RJym7bFW7r1UcM4UfTI1XmIFCqJLmxoQ9cUR2iUf3foJG6KCzSi7Qgo6
VRIXp3IYl+n3pGu0O11G6gCBEs5Psch+rlQaUD4YmBwJ48YNGIqrjJc9Hg3UlQHd
apwUv8kIMJ2gv0kBWPX5klC/0p8i730FgTpx6t/bWt3lxIIgi/e/a18OGSWbNcUW
PF6ZRykku80FyGnlmpUXtzP3bhLjjAN/K5zRGtNhPv6h7HfUD/8Hb4H557hbmgOV
jIoLz6PdEqu5rP5volD/Td74T7dypbHbSl1L/wLrHkMu922cjx0hdlCpn0lY4rks
j7jqoj05cwcxjmTWkwb2dmxQQBV2BoPHW8rs3t/vm7e/0nS9HRCe+8MeCeH4iMOk
TXMlj+w3L1V0u1H2gpzHbYWVediMXQeQ07NFOrY18FX0vpUWoLhLvZWZI5tJ/Cn9
HAGL16tuWaw/LI4xgA1mxFdMnHtAYhmQli9LmL++LQOnWho8p4QDxFsQcSQYya2z
zAk4hICILhNGim5SMfnfRtRBIVRkx4t0OKbboh6+Ne7whISljwBCMlavZb4RBsUX
Pdaclb5ZksE=
=bKhv
-----END PGP SIGNATURE-----

--------------enig4B0280BFA9A06FE0593F60FC--
