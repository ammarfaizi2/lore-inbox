Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTCFA7M>; Wed, 5 Mar 2003 19:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTCFA7M>; Wed, 5 Mar 2003 19:59:12 -0500
Received: from coruscant.franken.de ([193.174.159.226]:38625 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S267640AbTCFA7J>; Wed, 5 Mar 2003 19:59:09 -0500
Date: Thu, 6 Mar 2003 02:09:20 +0100
From: Harald Welte <laforge@netfilter.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       David Miller <davem@redhat.com>
Subject: Re: [2.5 patch] remove EXPORT_NO_SYMBOLS from ip6tables code
Message-ID: <20030306010920.GN4880@sunbeam.de.gnumonks.org>
References: <20030305153259.GE2075@zip.com.au> <20030305220542.GM20423@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MmaWY3eZhcRnoVUs"
Content-Disposition: inline
In-Reply-To: <20030305220542.GM20423@fs.tum.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Pungenday, the 63rd day of Chaos in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MmaWY3eZhcRnoVUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2003 at 11:05:42PM +0100, Adrian Bunk wrote:
> The patch that added new ip6tables matches in 2.5.64 added seven=20
> occurances of the obsolete EXPORT_NO_SYMBOLS. The patch below removes=20
> them.

Thanks, this was my fault.  I submitted one patch (for 2.4 and 2.5) to
davem... and obviously this is no longer possible with the intrusive
changes of 2.5.x ...

Davem, please include this into your 2.5.x tree. Thanks.


> cu
> Adrian

--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c.old	2003-03-05 22:57:=
24.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c	2003-03-05 22:57:41.0=
00000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_ah.h>
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 AH match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c.old	2003-03-05 22:58=
:18.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c	2003-03-05 22:58:31.=
000000000 +0100
@@ -15,7 +15,6 @@
=20
 #define HOPBYHOP	0
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 #if HOPBYHOP
 MODULE_DESCRIPTION("IPv6 HbH match");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c.old	2003-03-05 22:59=
:57.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c	2003-03-05 23:00:03.=
000000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_esp.h>
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 ESP match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c.old	2003-03-05 23:0=
0:04.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c	2003-03-05 23:00:10=
.000000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_frag.h>
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 FRAG match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c.old	2003-03-05 23:00=
:11.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c	2003-03-05 23:00:17.=
000000000 +0100
@@ -15,7 +15,6 @@
=20
 #define HOPBYHOP	1
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 #if HOPBYHOP
 MODULE_DESCRIPTION("IPv6 HbH match");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c.old	2003-03-0=
5 23:00:17.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c	2003-03-05 23=
:00:24.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_ipv6header.h>
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 headers match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c.old	2003-03-05 23:00:=
24.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c	2003-03-05 23:00:30.0=
00000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_rt.h>
=20
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 RT match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");


--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--MmaWY3eZhcRnoVUs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+Zp/AXaXGVTD0i/8RAkuZAKCmHZZhSFpzDDm2Q3bG8pFtbKGNvQCgr125
3XaWGmMQ5E/r27j/pFadddE=
=he2N
-----END PGP SIGNATURE-----

--MmaWY3eZhcRnoVUs--
