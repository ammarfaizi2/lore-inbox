Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289353AbSAJIpW>; Thu, 10 Jan 2002 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289354AbSAJIpL>; Thu, 10 Jan 2002 03:45:11 -0500
Received: from h24-71-138-152.ss.shawcable.net ([24.71.138.152]:7664 "HELO
	lorien.untroubled.org") by vger.kernel.org with SMTP
	id <S289353AbSAJIpC>; Thu, 10 Jan 2002 03:45:02 -0500
Date: Thu, 10 Jan 2002 02:45:20 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020110024520.A29045@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Jan 09, 2002 at 08:36:13PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2002 at 08:36:13PM -0200, Rik van Riel wrote:
> Matt's system seems to go from 900 MB free to about
> 300 MB (free + cache).
>=20
> I doubt qmail would eat 600 MB of RAM (it might, I
> just doubt it) so I'm curious where the RAM is going.

I am seeing the same symptoms, with similar use -- ext3 filesystems
running qmail.  Adding up the RSS of all the processes in use gives
about 75MB, while free shows:

             total       used       free     shared    buffers     cached
Mem:        901068     894088       6980          0     157568     113856
-/+ buffers/cache:     622664     278404
Swap:      1028152      10468    1017684

This are fairly consistent numbers.  buffers hovers around 150MB and
cached around 110MB all day.  The server is heavy on write traffic.

> Matt, do you see any suspiciously high numbers in
> /proc/slabinfo ?

What would be suspiciously high?  The four biggest numbers I see are:

inode_cache       139772 204760    480 25589 25595    1
dentry_cache      184024 326550    128 10885 10885    1
buffer_head       166620 220480     96 4487 5512    1
size-64           102388 174876     64 2964 2964    1

I can post complete details for any who wish to investigate further.  I
am not seeing a huge slowdown, but I have no real baseline to compare
against.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PVSg6W+y3GmZgOgRAtQXAJ9NvQlL7n+yhs23/wACJ7bahEdDrwCeLABe
4rkvGdzixJcg5YS85/v2DUw=
=1R0i
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
