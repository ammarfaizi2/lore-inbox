Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLDRxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLDRxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:53:15 -0500
Received: from [68.114.43.143] ([68.114.43.143]:58579 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262740AbTLDRxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:53:13 -0500
Date: Thu, 4 Dec 2003 12:53:11 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: lilo and system maps?
Message-ID: <20031204175311.GF16568@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I'm messing around on one of my dev machines which has 4 possible
kernels installed.  2.4, 2.4-stable, 2.6, 2.6-stable (stable is the last
known good kernel).  I currently have my System.map files laid out as:

/boot/System.map-2.6.0-test11-bk2
/boot/System.map-2.6.0-test10-bk4
etc.

Would it be possible, necessary, sane to have a lilo.conf similar to
this:

image=/boot/vmlinuz-2.4
	label=current
	map=System.map-2.4
	read-only

image=/boot/vmlinuz-2.4.stable
	label=stable
	map=System.map-2.4.stable
	read-only
	optional

image=/boot/vmlinuz-2.6
	label=2.6
	map=System.map-2.6
	read-only
	optional

image=/boot/vmlinuz-2.6.stable
	label=2.6-stable
	map=System.map-2.6.stable
	read-only
	optional


This way when I install a new kernel I can copy the System.map to
/boot/System.map-2.6 instead of keeping up with all the version numbers?
lilo doesn't seem to like the map= arguements.  Does the kernel need the
System.map in a single place, can it figure out where it's at for a
multiple config?

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z3SH8+1vMONE2jsRAthDAKDhILpI30nogBUabLQoUvWhFW1HEwCeOSQk
+uzZaQHgYFHEXOnd7xNCBlw=
=tDS2
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
