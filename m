Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTESVUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTESVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:20:23 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:14976 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262818AbTESVUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:20:21 -0400
Date: Mon, 19 May 2003 22:33:18 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: david@pleyades.net
Subject: Re: e100 driver
Message-ID: <20030519213318.GB1605@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Linux-kernel <linux-kernel@vger.kernel.org>, david@pleyades.net
References: <20030519211248.GA7633@fargo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20030519211248.GA7633@fargo>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir eternal.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2003 at 11:12:48PM +0200, David G=F3mez wrote:
> Is there some known problem in 2.4.20 with the e100 driver? I've been seen
> lately a lot of errors in my kernel logs, with the messages:
>=20
> <31>May 19 09:05:42 kernel: hw tcp v4 csum failed
> <31>May 19 09:11:11 kernel: icmp v4 hw csum failure
>=20
> repeated several times. I've switched back to the eepro100 driver and the
> checksum errors messages seems to go away...

   I get this, too, on two recently-purchased machines. I suspect that
the new revs of the chips are the cause -- my kernel doesn't seem to
know about many of the device IDs on this board:

hrm@cader:~$ lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 03)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev 03)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 02)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 82)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 02)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev =
02)
01:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 82)

   Other than the odd csum failures (average of 1-2 a day on each
box), it all seems to work perfectly.

   Hugo.

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
          --- ...  one ping(1) to rule them all, and in the ---         =20
                         darkness bind(2) them.                         =20

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yU2essJ7whwzWGARAjMxAJ90dsA3P3JE+XvtXWvBttcSuALwJwCeIrq8
Bi8j+X0Fem75OoI3uTzYOq4=
=JJq4
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
