Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUF2UHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUF2UHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUF2UGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:06:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:1679 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266012AbUF2UGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:06:02 -0400
X-Authenticated: #5082238
Date: Tue, 29 Jun 2004 22:05:58 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: possible arp table corruption [2.4.18]
Message-ID: <20040629200558.GH25252@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I noticed a few strange errors in the arp table of a local firewall serving
about 300 connected computers.
This PC is running 2.4.18 (Debian Woody) and I get the list via the program
"arp" (version 1.60-4, called from inside a python script). This script is =
called
about every 20 seconds.

I don't know if the kernel or "arp" or something else is broken, but I don't
think "arp" does change much before printing the output. That is why I think
posting the problem to this list is not very wrong.

Here are some examples of the errors:

134.130.48.66            ether   00:00:5A:13:3A:36   C   eth0
134.130.49.152           ether   00:50:04:46:8A:B2   C   eth0 <- wrong!
134.130.49.45            ether   00:50:FC:FF:62:4E   C   eth0

---

134.130.48.240           ether   00:02:3F:AF:3C:B4   C   eth0
134.130.48.157           ether   00:10:4B:45:86:6C   C   eth0 <- OK
134.130.48.157           ether   00:10:4B:45:86:6C   C   eth0 <- double!
134.130.48.213           ether   00:0E:A6:3B:41:81   C   eth0

---

134.130.48.186           ether   00:04:61:52:CC:9F   C   eth0=20
134.130.49.41            ether   00:02:3F:68:67:E9   C   eth0 <- OK
134.130.48.40            ether   00:02:3F:68:67:E9   C   eth0 <- MAC repeat=
ed
134.130.48.40            ether   00:07:95:04:C8:3C   C   eth0 <- OK
134.130.49.159           ether   00:E0:18:2D:95:F0   C   eth0

I also got a "134.130.4x.6xx" IP a few times, but that case is not in my lo=
gs.

Please tell me
   - if there is a known bug in (at least) 2.4.18
   - if "arp" is broken
   - if I am doing something wrong

Please also reply directly to me, because the LKML is quite complex.

Thank you very much,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4cumjUF4jpCSQBQRAom9AJ4vgyxJX1mPcIYRjPUPVQvmoRMbRACgo2Qf
lGaEGVvlw+Ch346rwE2y0fQ=
=M5Jp
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
