Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUEaQiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUEaQiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEaQiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:38:10 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42668 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264669AbUEaQiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:38:03 -0400
Date: Mon, 31 May 2004 18:38:01 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040531163801.GW20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040526203524.GF2057@devserv.devel.redhat.com> <20040530184031.GF997@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOkWJigZa0YodlBE"
Content-Disposition: inline
In-Reply-To: <20040530184031.GF997@openzaurus.ucw.cz>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TOkWJigZa0YodlBE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-30 20:40:31 +0200, Pavel Machek <pavel@ucw.cz>
wrote in message <20040530184031.GF997@openzaurus.ucw.cz>:
> > One can rightfully argue that the driver resume method should do this, =
and
> > yes that is right. So the patch only does it for devices that don't hav=
e a
> > resume method. Like the main PCI bridge on my testbox of which the bios=
 so
> > nicely forgets to restore the bus master bit during resume.. With this =
patch
> > my testbox resumes just fine while it, well, wasn't all too happy as yo=
u can
> > imagine without a busmaster pci bridge.

All that reminds me... The PCI subsystem should probably record any PCI
device's initial configuration state after boot-up and restore those
settings before system reboot. Code like that was already in place
(during 2.2.x cycle IIRC) for Alphas, but got lost somewhen (and was
never added again). Upon reboot, Alphas (with current 2.6.x) running SRM
firmware might crash horribly because of "misconfigured" PCI devices.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--TOkWJigZa0YodlBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu19pHb1edYOZ4bsRApajAJ9alM6APZ4Z5RcBiWU6oD3FnKU6UgCeOVzP
J1oV6HoR2fZhXpUQ4nxFyHk=
=BIBy
-----END PGP SIGNATURE-----

--TOkWJigZa0YodlBE--
