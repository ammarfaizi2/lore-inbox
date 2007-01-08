Return-Path: <linux-kernel-owner+w=401wt.eu-S965302AbXAHJvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbXAHJvJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbXAHJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:51:09 -0500
Received: from mail.isohunt.com ([69.64.61.20]:54963 "EHLO mail.isohunt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965310AbXAHJvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:51:08 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 04:51:07 EST
X-Spam-Check-By: mail.isohunt.com
Date: Mon, 8 Jan 2007 01:44:32 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Intel Core Duo/Duo2 T2300/E6400 - Hyper-Threading (the absence of)
Message-ID: <20070108094432.GF5276@curie-int.orbis-terrarum.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, robbat2@gentoo.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Please CC me, I am not subscribed to LKML [I have set the
Mail-Followup-To header accordingly]).

On two of my new machines, with Intel Core Duo T2300 and Core2 Duo E6400
chips respectively, I noticed some weirdness in how many CPUs are
present.=20

If the hyper-threading bit is present in the CPU info, should there
always be a an extra CPU presented to the system per physical core?

Both the Core1 and Core2 chips I have the ht bit set, but present only
their two physical cores to the system. No access to the hyper-threading
capabilities at all. I also see no configuration options in the BIOS to
enable or disable hyper-threading. That is, /proc/cpuinfo and all
topology data only shows 2 CPUs present, and that they are not the HT
pair.
(CONFIG_NR_CPUS=3D8 is set).

(This was originally triggered by somebody else's code that read the CPU
flags, saw hyper-threading, and decided there were 2x cpus for each
physical core. Said code has already been taken out back and shot
repeatedly).

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFohKAPpIsIjIzwiwRAoXJAJ9CMrKqy4fZsL8LHNrLTubd2/QtxwCg2VMG
EQAgZYiU/IokIdw/9Zzc4pM=
=Scpd
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
