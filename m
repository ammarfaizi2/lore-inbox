Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbULOQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbULOQxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbULOQwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:52:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54478 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262393AbULOQvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:51:48 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Wed, 15 Dec 2004 17:45:31 +0100
User-Agent: KMail/1.6.2
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com
References: <20041215065650.GM27225@wotan.suse.de> <200412151446.01913.arnd@arndb.de> <20041215161218.GA26772@wotan.suse.de>
In-Reply-To: <20041215161218.GA26772@wotan.suse.de>
MIME-Version: 1.0
Message-Id: <200412151745.32053.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_soGwBNX/YLq16cZ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_soGwBNX/YLq16cZ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 15 Dezember 2004 17:12, Andi Kleen wrote:
> >=20
> > If the dasd driver now implements an ioctl_compat() method, who will
> > call the standard conversion handlers?
>=20
> How about just calling back to a special function from these
> special ioctl handlers?
>=20
Sorry, I don't understand. AFAICS, if the driver does not have a
ioctl_compat() file op, it will only be called for those ioctl numbers
that are registered in fs/compat_ioctl.c, but not for the ones that were
added by a third party module.
If it has a ioctl_compat() function, it can handle its own ioctls including
those that are dynamically added, but not any generic ones that have static
conversion functions in fs/compat_ioctl.c. Do you mean it should call back
from its private ioctl_compat() function to the global ioctl32_hash_table[]
lookup?

 Arnd <><



--Boundary-02=_soGwBNX/YLq16cZ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBwGos5t5GS2LDRf4RAgwTAKCd0L0QaPv5xdS+PSeVzJREkbHqxACfZWTF
BtOgawifRMmKelzSscddLq4=
=YF7U
-----END PGP SIGNATURE-----

--Boundary-02=_soGwBNX/YLq16cZ--
