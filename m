Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUKNXOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUKNXOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 18:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUKNXOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 18:14:55 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:11722 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261372AbUKNXOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 18:14:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] - UML - remove some dead code
Date: Mon, 15 Nov 2004 00:08:49 +0100
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200411142304.iAEN4YbV013371@ccure.user-mode-linux.org>
In-Reply-To: <200411142304.iAEN4YbV013371@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_DW+lBrlf8xrfogX";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411150008.51110.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_DW+lBrlf8xrfogX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Maandag 15 November 2004 00:04, Jeff Dike wrote:
> Bodo pointed out that arch/um/kernel/skas/exec_user.c is dead code, so
> this removes it.

Speaking of dead code: I think you should be able to mostly get rid of
the KERNEL_CALL hack in include/asm-um/unistd.h, since all kernel syscalls
except execve are now gone.

It should be enough to have an out of line version of execve and do

#undef __KERNEL_SYSCALLS
#include "asm/arch/unistd.h"
extern int execve(const char *filename, char *const argv[],
			char *const envp[]);

	Arnd <><

--Boundary-02=_DW+lBrlf8xrfogX
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBl+WD5t5GS2LDRf4RAmeyAJ9bUKx0FtS42Z4Hpxtko9Kv9OckTACfTGEC
df7P7UZnyyRAS7HwzFePNz0=
=1jQJ
-----END PGP SIGNATURE-----

--Boundary-02=_DW+lBrlf8xrfogX--
