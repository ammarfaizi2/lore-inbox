Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265523AbTF2CWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265524AbTF2CWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:22:00 -0400
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:17025 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265523AbTF2CV7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:21:59 -0400
Message-Id: <200306290236.h5T2a5Gk004076@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: "Luca T." <luca-t@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: /dev/random broken? 
In-Reply-To: Your message of "Sat, 28 Jun 2003 19:10:18 PDT."
             <20030629021018.GA26162@andromeda> 
From: Valdis.Kletnieks@vt.edu
References: <E19WOvK-0001I7-00@andromeda>
            <20030629021018.GA26162@andromeda>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1681803940P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Jun 2003 22:36:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1681803940P
Content-Type: text/plain; charset=us-ascii

On Sat, 28 Jun 2003 19:10:18 PDT, Justin Pryzby said:
> /dev/urandom is what you want; it makes up its own entropy.  /dev/random
> uses entropy from user input (low order bits I imagine).

Strictly speaking, urandom doesn't "make up" any entropy - it generates
a pseudorandom stream of bits of arbitrary length using a small chunk of
entropy from the entropy pool.  That's why it's able to generate multi-megabyte
streams of bits even when the entropy pool is empty - it is generating a
fixed but unpredictable stream based on the initial entropy.

The distinction is important mostly to cryptographers - for almost all
practical uses, the pseudorandom stream of bits produced by urandom
is quite sufficient, much faster, and leaves the entropy pool untouched
for those applications that *do* care about the difference....

--==_Exmh_1681803940P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+/lCUcC3lWbTT17ARAq9pAJ91EWCX4Qs6tL0ISLBd3BSUM2XGrQCg7+I/
+6OnTN6xUMzeYBLuqT+uSsM=
=e6ko
-----END PGP SIGNATURE-----

--==_Exmh_1681803940P--
