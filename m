Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTKMAL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTKMAL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:11:57 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:31463 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S261764AbTKMALx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:11:53 -0500
Subject: [PATCH] Documentation/sysctl/vm.txt update
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2EHIPDnwLOK8oGugRa1p"
Organization: Linux Networx
Message-Id: <1068681892.28894.28.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Nov 2003 17:04:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2EHIPDnwLOK8oGugRa1p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Now that 2.4.9 is well behind us, it's time to update
Documentation/sysctl/vm.txt.

Thanks

--- linux-2.4.22/Documentation/sysctl/vm.txt	2002-11-28 16:53:08.000000000 =
-0700
+++ linux-2.4.22-bs/Documentation/sysctl/vm.txt	2003-11-12 17:35:11.0000000=
00 -0700
@@ -18,13 +18,10 @@
=20
 Currently, these files are in /proc/sys/vm:
 - bdflush
-- buffermem
-- freepages
 - kswapd
 - max_map_count
 - overcommit_memory
 - page-cluster
-- pagecache
 - pagetable_cache
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -102,38 +99,6 @@
 of buffer cache that is dirty which will stop bdflush.
 The default is 20%, the miniumum is 0%, and the maxiumum is 100%.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-buffermem:
-
-The three values in this file correspond to the values in
-the struct buffer_mem. It controls how much memory should
-be used for buffer memory. The percentage is calculated
-as a percentage of total system memory.
-
-The values are:
-min_percent	-- this is the minimum percentage of memory
-		   that should be spent on buffer memory
-borrow_percent  -- UNUSED
-max_percent     -- UNUSED
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-freepages:
-
-This file contains the values in the struct freepages. That
-struct contains three members: min, low and high.
-
-The meaning of the numbers is:
-
-freepages.min	When the number of free pages in the system
-		reaches this number, only the kernel can
-		allocate more memory.
-freepages.low	If the number of free pages gets below this
-		point, the kernel starts swapping aggressively.
-freepages.high	The kernel tries to keep up to this amount of
-		memory free; if memory comes below this point,
-		the kernel gently starts swapping in the hopes
-		that it never has to do real aggressive swapping.
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 kswapd:
=20
@@ -208,24 +173,6 @@
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-pagecache:
-
-This file does exactly the same as buffermem, only this
-file controls the struct page_cache, and thus controls
-the amount of memory used for the page cache.
-
-In 2.2, the page cache is used for 3 main purposes:
-- caching read() data from files
-- caching mmap()ed data and executable files
-- swap cache
-
-When your system is both deep in swap and high on cache,
-it probably means that a lot of the swapped data is being
-cached, making for more efficient swapping than possible
-with the 2.0 kernel.
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
 pagetable_cache:
=20
 The kernel keeps a number of page tables in a per-processor

--=20
Thayne Harbaugh
Linux Networx

--=-2EHIPDnwLOK8oGugRa1p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/ssqkfsBPTKE6HMkRAs2CAJ95z72g74Nd3FSFXMJh1Ei50U4kkgCeOCw/
apbl25Q//yeaeXaHStTC61M=
=LeVW
-----END PGP SIGNATURE-----

--=-2EHIPDnwLOK8oGugRa1p--

