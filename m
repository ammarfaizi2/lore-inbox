Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTAVEvk>; Tue, 21 Jan 2003 23:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAVEvk>; Tue, 21 Jan 2003 23:51:40 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16004 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267278AbTAVEvj>; Tue, 21 Jan 2003 23:51:39 -0500
Message-Id: <200301220500.h0M50h9X010389@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Andrew Morton <akpm@digeo.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0 
In-Reply-To: Your message of "Tue, 21 Jan 2003 15:32:55 PST."
             <3E2DD8A7.3F07C40E@digeo.com> 
From: Valdis.Kletnieks@vt.edu
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
            <3E2DD8A7.3F07C40E@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1253370524P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Jan 2003 00:00:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1253370524P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Jan 2003 15:32:55 PST, Andrew Morton said:
> john stultz wrote:
> > 
> > All,
> >         This patch addresses the following problem: Linux cannot properly
> > handle the case where interrupts are disabled for longer then two ticks.
> > 
> 
> Question is: who is holding interrupts off for so long?

Dell Latitude C840 - if you use APM, you drop clock ticks.  And that's
even *with* CONFIG_APM_ALLOW_INTS.  I think I've caught the i8k driver
doing it as well - it seems to be a generic BIOS fuckage.  Make a BIOS
call, drop some ticks.  And unless somebody has a BIOS flash that works
better than Dell's C840A07, we're stuck with it....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1253370524P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+LiV6cC3lWbTT17ARAheQAJ4p9ByPMQLz/kaVgupRHN5T2K1lgACgnuvJ
D493ETFZDLH1/d7BX1hTjec=
=1Lf3
-----END PGP SIGNATURE-----

--==_Exmh_1253370524P--
