Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315399AbSEBUTn>; Thu, 2 May 2002 16:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315400AbSEBUTm>; Thu, 2 May 2002 16:19:42 -0400
Received: from cj3225807-a.sagam1.kn.home.ne.jp ([61.24.10.135]:55936 "HELO
	hokkemirin.linux-dude.net") by vger.kernel.org with SMTP
	id <S315399AbSEBUTk>; Thu, 2 May 2002 16:19:40 -0400
Date: Fri, 03 May 2002 05:18:37 +0900 (JST)
Message-Id: <20020503.051837.74738175.alpha292@bremen.or.jp>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Not detect ADMTek AN983B Rev11
From: Ohta Kyuma <alpha292@bremen.or.jp>
X-Mailer: Mew version 3.0.54 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Signed; protocol="application/pgp-signature";
 micalg=pgp-ripemd160;
 boundary="--Security_Multipart0(Fri_May__3_05:18:37_2002_538)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Security_Multipart0(Fri_May__3_05:18:37_2002_538)--
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_May__3_05:18:37_2002_253)--"
Content-Transfer-Encoding: 7bit

----Next_Part(Fri_May__3_05:18:37_2002_253)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear mainainer of kernel 2.4.x :

Summery          : ADMTek AN983B Rev.11 was detected by dec-tulip driver.
Kernel Version   : 2.4.18
Full Description : Dec tulip driver in drivers/net/tulip (a.k.a tulip.o)
                   is not detect ADMTek AN983B Rev.11 cause of difference
                   of PCI-ID (VENDER:PRODUCT=0x1317:0x9511).
                   For example, this chip is put on MSI MS-6378 motherboard.
                   I resolved this problem ( but temporally...).
                   Please apply to drivers/net/tulip/tulip_core.c .
Regards,
  Ohta.

----Next_Part(Fri_May__3_05:18:37_2002_253)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="drivers.net.tulip_core.c.diff"

*** tulip_core.c.orig	Thu May  2 23:54:40 2002
--- tulip_core.c	Fri May  3 00:02:44 2002
***************
*** 205,211 ****
  	{ 0x1317, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x1317, 0x0985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x1317, 0x1985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
! 	{ 0x13D1, 0xAB02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x13D1, 0xAB03, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x13D1, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x104A, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
--- 205,213 ----
  	{ 0x1317, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x1317, 0x0985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x1317, 0x1985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
! /* ADMTek AN983B Rev 11 (PCI ID=0x9511 )*/
!    	{ 0x1317, 0x9511, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
!         { 0x13D1, 0xAB02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x13D1, 0xAB03, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x13D1, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
  	{ 0x104A, 0x0981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },

----Next_Part(Fri_May__3_05:18:37_2002_253)----

----Security_Multipart0(Fri_May__3_05:18:37_2002_538)--
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQIXAwUAPNGfKkOgzolWKVvGFANa0Qf/UExFGRc0IpJMSbOW2j5x9ZJSWTQpOp08
YGX9D47g8U7ORh7OPo3Gsc6gv8qwN8SXDVOZYAe3cYmGyNyKv9VtJ9vb0kzYKlfN
we/dby9DiQFsQ0gcHzc7mtKVT3yfE6cg7sPYctSo3kVOH0lIUIk4GZIkURm3uuWL
8CWTxexoa+5uNzitvpaPQUzW8tkbeklovGx4G4IcjRc8mzR7vAlUaIb8AwLxS51q
lVqEIdf0Rg7wEu3DVBYowqSBh+pTnOzZdbTcLU2QxEJaL7OtniNnFR+Rre84Np8B
gSjDC+HYECJUpS9sk5YW7w19rT6D/b0EdQZS50+kr/Ni6fQujCAR6gf/cMavGTvk
I7/MaVdBWpucDWwNNOXnW/u8BB8x9tkvmVQOijcqukk/P23lrr3wY9jFDNNUVLfa
wgORuJ+R7WAKdzHnRU6k4dYtyoEeEp/kJC8NyMXNwVVtUZvZyl4q7WGg3i21v8z3
jg4XTSy+TDEDrE1aG0qm3Vdc9blOXMeibksnvrmCbmESexHItD2c1sD0J5/6dBcL
YaF5ETUWOUNA0P67gMnPbZ8aO9wlt95oceeJyVVfiXQ8zQjkrQa6aWKevVq8o8AP
O82ZXJ55ipQw2iwyYJ20hNtsSWSngAcBPEogzOlvg6C9p0Nyj9l5UUniT04tIYmh
9nBO4GwFfUJwKQ==
=///J
-----END PGP SIGNATURE-----

----Security_Multipart0(Fri_May__3_05:18:37_2002_538)----
