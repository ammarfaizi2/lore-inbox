Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUHPKLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUHPKLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHPKLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:11:42 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:65459 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S267503AbUHPKLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:11:40 -0400
Date: Mon, 16 Aug 2004 12:11:36 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Glyph Lefkowitz <glyph@divmod.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency in thread/signal interaction in 2.6.5 and
 previous	vs. 2.6.6 and later (possibly a bug?)
Message-ID: <20040816121136.49bb3fc2@phoebee>
In-Reply-To: <1092650465.3394.13.camel@localhost>
References: <1092650465.3394.13.camel@localhost>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__16_Aug_2004_12_11_36_+0200_.BH4G0s/7r50JnuN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__16_Aug_2004_12_11_36_+0200_.BH4G0s/7r50JnuN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 16 Aug 2004 06:01:05 -0400
Glyph Lefkowitz <glyph@divmod.com> bubbled:

> Hello Kernel People,
> 
> Firstly, here is a brief example of some code that behaves very
> differently on 2.6.5 and 2.6.6:
> 
> http://www.twistedmatrix.com/users/glyph/signal-bug.c
> 
> I have verified that it says "Completed" on kernel 2.6.5, 2.6.3 and
> 2.6.1, and says "Died" on 2.6.6, 2.6.7 and 2.6.8.1, so I am pretty
> sure the difference is between 2.5.6 and 2.6.6.
> 

FYI:
# gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.

# cat /proc/version 
Linux version 2.6.8-rc2-mm1 (root@phoebee) (gcc version 3.3.3 20040412
(Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 Wed Jul 28 11:39:48
CEST 2004

-- 
MyExcuse:
Flat tire on station wagon with tapes.  ("Never underestimate the
bandwidth of a station wagon full of tapes hurling down the highway"
Andrew S. Tannenbaum)

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__16_Aug_2004_12_11_36_+0200_.BH4G0s/7r50JnuN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIIhamjLYGS7fcG0RAkdGAJ9vjr1IcCg0Wy4U5sFcoPUR7HRJRACeJMpZ
sfDwEP94Mq4bvnHY44L0Pcs=
=ke1d
-----END PGP SIGNATURE-----

--Signature=_Mon__16_Aug_2004_12_11_36_+0200_.BH4G0s/7r50JnuN--
