Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUJJXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUJJXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 19:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbUJJXiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 19:38:25 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:15037 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S268576AbUJJXiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 19:38:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Aboo Valappil" <aboo@ABOOSPLANET.com>
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Date: Mon, 11 Oct 2004 01:35:16 +0200
User-Agent: KMail/1.6.2
Cc: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>,
       "Fabiano Ramos" <ramos_fabiano@yahoo.com.br>,
       <linux-kernel@vger.kernel.org>
References: <3D6FC8DFDDD0CE44A3BE652A27AD42A54569@naya.aboosplanet.com>
In-Reply-To: <3D6FC8DFDDD0CE44A3BE652A27AD42A54569@naya.aboosplanet.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_4ccaBOKKkFiFwaO";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410110135.20747.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_4ccaBOKKkFiFwaO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Maandag 11 Oktober 2004 01:13, Aboo Valappil wrote:
> I also wanted not associate the file with the current/any
> processes.=20
>=20
> Any ideas on this ?
>=20
> Then I thought of using a work around and avoid opening files in kernel
> mode.

Most of the code that traditionally used to read files from inside the
kernel can be converted to calling request_firmware(). The basic
idea is that you have a user space helper that writes the data into
the kernel instead of the other way round.

	Arnd <><

--Boundary-02=_4ccaBOKKkFiFwaO
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBacc45t5GS2LDRf4RAhkpAJ9TfP6dUbxsJeU1BqS3FleCStQmWQCeOPbp
pNb6BZf9fIsylkYxBML9eB4=
=Ari/
-----END PGP SIGNATURE-----

--Boundary-02=_4ccaBOKKkFiFwaO--
