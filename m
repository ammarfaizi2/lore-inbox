Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbTA3GWu>; Thu, 30 Jan 2003 01:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTA3GWu>; Thu, 30 Jan 2003 01:22:50 -0500
Received: from h80ad25d7.async.vt.edu ([128.173.37.215]:27266 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267432AbTA3GWt>; Thu, 30 Jan 2003 01:22:49 -0500
Message-Id: <200301300631.h0U6Vxfl003947@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Takeshi Kodama <kodama@flab.fujitsu.co.jp>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why doesn't kernel store ICMP redirect in the routing tables? 
In-Reply-To: Your message of "Thu, 30 Jan 2003 14:36:30 +0900."
             <008401c2c821$8af20cf0$c1a5190a@png.flab.fujitsu.co.jp> 
From: Valdis.Kletnieks@vt.edu
References: <008401c2c821$8af20cf0$c1a5190a@png.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1210627288P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jan 2003 01:31:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1210627288P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Jan 2003 14:36:30 +0900, Takeshi Kodama <kodama@flab.fujitsu.co.jp>  said:

> Is it no matter that it generates ICMP redirect every time flush the route ca
che?  
> 
> Please tell me why kernel has such a specification that doesn't store ICMP re
direct
> in the routing tables.

This is intentional behavior.  Otherwise, if it were entered into the routing
table, it would remain there essentially permanently (unless forced out by
a 'route -f' command or perhaps another ICMP redirect).  In general, if
your default router is telling you to go someplace else, one of two situations
applies:

1) This is a temporary condition caused by a router flap, in which case we
should only cache it, so later we will re-learn a better path.

2) The router is trying to tell you that you should be fixing your routing
table, either by adding static routes or running a full routing protocol.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1210627288P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+OMbecC3lWbTT17ARApVmAJ9pBUa0HKjofPtUYbJ6YrYmzs1p2QCg5vzm
+M6BfqdWNczEbe9lvu0AXxA=
=Cz8o
-----END PGP SIGNATURE-----

--==_Exmh_-1210627288P--
