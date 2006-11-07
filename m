Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753233AbWKGVvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbWKGVvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKGVvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:51:32 -0500
Received: from mail.isohunt.com ([69.64.61.20]:8932 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1753233AbWKGVvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:51:31 -0500
X-Spam-Check-By: mail.isohunt.com
Date: Tue, 7 Nov 2006 13:31:38 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Robin H. Johnson" <robbat2@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061107213138.GA16523@curie-int.orbis-terrarum.net>
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <4550AB7A.10508@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2006 at 07:51:22AM -0800, Auke Kok wrote:
> >I think you should cc e1000 maintainers, and perhaps provide a patch....
> I've read it and not come up with an answer due to some other issues at=
=20
> hand. E1000 hardware works differently and this has been asked before, bu=
t=20
> the cards itself are in low power state when down. Changing this to bring=
=20
> up the link would make the card start to consume lots more power, which=
=20
> would automatically suck enormously for anyone using a laptop.
>=20
> Unfortunately, we have no way to distinguish directly between mobile and=
=20
> non-mobile adapters, since they are usually the same.
>=20
> Your application should really `ifconfig up` the device before checking f=
or=20
> link.
Actually pushing the link up in userspace doesn't specifically help my
applications, as I care about actual link status (as reported by
ethtool).

Is there no way to keep the link status correct (within 0.5 seconds),
without bringing the card to full power? Maybe a timer that fires a
proper check (with the power implications).

Would a patch that adds a modparam (not enabled by default) running the
behavior I'm after, be acceptable, so the e1000 driver can act identical
to all of the other drivers?

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFUPs6PpIsIjIzwiwRAjtPAJ0RADzmyF3p6tMI8fEcIvrkn0397ACcD0EZ
EtggGNoW1z0u/BINexsXx9w=
=NrRt
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
