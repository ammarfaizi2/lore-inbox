Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWAVJPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWAVJPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 04:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAVJPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 04:15:00 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:15764 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932244AbWAVJO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 04:14:59 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPW2100 fails to load firmware when booting on battery
Date: Sun, 22 Jan 2006 10:14:44 +0100
User-Agent: KMail/1.7.2
Cc: Olaf Hering <olh@suse.de>, Manuel Estrada Sainz <ranty@debian.org>
References: <20060121201848.GA19221@suse.de>
In-Reply-To: <20060121201848.GA19221@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1566371.6shmIeInq0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601221014.52422.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1566371.6shmIeInq0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 January 2006 21:18, Olaf Hering wrote:
> We carry this patch around since a while. Is it safe to increase the
> timeout also in mainline?
>=20
> References: https://bugzilla.novell.com/show_bug.cgi?id=3D74526
>=20
> IPW2100 fails to load firmware when booting on battery; increasing the
> timeout solves the problem.
=20
Not needed, can be adjusted from user space, once /sys is mounted.
echo -n 30 >/sys/class/firmware/timeout

The firmware class driver just provides a sane default, nothing else.

If this becomes a very common case (many drivers having big firmware
and userspace needs a lot of time providing it), your patch should go in.
But then the _default_ is wrong for many users.


Regards

Ingo Oeser


--nextPart1566371.6shmIeInq0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD000MU56oYWuOrkARAnkSAJ9wR2khpyal6KZAgu0RQejeAeHbBQCcC3dq
oi3LYwvMOFMw8+icZ5/0YMk=
=Bq5k
-----END PGP SIGNATURE-----

--nextPart1566371.6shmIeInq0--
