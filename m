Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVEZUOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEZUOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEZUOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:14:47 -0400
Received: from [84.77.83.11] ([84.77.83.11]:23523 "EHLO dardhal.24x7linux.com")
	by vger.kernel.org with ESMTP id S261540AbVEZUOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:14:39 -0400
Date: Thu, 26 May 2005 22:14:38 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Cc: roland <for_spam@gmx.de>
Subject: Re: maximum of 256 loop devices - not enough for cdrom server
Message-ID: <20050526201438.GA23028@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org, roland <for_spam@gmx.de>
References: <013d01c5618f$2939d240$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <013d01c5618f$2939d240$2000000a@schlepptopp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday, 26 May 2005, at 03:06:34 +0200,
roland wrote:

> Is there a possible solution for this "problem" ?
>=20
Beware: not a kernel hacker, not even a proficient programmer.

It seems it would be easy, just changing the max current loop device
number value (256) to something higher (i.e., 4096). Note, however, that
loop devices are described by an array of structs statically allocated at
module load time, so expect memory usage to grow linearly and search operat=
ions=20
on the array become slower at least linearly.

There is one thing that maybe would need some attetion: minor number
allocation for loopback block devices. Now they are assigned at module
initialization, but I don't know the current status in the Linux kernel
with respect to (major,minor) sizes and allocation.

Hope someone more knowledgeable jumps into this :-)

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.11.10)


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCli4uao1/w/yPYI0RAoxEAJ99B8opRnZumWK6lpWinTMyyx4m5gCfYB7q
ECLInMICnvHlUbBZhufoYXU=
=TQW6
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
