Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbVBDTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbVBDTQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbVBDTKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:10:06 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:6325 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261934AbVBDTHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:07:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: olof@austin.ibm.com (Olof Johansson)
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Date: Fri, 4 Feb 2005 19:57:06 +0100
User-Agent: KMail/1.6.2
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org,
       paulus@samba.org, anton@samba.org, hpa@zytor.com
References: <20050204072254.GA17565@austin.ibm.com> <200502041336.59892.arnd@arndb.de> <20050204183514.GB17586@austin.ibm.com>
In-Reply-To: <20050204183514.GB17586@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_CW8ACUJ5uRR8DhR";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502041957.06979.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_CW8ACUJ5uRR8DhR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 04 Februar 2005 19:35, Olof Johansson wrote:
> pSeries will need all cpus enabled since we have them all on various
> machines, etc. I guess Powermac/Maple could benefit from it.

Even on pSeries, we already have CONFIG_POWER4_ONLY, which could be
used to optimize away some of the checks at compile time.

I think it makes sense to extend this a bit to look more like the CPU
selection on i386 or s390 where can set the oldest CPU you want to
support. This also fits nicely with the gcc -mcpu=3D options.

> In the end it depends on how hairy the implementation would get vs=20
> performance improvement.

=46ortunately, that optimization should be easy to do on top of your
patch, so we don't have to decide now.

	Arnd <><

--Boundary-02=_CW8ACUJ5uRR8DhR
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCA8WC5t5GS2LDRf4RAmGxAJ9zivMYwnsLAzVCEqkcRSgd9eT4yQCaA/fo
N87nLOWitDYUyyYJD/hrNBA=
=i9zW
-----END PGP SIGNATURE-----

--Boundary-02=_CW8ACUJ5uRR8DhR--
