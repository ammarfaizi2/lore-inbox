Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVHPMQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVHPMQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbVHPMQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:16:05 -0400
Received: from relay.rost.ru ([80.254.111.11]:15539 "EHLO smtp.rost.ru")
	by vger.kernel.org with ESMTP id S932643AbVHPMQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:16:04 -0400
Date: Tue, 16 Aug 2005 16:15:58 +0400
To: Valdis.Kletnieks@vt.edu
Cc: Michael E Brown <Michael_E_Brown@dell.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816121558.GB4356@pazke>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Michael E Brown <Michael_E_Brown@dell.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Doug Warzecha <Douglas_Warzecha@dell.com>,
	linux-kernel@vger.kernel.org
References: <1124168323.10755.179.camel@soltek.michaels-house.net> <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
X-Uname: Linux 2.6.13-rc5-mm1-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 228, 08 16, 2005 at 01:36:19AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 15 Aug 2005 23:58:43 CDT, Michael E Brown said:
>=20
> > No, this is an _EXCELLENT_ reason why _LESS_ of this should be in the
> > kernel. Why should we have to duplicate a _TON_ of code inside the
> > kernel to figure out which platform we are on, and then look up in a
> > table which method to use for that platform? We have a _MUCH_ nicer
> > programming environment available to us in userspace where we can use
> > things like libsmbios to look up the platform type, then look in an
> > easily-updateable text file which smi type to use. In general, plugging
> > the wrong value here is a no-op.
>=20
> You'll still need to do some *very* basic checking - there's fairly
> scary-looking 'outb' call in  callintf_smi()  and host_control_smi() that=
 seems to
> be totally too trusting that The Right Thing is located at address CMOS_B=
ASE_PORT:
>=20
> +		for (index =3D PE1300_CMOS_CMD_STRUCT_PTR;
> +		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
> +		     index++) {
> +			outb(index,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
> +			outb(*data++,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
> +		}
>=20
> This Dell C840 has an 845, not a PIIX.  What just got toasted if this dri=
ver
> gets called?
>=20
> Can we have a check that the machine is (a) a Dell and (b) has a PIIX and=
 (c) the
> PIIX has a functional SMI behind it, before we start doing outb() calls?

What about dmi_check_system() ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDAdj+R2OTnxNuAyMRAuBeAKCDXuNUL9LLG4bbj+ibA7KD1ZR29QCgplA1
pziuEFyDIyAW+EpbGC15h9M=
=Lwby
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
