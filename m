Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVA3P4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVA3P4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVA3P4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:56:49 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:46061 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261720AbVA3P4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:56:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Date: Sun, 30 Jan 2005 16:45:08 +0100
User-Agent: KMail/1.6.2
Cc: ralf@linux-mips.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bunk@stusta.de
References: <20050129131134.75dacb41.akpm@osdl.org> <20050130001555.GA3648@linux-mips.org> <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
In-Reply-To: <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_JEQ/BFUC7nowt3j";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501301645.14069.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_JEQ/BFUC7nowt3j
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 30 Januar 2005 14:05, Atsushi Nemoto wrote:
> >>>>> On Sun, 30 Jan 2005 00:15:55 +0000, Ralf Baechle <ralf@linux-mips.o=
rg> said:
> ralf> Ask for SERIAL_TXX9 only on those devices that actually have
> ralf> one.
>=20
> Well, "depends on MIPS || PCI" was intentional.  The driver can be
> used for both TX39/TX49 internal SIO and TC86C001 PCI chip.  TC86C001
> chip can be available for any platform with PCI bus (though I have
> never seen it on platform other than MIPS ...)
 =09
There is at least one device that uses the same uart on a non-MIPS
platform. I'll submit a patch once I have it working.

> So I suppose "depends on HAS_TXX9_SERIAL || PCI" might be better, but
> Ralf's patch will be OK for now.

Right. There is however one bigger problem with the original patch:
It removes the driver for tx3912 and adds one for tx3927/tx49xx.
AFAICS, the 3912 has a very different register layout from the other
chips, so the old driver must not be removed yet.

	Arnd <><

--Boundary-02=_JEQ/BFUC7nowt3j
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/QEJ5t5GS2LDRf4RAnqcAJ0emsuxeMqq5Ki1yd+J7anEFs+T6QCghJ0j
GyW95ObG3gSbtLlKSuycvms=
=aX/o
-----END PGP SIGNATURE-----

--Boundary-02=_JEQ/BFUC7nowt3j--
