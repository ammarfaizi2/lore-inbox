Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVAGTL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVAGTL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVAGTKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:10:04 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22956 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261534AbVAGTHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:07:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Shakthi Kannan <shakstux@yahoo.com>
Subject: Re: mount PCI-express RAM memory as block device
Date: Fri, 7 Jan 2005 20:00:35 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20050107183645.72411.qmail@web54501.mail.yahoo.com>
In-Reply-To: <20050107183645.72411.qmail@web54501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Uxt3BdaZ8rxlAkq";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501072000.36842.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Uxt3BdaZ8rxlAkq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 07 Januar 2005 19:36, Shakthi Kannan wrote:
> I would like to know as to how we can mount a
> filesystem for RAM memory on a PCI-express card.
> System for development is x86 with 2.4.22 kernel.
>=20
You could use the MTD block driver with on the phram device
by simply specifying the address/size of the memory as a module
parameter.  If you need autodetection, the easiest way to do that
would be including the phram MTD driver in your pci device driver.

If you are completely stuck on 2.4.22, it might be easier to
use the old slram driver instead of phram, but generally you
should try to hack on a modern kernel level like 2.6.10 anyway.

	Arnd <><

--Boundary-02=_Uxt3BdaZ8rxlAkq
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB3txU5t5GS2LDRf4RAm1LAJ0SZ/v40xcqpF7zDRwrfmsVSURCcwCfdZpC
/SU0wbJi5ZTslrg1XxfhWv8=
=UJc4
-----END PGP SIGNATURE-----

--Boundary-02=_Uxt3BdaZ8rxlAkq--
