Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTBGRFv>; Fri, 7 Feb 2003 12:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBGRFv>; Fri, 7 Feb 2003 12:05:51 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60546 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266228AbTBGRFm>; Fri, 7 Feb 2003 12:05:42 -0500
Message-Id: <200302071715.h17HFD07006005@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.59 : drivers/char/ip2/i2lib.c 
In-Reply-To: Your message of "Fri, 07 Feb 2003 12:17:45 EST."
             <Pine.LNX.4.44.0302071214440.6917-100000@master> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0302071214440.6917-100000@master>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-701383059P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Feb 2003 12:15:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-701383059P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Feb 2003 12:17:45 EST, Frank Davis said:

> +		if ((1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL))
 && (i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 )) {

Hmm... if ((1 == A) && (A > 0)) {

Unless i2QueueCommands has a side-effect on being re-evaluated (which isn't
guaranteed to happen), it looks like this can be simplified a bit,
since the '&& (A > 0)' is superfluous.

I think the code started as 'if A == 1' and became 'if A > 0', or vice
versa, and somebody needs to check what's *REALLY* intended...


-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-701383059P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Q+mhcC3lWbTT17ARAmkOAJ9Dm62bZL1g/j4h5qX4vJbUyyhISwCgivPK
Kf9+dyhus17aM2sf5K2ehhM=
=5QQR
-----END PGP SIGNATURE-----

--==_Exmh_-701383059P--
