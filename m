Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVAaVkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVAaVkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVAaVkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:40:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44493 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261385AbVAaVjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:39:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Date: Mon, 31 Jan 2005 22:29:45 +0100
User-Agent: KMail/1.6.2
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
References: <20050129131134.75dacb41.akpm@osdl.org> <200501312123.11451.arnd@arndb.de> <20050131205342.GA11238@linux-mips.org>
In-Reply-To: <20050131205342.GA11238@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_JNq/BxxIqEcB8Nf";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501312229.45780.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_JNq/BxxIqEcB8Nf
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Maandag 31 Januar 2005 21:53, Ralf Baechle wrote:
> As for the TX3912 issue, there is no remaining user so that driver would
> now be continuing to suffer from accelerated bitrot.

Does this mean that all tx3912 support is deprecated? In that case, you
could remove even more code:

 arch/mips/mm/c-tx39.c     |  123 +++------------
 arch/mips/mm/cache.c      |    1
 drivers/video/Kconfig     |    9 -
 drivers/video/Makefile    |    1
 drivers/video/tx3912fb.c  |  328 -----------------------------------------
 include/asm-mips/tx3912.h |  361 ----------------------------------------------
 include/video/tx3912.h    |   62 -------
 7 files changed, 24 insertions(+), 861 deletions(-)

> Akpm has in
> the meantime sent the patches to Linus, so what's left would be renaming
> the driver, as per your suggestion.

If it's already merged, it's probably not worth the extra moving around.

	Arnd <><

--Boundary-02=_JNq/BxxIqEcB8Nf
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/qNJ5t5GS2LDRf4RAjT1AJ0QZQhtmxeEJwGsp5zsc888AUqweQCggHXP
VAW2Bp6QElzSELY7AgnqX7c=
=5LHn
-----END PGP SIGNATURE-----

--Boundary-02=_JNq/BxxIqEcB8Nf--
