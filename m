Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSG2Usc>; Mon, 29 Jul 2002 16:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318098AbSG2Usc>; Mon, 29 Jul 2002 16:48:32 -0400
Received: from grendel.firewall.com ([66.28.56.41]:9157 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S318097AbSG2Us1>; Mon, 29 Jul 2002 16:48:27 -0400
Date: Mon, 29 Jul 2002 22:51:47 +0200
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Message-ID: <20020729205147.GB1722@thanes.org>
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com> <20020729204424.GA4449@codepoet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20020729204424.GA4449@codepoet.org>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
From: grendel@thanes.org (Grendel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2002 at 02:44:25PM -0600, Erik Andersen scribbled:
[snip]
> drm_stub.h:125: parse error before `)'
> drm_stub.h:133: parse error before `)'
> drm_stub.h:137: parse error before `)'
> make[3]: *** [radeon_drv.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/drivers/char/drm'
> make[2]: *** [_modsubdir_drm] Error 2
> make[2]: Leaving directory `/usr/src/linux/drivers/char'
> make[1]: *** [_modsubdir_char] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_mod_drivers] Error 2
>=20
> The problem seems to be that=20
>     DRM_ERROR( "no scatter/gather memory!\n" );
>=20
> expands into
>     printk("<3>"  "[" "drm"  ":%s] *ERROR* "   "cannot allocate PCI GART =
page!\n"   ,  ) ;
>=20
> I think the __FUNCTION__ changes to DRM_ERROR and friends in drmP.h=20
> look awfully bogus.
Nope, it's a cpp (3.0+ is fine) error - the ##args is not generated correct=
ly when
'args...' in DRM_ERROR is empty.

marek

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Rariq3909GIf5uoRAiSLAJ4tm5SCOfARTuiC5yNj+AZnt2swugCeJC8x
13UAeN/Kqtm+/Hkb7gzuPDY=
=ZJb9
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
