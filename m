Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTI2GJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTI2GJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:09:38 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:45704 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262836AbTI2GJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:09:36 -0400
Date: Mon, 29 Sep 2003 09:09:05 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Ram?n Rey Vicente <ramon.rey@hispalinux.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][2.6.0-test6] ALSA pci Kconfig polishes
Message-ID: <20030929060905.GU729@actcom.co.il>
References: <1064804924.11516.3.camel@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6axCafNXXMM8qu6Q"
Content-Disposition: inline
In-Reply-To: <1064804924.11516.3.camel@debian>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6axCafNXXMM8qu6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2003 at 05:08:45AM +0200, Ram?n Rey Vicente wrote:
> Hi.
>=20
> I think the ALSA pci devices must select the GAMEPORT option
> automatically instead of depends on GAMEPORT.
>=20
> The GAMEPORT is a feature of the device, is not a requisite.

This patch makes GAMEPORT required, while actually it's only required
to not be a module if the sound driver is builtin. See my earlier mail
on the subject for the details:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106479206731633&w=3D2=20

A better fix would be to revert the change in sound/pci/Kconfig from
CONFIG_SOUND_GAMEPORT to CONFIG_GAMEPORT back to
CONFIG_SOUND_GAMEPORT, or just drop this dependency for ALSA and let
the #ifdefs in the code take care of it. Forcing the gameport to be
compiled in when it's not necessary is bloat, IMHO.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--6axCafNXXMM8qu6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/d8yBKRs727/VN8sRAlrIAKCIyDA1iHKpWhbqdIFe5D0jErRANACfQbvN
3ATdSAoFXEcpK/IKCIY83Ao=
=5F+6
-----END PGP SIGNATURE-----

--6axCafNXXMM8qu6Q--
