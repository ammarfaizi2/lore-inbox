Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTANFGu>; Tue, 14 Jan 2003 00:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTANFGu>; Tue, 14 Jan 2003 00:06:50 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:39810 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261593AbTANFGt>; Tue, 14 Jan 2003 00:06:49 -0500
Message-Id: <200301140515.h0E5FVqZ005872@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-Reply-To: Your message of "Mon, 13 Jan 2003 23:15:14 EST."
             <20030114041514.GA4844@gtf.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030114025452.656612C385@lists.samba.org> <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu> <20030114033803.GG404@gtf.org> <200301140353.h0E3rWqZ004900@turing-police.cc.vt.edu>
            <20030114041514.GA4844@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-605521789P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2003 00:15:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-605521789P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jan 2003 23:15:14 EST, Jeff Garzik said:
> But having said that -- see my mail to Rusty about storing the strlen()
> result and then calling memcpy().  It [purposefully] does not address
> the fact that the string may become stale data, because it's the job of
> a higher level to ensure that.  But it does make explicit a compiler
> temporary, and allows us to use the presumeably-faster memcpy().

5 second's thought and another shot of Cherry Coke and it suddenly dawns
on me that memcpy() addresses my concerns as well as strncpy(), and as you
noted is presumably faster as well (since it doesn't have to keep looking for
a terminating null).


--==_Exmh_-605521789P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I5zzcC3lWbTT17ARAmujAKC2PQAXQgUD7ktNCVjoHnew5vc7CQCgyEvI
4saGfUKV/exaJJ4J1nwguf8=
=JDsy
-----END PGP SIGNATURE-----

--==_Exmh_-605521789P--
