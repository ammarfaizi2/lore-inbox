Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULROPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULROPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbULROPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:15:44 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:39055 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S261152AbULROPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:15:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: krishna <krishna.c@globaledgesoft.com>
Subject: Re: Documentation on top half and bottom halves
Date: Sat, 18 Dec 2004 15:08:53 +0100
User-Agent: KMail/1.6.2
References: <41C3F9A2.3040700@globaledgesoft.com> <41C4339C.7020005@globaledgesoft.com>
In-Reply-To: <41C4339C.7020005@globaledgesoft.com>
Cc: drizzd@aon.at, Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5nDxBI8X7L184yJ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412181508.57980.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5nDxBI8X7L184yJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 18 Dezember 2004 14:41, you wrote:
> How to understand when to use which mechanism depending upon the hardware:
>=20
> 1) If DMA support is not there and If it is there.
> 2) If Shared Interrupts are there and not there.
> 3) If there are multiple same Host controllers and single Host Controller.

It's independent of these questions. The decision between tasklet and
workqueue is mostly:

=2D If you need non-atomic operations (e.g. allocate memory with GFP_KERNEL=
),
  you have to use work queues.
=2D If you need very low latencies for processing the interrupts, you should
  use tasklets.
=2D When in doubt, use work queues.

 Arnd <><

PS: pleas read http://www.netmeister.org/news/learn2quote.html

--Boundary-02=_5nDxBI8X7L184yJ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBxDn55t5GS2LDRf4RAv+XAKCIDsU8VJsh2CRMcFe22OKtZvR25QCfU7su
/1biuFMp8V30SfkbV4Dnh+A=
=c7sX
-----END PGP SIGNATURE-----

--Boundary-02=_5nDxBI8X7L184yJ--
