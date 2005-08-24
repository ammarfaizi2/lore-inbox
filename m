Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVHXJzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVHXJzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVHXJzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:55:48 -0400
Received: from defiant.lowpingbastards.de ([213.178.77.226]:33487 "EHLO
	mail.lowpingbastards.de") by vger.kernel.org with ESMTP
	id S1750785AbVHXJzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:55:48 -0400
Date: Wed, 24 Aug 2005 11:55:20 +0200
From: Frederik Schueler <fs@lowpingbastards.de>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Frederik Schueler <fs@lowpingbastards.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824095520.GD13391@mail.lowpingbastards.de>
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20050823200040.GA8310@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 23, 2005 at 01:00:40PM -0700, Patrick Mansfield wrote:
> The use of scsiadd script implies that you are attaching or somehow
> modifying the storage after the driver has loaded. Is that correct?

yes exactly, only the bootdrive LUN is registered after bootup. I have
to selectively scsiadd the other LUNs if there is a gap between the=20
boot LUN (1-8 in our setup) and the shared storages (9-14). I don't
consider this a bug though, I had to remove some devices otherwise,=20
and old drivers had to be patched to allow this at all.


> There is a fix for scanning initiated via user space, this change:
>=20
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/jejb/scsi-rc-fixes-2.6.gi=
t;a=3Dcommit;h=3D5c44cd2afad3f7b015542187e147a820600172f1
>=20
> The above fix is in the current 2.6 git tree. Does that fix your problem?
=20
It does, thanks for the hint :-)

I see this is in rc7 too.


> Also try using lsscsi.

it does not list the non-registered LUNs the driver knows about, as the
old proc interface did.


Best regards
Frederik Schueler

--=20
ENOSIG

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDEQI6n7So0GVSSARAhAlAKCCx09jpD77raczusgfOpdW6hIb5ACfUC+a
y2q1W3rNj6Aw/fP+NrMnDkQ=
=x4/n
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
