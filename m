Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVHFVaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVHFVaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVHFVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 17:30:18 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:25749 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261240AbVHFVaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 17:30:16 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] ARCH_HAS_IRQ_PER_CPU avoids dead code in __do_IRQ()
Date: Sat, 6 Aug 2005 23:28:50 +0200
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200508061814.31719.annabellesgarden@yahoo.de>
In-Reply-To: <200508061814.31719.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1894358.lfxHAMAbR9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508062329.05081.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1894358.lfxHAMAbR9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Karsten,

On Saturday 06 August 2005 18:14, Karsten Wiese wrote:
> From: Karsten Wiese <annabellesgarden@yahoo.de>
>=20
> IRQ_PER_CPU is not used by all architectures.
> To avoid dead code generation in __do_IRQ()
> this patch introduces the macro ARCH_HAS_IRQ_PER_CPU.
>=20
> ARCH_HAS_IRQ_PER_CPU is defined by architectures using
> IRQ_PER_CPU in their
> 	include/asm_ARCH/irq.h
> file.

Why not the other way around?

Just define IRQ_PER_CPU to 0 on architectures not needing it and
add a FAT comment there, that this disables it. Or make it a config option.

Then just leave the code as is and let GCC optimize the dead code
away without any changes in the C file. It works, I just checked it ;-)


Regards

Ingo Oeser


--nextPart1894358.lfxHAMAbR9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9SuhU56oYWuOrkARAtftAKDC5uhT9NCud3LG7MfH4xTRHJUxvACgznFM
/J8Wc7c3PPxSXcDrg+ugr1o=
=N8SW
-----END PGP SIGNATURE-----

--nextPart1894358.lfxHAMAbR9--
