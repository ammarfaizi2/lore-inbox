Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbTB1OLN>; Fri, 28 Feb 2003 09:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTB1OLN>; Fri, 28 Feb 2003 09:11:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45838 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267927AbTB1OLL>; Fri, 28 Feb 2003 09:11:11 -0500
Date: Fri, 28 Feb 2003 09:17:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Valdis.Kletnieks@vt.edu
cc: Thomas Molina <tmolina@cox.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATED PATCH] Re: 2.5.63 - if/ifdef janitor work - actual bug found.. 
In-Reply-To: <200302272102.h1RL2tJT014398@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.3.96.1030228091558.25875C-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; BOUNDARY="==_Exmh_1409932887P"; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"
Content-ID: <Pine.LNX.3.96.1030228091558.25875D@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--==_Exmh_1409932887P
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <14388.1046379775.1@turing-police.cc.vt.edu>

On Thu, 27 Feb 2003 Valdis.Kletnieks@vt.edu wrote:

> On Thu, 27 Feb 2003 14:42:50 CST, Thomas Molina said:
> 
> > Why couldn't it be MAY_OWNER_OVERRIDE??? There are occurrences of 
> > MAY_OWNER_OVERRIDE
> 
> Yes, but then the logic becomes:
> 
> #if (a | b | MAY_OWNER_OVERRIDE) & (c | d | MAY_OWNER_OVERRIDE)
> #error ....
> #endif
>  
> so it will *alway* error out.  Tried it, it #errored, I looked at it
> more closely.  The logic there is that it wants to have the two sets
> (SATTR, TRUNC, LOCK, LOCAL_ACCESS) and (READ, WRITE, EXEC, OVERRIDE) 
> as disjoint sets of bits.

Thanks for that clarification, I had kept the original message to ask the
same question. Actually, while you are fixing this, how about putting in a
comment line saying what you just told us? It makes reading the code much
easier!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--==_Exmh_1409932887P
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030228091558.25875E@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Xnz/cC3lWbTT17ARAnXbAKDhV3cXEo/cZYe02dkK31nfVmT9OQCggTJE
ZhHgoiSzkZE+S4DNEQSKSWI=
=UM2J
-----END PGP SIGNATURE-----

--==_Exmh_1409932887P--
