Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVHXMsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVHXMsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 08:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVHXMsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 08:48:50 -0400
Received: from defiant.lowpingbastards.de ([213.178.77.226]:24272 "EHLO
	mail.lowpingbastards.de") by vger.kernel.org with ESMTP
	id S1750918AbVHXMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 08:48:49 -0400
Date: Wed, 24 Aug 2005 14:48:03 +0200
From: Frederik Schueler <fs@lowpingbastards.de>
To: Christoph Hellwig <hch@infradead.org>,
       Frederik Schueler <fs@lowpingbastards.de>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824124803.GE13391@mail.lowpingbastards.de>
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com> <20050824095520.GD13391@mail.lowpingbastards.de> <20050824100112.GA27216@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20050824100112.GA27216@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 24, 2005 at 11:01:12AM +0100, Christoph Hellwig wrote:
> > yes exactly, only the bootdrive LUN is registered after bootup. I have
> > to selectively scsiadd the other LUNs if there is a gap between the=20
> > boot LUN (1-8 in our setup) and the shared storages (9-14). I don't
> > consider this a bug though, I had to remove some devices otherwise,=20
> > and old drivers had to be patched to allow this at all.
>=20
> Actually this sounds like a bug in your storage system.  It's probably
> reporting to be only SCSI2 complicant, which doesn't make sense for
> FC storage.  Please try the patch below:

[...]

Unfortunately this does not fix this issue, besides the SAN being=20
reported as a scsi3 device now.

Thanks anyway :)
Frederik Schueler

--=20
ENOSIG

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDGyD6n7So0GVSSARAhRgAJ9toAGAkW3sQV0Bk18ZmwidfdnslACfdsqa
tqjFBcEUVtAPYCONIY7Mjo8=
=DpCQ
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
