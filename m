Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCIDsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCIDsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWCIDsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:48:18 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:39950 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S1750807AbWCIDsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:48:17 -0500
Date: Wed, 8 Mar 2006 21:48:13 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: opinions on bigphysarea and DSDT-in-initrd patches
Message-ID: <20060309034813.GA5300@dbz.icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I grepped through the latest ML digests and didn't see any mention of
these patches recently.  I was wondering what the general opinion was on
potentially merging them.  They are both hardware support patches.  I
asked about the Debian kernel team maintaining them of instead
linux-kernel, but met with a lack of response there.

First is bigphysarea:
http://pv105234.reshsg.uci.edu/~jfeise/Downloads/zr36120/
This is necessary for hardware which doesn't support scatter gather DMA.
It is non invasive since it only becomes activated when the user
supplies a kernel cmdline argument.  I've tested the latest version and
it works fine.

Also, I'm wondering if it is possible to include ACPI DSDT-in-initrd
patch on ACPI-supported platforms (i386, x86-64 and ia64 AFAIK).
http://gaugusch.at/kernel.shtml

This saves a user from having to rebuild the entire kernel when his
firmware DSDT either has known bugs, or he is in the process of
debugging it.  In fact it would have saved me a whole lot of time this
week.

Note that this is different from the DSDT-append-to-initrd approach that
was discussed previously.  I think it is a better design now, but
curious about your thoughts.

Thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFED6V9IonHnh+67jkRAtJUAKCldUmBKJ1HKJR1jJEe55WGlGVdawCgv1EO
eujFbn800wHDFSXXtyZLNY4=
=fTAZ
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
