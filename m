Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264310AbUD0UEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUD0UEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUD0UEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:04:23 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:8837 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264310AbUD0UER (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:04:17 -0400
Message-Id: <200404272004.i3RK4AY1020148@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix thinkos in #if -> #ifdef conversions 
In-Reply-To: Your message of "Tue, 27 Apr 2004 12:24:09 PDT."
             <20040427192408.GC1655@smtp.west.cox.net> 
From: Valdis.Kletnieks@vt.edu
References: <20040427192408.GC1655@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1942918319P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Apr 2004 16:04:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1942918319P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Apr 2004 12:24:09 PDT, Tom Rini <trini@kernel.crashing.org>  said:
> <donning brown paper bag>
> When I changed some '#if FOO' tests to '#ifdef FOO' I forgot to make
> sure that nothing was doing #define FOO 0.  So after auditing all of the
> changes I made, the following is needed:

You're not the first to do that - I stayed away from preprocessor variables
other than CONFIG_* when I chunked through a big #if/#ifdef cleanup a few
months ago, simply because my poor brain was too tiny to figure out what was
intended.

Oddly enough, all the abuses I gave up on trying to figure out were
of the form '#if FOO_DEBUG > N', while the non-debugging comparisons
in a #if were all fairly clear.  That says something about kernel programmers,
but I'm not sure what.. :)


--==_Exmh_-1942918319P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAjry5cC3lWbTT17ARAmgGAKDi8QIMD2nNo5T9iimxyfSWZk/mxgCgxlt6
GyYHiov8m5v2e5noeHGtlTM=
=lAyM
-----END PGP SIGNATURE-----

--==_Exmh_-1942918319P--
