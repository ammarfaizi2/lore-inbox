Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTL0TmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTL0TmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:42:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11428 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264538AbTL0TmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:42:03 -0500
Date: Sat, 27 Dec 2003 11:36:23 -0800
From: Cam Vertesi <cvertesi@indiana.edu>
Subject: dell latitude Fn+ buttons and 2.6.0
To: linux-kernel@vger.kernel.org
Reply-to: cvertesi@indiana.edu
Message-id: <1072553782.2833.18.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: multipart/signed; boundary="=-NYajertlR7e2yQt3xp9l";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NYajertlR7e2yQt3xp9l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[Please cc me in replies, I'm far from my news client]

I'm running RH9 on a Dell Latitude C610 laptop, and under the RedHat
2.4.20.8-i686 kernel everything worked great.  I just configured  and
installed 2.6.0, and after a few reconfigures and changes to my system,
everything seems to be working.  So far so good.  Everything works now,
that is to say, except for the Fn keys.  My laptop (like many dells)
uses function keys for suspend, live bios, and other system functions.=20
Under 2.6.0, These keys don't seem to register at all.

Group searching gave me some interesting ideas:  "showkey -s" comes up
empty; apparently Fn combinations produce no keycodes (except for the
volume keys). Disabling APIC and enabling I8k made no difference.  I
even tried disabling ACPI and leaving only APM, and vice versa. =20

With APM only, the system at least responds to the buttons; I can get
into the live bios, and enter suspend mode.  Sadly, the system then
hangs when I come out of suspend mode! =20

I have two questions here:
1) What's going on that makes it hang coming out of suspend?  What
kernel option am I missing?
2) Why do I have to disable ACPI to use the Fn keys?  I know the laptop
supports ACPI; I get all sorts of great info in /proc with it enabled.=20
What gives?

Relevant portion of .config follows.

Thanks

Cam


--------begin .config -------------
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set
                                                                           =
    =20
#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
                                                                           =
    =20
#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
                                                                           =
    =20
---------- end .config -----------

--=20
Cam Vertesi <cvertesi@indiana.edu>

--=-NYajertlR7e2yQt3xp9l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/7d82ezO3XSYqQrYRAqHpAJ9bfXB3OgHJ7jPJwbPBok+5Hk0LtACfS0rD
gd0Epc4DQcnGm4OXCzkwPIY=
=SAIQ
-----END PGP SIGNATURE-----

--=-NYajertlR7e2yQt3xp9l--

