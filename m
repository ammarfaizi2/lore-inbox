Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUFVN7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUFVN7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUFVN7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:59:04 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:26860 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263725AbUFVN6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:58:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] iSeries virtual i/o sysfs files
Date: Tue, 22 Jun 2004 15:57:02 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au> <40D7CFBC.30706@pobox.com> <20040622212319.2a0c121b.sfr@canb.auug.org.au>
In-Reply-To: <20040622212319.2a0c121b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_2qD2A/wJWFQeyjF";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221557.11123.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_2qD2A/wJWFQeyjF
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dienstag, 22. Juni 2004 13:23, Stephen Rothwell wrote:
> =A0To enumerate the other
> devices precisely, I will need to extract the device probing code from
> each of the other device drivers (viodasd, viocd and viotape) and include
> some (hopefully simplified) form of the code directly into the bus probing
> code for iSeries in vio.c.

That sounds like what we did for s390 devices as well. I'm not sure
how similar your virtual devices are to each other, but for the 'ccw'
bus it turned out that all drivers had some version of a large
probing loop that goes through all device numbers.
Consolidating that code made it much cleaner while also allowing us
do the basic probing in parallel.

	Arnd <><

--Boundary-02=_2qD2A/wJWFQeyjF
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2Dq25t5GS2LDRf4RAkdlAJ957oRZBivTRYMzZz/AminSuiMtZwCeN80/
NCOxJRyDaGYkCnzzBao5aGA=
=jXtl
-----END PGP SIGNATURE-----

--Boundary-02=_2qD2A/wJWFQeyjF--
