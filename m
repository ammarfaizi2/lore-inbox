Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTALUKD>; Sun, 12 Jan 2003 15:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTALUKC>; Sun, 12 Jan 2003 15:10:02 -0500
Received: from h80ad26bd.async.vt.edu ([128.173.38.189]:12928 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267481AbTALUKB>; Sun, 12 Jan 2003 15:10:01 -0500
Message-Id: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: robw@optonline.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? 
In-Reply-To: Your message of "Sun, 12 Jan 2003 14:59:57 EST."
             <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
            <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1758062902P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 15:18:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1758062902P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jan 2003 14:59:57 EST, Rob Wilkens said:

> In general, if you can structure your code properly, you should never
> need a goto, and if you don't need a goto you shouldn't use it.  It's
> just "common sense" as I've always been taught.  Unless you're
> intentionally trying to write code that's harder for others to read.

Now, it's provable you never *NEED* a goto.  On the other hand, *judicious*
use of goto can prevent code that is so cluttered with stuff of the form:

        if(...) {
		...
		die_flag = 1;
		if (!die _flag) {...
		
Pretty soon, you have die_1_flag, die_2_flag, die_3_flag and so on,
rather than 3 or 4 "goto bail_now;".

The real problem is that C doesn't have a good multi-level "break" construct.
On the other hand, I don't know of any language that has a good one - some
allow "break 3;" to break 3 levels- but that's still bad because you get
screwed if somebody adds an 'if' clause....


--==_Exmh_1758062902P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Ic2ecC3lWbTT17ARAgeFAJwPeR4EZ8YDxqhb5uYIQgjhfnK+TgCdG7mt
HHdwNfbe8FVARMNs7guE50A=
=oXcC
-----END PGP SIGNATURE-----

--==_Exmh_1758062902P--
