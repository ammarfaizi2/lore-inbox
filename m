Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUGHLpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUGHLpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGHLpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:45:11 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:39054 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S263962AbUGHLpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:45:02 -0400
Date: Thu, 8 Jul 2004 13:44:59 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Michael Buesch <mbuesch@freenet.de>
Cc: root@chaos.analogic.com, Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-Id: <20040708134459.6970a20b@phoebee>
In-Reply-To: <200407081328.40545.mbuesch@freenet.de>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.53.0407080707010.21439@chaos>
	<200407081328.40545.mbuesch@freenet.de>
X-Mailer: Sylpheed-Claws 0.9.12cvs6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__8_Jul_2004_13_44_59_+0200_hgbQRhHLi.jyLATC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__8_Jul_2004_13_44_59_+0200_hgbQRhHLi.jyLATC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 8 Jul 2004 13:28:38 +0200
Michael Buesch <mbuesch@freenet.de> bubbled:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Quoting "Richard B. Johnson" <root@chaos.analogic.com>:
> > Because NULL is a valid pointer value. 0 is not. If you were
> > to make 0 valid, you would use "(void *)0", which is what
> > NULL just happens to be in all known architectures so far,
> > although that could change in an alternate universe.
> 
> No, that is not true.
> In C/C++ this is true:
> NULL == 0


hmm...

include/linux/stddef.h:

#undef NULL
#if defined(__cplusplus)
#define NULL 0
#else
#define NULL ((void *)0)
#endif

-- 
MyExcuse:
fractal radiation jamming the backbone

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__8_Jul_2004_13_44_59_+0200_hgbQRhHLi.jyLATC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7TO7mjLYGS7fcG0RAly5AJ9h62B9yIoo90eVZZXyxma8KtRgfACgl+ey
bZkWiTMUJpTqmDBYxHScwec=
=iJ3T
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jul_2004_13_44_59_+0200_hgbQRhHLi.jyLATC--
