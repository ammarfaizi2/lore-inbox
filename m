Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUEFK27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUEFK27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUEFK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:28:58 -0400
Received: from mail.donpac.ru ([80.254.111.2]:23274 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261981AbUEFK24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:28:56 -0400
Date: Thu, 6 May 2004 14:29:04 +0400
From: Andrey Panin <pazke@donpac.ru>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] DMI cleanup patches
Message-ID: <20040506102904.GA3295@pazke>
Mail-Followup-To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

currently arch/i386/kernel/dmi_scan.c file looks like complete
mess. Interfacing with other kernel subsystem made using
ad-hoc ways, mostly with ugly global variables, additionaly
coding style is ... not good. So these patches appear:

	patch-dmi-1-matches - simplify DMI blacklist table by
removing the need to fill unused slots with NO_MATCH macro.

	patch-dmi-2-api - separate and export dmi_check_system()
function (along with some needed declarations) which checks given
DMI id table against system DMI data and runs callback functions=20
when necessary.

	patch-dmi-3-whitespace - various coding style cleanups.

	patch-dmi-4-sonypi - make sonypi driver use dmi_check_system()
function and remove is_sony_vaio_laptop global variable.

	patch-dmi-5-apm - make APM BIOS driver use dmi_check_system()
function and move all related quirks into apm.c.

	patch-dmi-6-pciirq - make pci irq routing code use=20
dmi_check_system() function and make broken_hp_bios_irq9 variable=20
static.

	patch-dmi-7-smbus - make PIIX4 I2C use dmi_check_system()
function and remove is_unsafe_smbus global variable.

Please take a look.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmhNwby9O0+A2ZecRAp2nAKC569+JNzWHkSkoK/XwLtaacWYQQACgmcVN
J4EIWf00uaV5uE0vxZyYHqE=
=ai2w
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
