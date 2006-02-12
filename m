Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWBLMKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWBLMKV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 07:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWBLMKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 07:10:21 -0500
Received: from mh57.de ([217.160.165.8]:43993 "EHLO lamedon.mh57.de")
	by vger.kernel.org with ESMTP id S932396AbWBLMKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 07:10:20 -0500
Date: Sun, 12 Feb 2006 13:10:09 +0100
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       dtor_core@ameritech.net
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060212121009.GC9020@mh57.de>
References: <20060207220627.345107c3.akpm@osdl.org> <20060211203158.GA9020@mh57.de> <20060211134142.11c1af44.akpm@osdl.org> <20060211222718.GB9020@mh57.de> <20060211153425.19242f9e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20060211153425.19242f9e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::57
X-Spam-Score: -2.8 (--)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2006 at 03:34:25PM -0800, Andrew Morton wrote:
> Martin Hermanowski <lkml@martin.mh57.de> wrote:
> >
> > >=20
> > > You could try reverting that patch (wget
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-=
rc2/2.6.16-rc2-mm1/broken-out/hdaps-convert-to-the-new-platform-device-inte=
rface.patch
> > > ; patch -p1 -R < hdaps-convert-to-the-new-platform-device-interface.p=
atch) or please test next -mm, let us know?
> >=20
> > This fails:
> > ,----[ patch -p1 -R < ../hdaps-convert-to-the-new-platform-device-inter=
face.patch ]
> > | patching file drivers/hwmon/hdaps.c
> > | Hunk #1 succeeded at 37 (offset 1 line).
> > | Hunk #2 succeeded at 63 (offset 1 line).
> > | Hunk #3 succeeded at 285 with fuzz 2 (offset 1 line).
> > | Hunk #4 FAILED at 321.
> > | Hunk #5 FAILED at 340.
> > | Hunk #6 succeeded at 474 (offset 1 line).
> > | Hunk #7 succeeded at 512 (offset 1 line).
> > | Hunk #8 succeeded at 533 (offset 1 line).
> > | 2 out of 8 hunks FAILED -- saving rejects to file
> > | drivers/hwmon/hdaps.c.rej
> > `----
> >=20
> > At hunk 4/5, the patch expects `down_trylock' and `up', while
> > `mutex_trylock' and `mutex_unlock' are used in the actual file, I think.
>=20
> Yes, one of Greg's patches plays with hdaps too.=20
> gregkh-i2c-hwmon-convert-semaphores-to-mutexes.patch.  Perhaps reverting
> that first will get you there.

After reverting both, hdaps works as expected. Thank you for your help!

> > I will try next -mm anyway, because although the fsck-errors caused by
> > ext3_getblocks are not harmful, they make me nervous ;-)
>=20
> I haven't heard from Mingming, so unless I feel inspired to roll up the
> sleeves and fix it (P=3D0.002), that won't be fixed in next -mm.

Then I'll just wait ;-)

--=20
Martin Hermanowski
http://mh57.de

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7yWhmGb6Npij0ewRAnGlAKCKFWp1uR/XIRfFol81lGO10Yxg0ACdG+wL
aPtuKFghc2f9bBU4wGbo3e4=
=dfwb
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
