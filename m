Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTCCPud>; Mon, 3 Mar 2003 10:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTCCPud>; Mon, 3 Mar 2003 10:50:33 -0500
Received: from nef.ens.fr ([129.199.96.32]:30482 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S266233AbTCCPu3>;
	Mon, 3 Mar 2003 10:50:29 -0500
Date: Mon, 3 Mar 2003 17:00:50 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: /dev/mem and highmem
Message-ID: <20030303160050.GA17182@clipper.ens.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Nicolas George <nicolas.george@ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is there any hope to have access to the highmem through /dev/mem, or a
similar device? Or did I miss an already existing method?

Rationale:

These days, bad RAM seems to become dramatically frequent. We have here
a PC with a few bad bits (switching to ECC is in project), but memtest86
did not find them. Recently, sshd started to segfault. Using cmp -lb
with an uncorrupted version we found the bad bit in the file, and then
looked for it in the phyical memory with `xxd /dev/mem | grep'. We found
it, disabled the area using mem=3D boot parameter.

Now this PC has a crontab that will write pseudo-random data in the
disabled area, and later read it back and compare it with the original
to find all bad bits.

Then I have another PC with bad RAM, I also discovered a file affected,
and tried the same method. Unfortunately the grep failed. The reason is
likely to be that the file was in highmem.

PS: please Cc me the answers.

Regards,

--=20
  Nicolas George

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (SunOS)

iD8DBQE+Y3wxsGPZlzblTJMRAi67AJ46kTS/iyWTOv05aikeBKODP97CVgCfXdA7
Tz6WXJtiyhxUooIsTEhLjyI=
=Z8mx
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
