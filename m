Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbULKASa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbULKASa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbULKASa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:18:30 -0500
Received: from 66.238.42.11.ptr.us.xo.net ([66.238.42.11]:37030 "EHLO
	mail.petta-tech.com") by vger.kernel.org with ESMTP id S261882AbULKASY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:18:24 -0500
Date: Fri, 10 Dec 2004 16:18:23 -0800
From: Eric Wong <eric@petta-tech.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Julien Langer <jlanger@zigweb.de>, linux-kernel@vger.kernel.org
Subject: Re: Sil3112 and Seagate ST3160023AS
Message-ID: <20041211001823.GA14951@r40.bogomips.org>
References: <1102691231.3921.13.camel@moeff> <41B9E224.9030705@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <41B9E224.9030705@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik <jgarzik@pobox.com> wrote:
> Julien Langer wrote:
> >Is there a way to disable this fix, which slows down my drive, since it
> >worked fine for a long time without this fix on older kernel versions?
> >I'm using the deprecated ide driver for the sil controller, not libata.
>=20
> Unfortunately it's just a matter of time until you hit a problem,=20
> without the errata fix that causes the performance loss.
=20
It's been 11 months with my ST3160023AS 3.05 and SiI 3112 (rev 02) under
fairly heavy use and I haven't noticed anything wrong.

I think I've read somewhere that rev 2 of the SiI 3112 is safe, and that
might be why I'm alright.  Unfortunately, the sata_sil blacklist
implementation I wrote at the time doesn't seem to account for the
revision of either the drive nor the controller.

My experiences: (purely anecdotal evidence, ymmv)

Stability has been nothing but solid, the box they're on is on 24/7 as
an NFS server housing mainly FLAC audio and multiple Arch archives and
a build daemon (which means revision libraries and working trees exist
too)

Neither Arch archives/working trees/revision libraries nor my FLAC audio
collection has shown any inconsistency (but then again MD5 used by both
Arch and FLAC has been proven broken lately).  I'll fix up an Arch
script to check the SHA1 and the MD5 checksums sometime this weekend
(the newer commits are double checksummed).  Arch revision library
consistency is checked by tla via inode signatures, and those haven't
burped on me, either.

--=20
Eric Wong

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBujzPcodMowuNYfcRAiyoAJ0Ul0WvWYx1t9SdQSlfsoh/JrSFlQCdFtAz
FSclsseixRF27xz72MNFF9Q=
=uryk
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
