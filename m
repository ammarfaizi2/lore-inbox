Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268049AbTBNVIb>; Fri, 14 Feb 2003 16:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268046AbTBNVIC>; Fri, 14 Feb 2003 16:08:02 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39811 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267815AbTBNVH3>; Fri, 14 Feb 2003 16:07:29 -0500
Message-Id: <200302142116.h1ELGwwZ010438@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 - drivers/char/esp.c vs include/linux/serialP.h 
In-Reply-To: Your message of "Fri, 14 Feb 2003 20:54:49 GMT."
             <20030214205449.J14659@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <200302142039.h1EKdYwZ029474@turing-police.cc.vt.edu>
            <20030214205449.J14659@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1177195644P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Feb 2003 16:16:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1177195644P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Feb 2003 20:54:49 GMT, Russell King said:
> On Fri, Feb 14, 2003 at 03:39:34PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > compiling drivers/char/esp.c with -Wundef triggers a warning:
> > 
> > In file included from drivers/char/esp.c:51:
> > include/linux/serialP.h:27:6: warning: "LINUX_VERSION_CODE" is not defined

> My personal feeling woudl be to lop it out, and fix up anywhere
> and everywhere which complains appropraitely.

I jumped the gun, actually - the build was still running, and there's at
least 6 other things that trigger the same serialP.h warning - where there's
a #if (VAR < NNNN) check that Does The Wrong Thing because of the default
gcc behavior for undefineds.  Hopefully this one's harmless - but there's
still 608 other warnings to work through.



--==_Exmh_-1177195644P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TVzKcC3lWbTT17ARAgEHAKDf9Y4pKv/fOlWT4UXCSJ1a5NDWKgCfTprR
zQrBAVfquAPTJ2do2VSrOFM=
=0MMU
-----END PGP SIGNATURE-----

--==_Exmh_-1177195644P--
