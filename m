Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUJ3PBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUJ3PBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUJ3O6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:58:14 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:5822 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261213AbUJ3Ok7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:59 -0400
Message-ID: <4183A7EE.40303@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:46 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 22/28] add boot message
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF587588DDB87DB803AD11392"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF587588DDB87DB803AD11392
Content-Type: multipart/mixed;
 boundary="------------070705060408070403050204"

This is a multi-part message in MIME format.
--------------070705060408070403050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add boot message


--------------070705060408070403050204
Content-Type: text/x-patch;
 name="boot_msg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot_msg.diff"

Add a brief message describing running scheduler to dmesg.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/init/main.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/init/main.c	2004-10-29 21:42:39.439489757 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/init/main.c	2004-10-29 21:48:34.634056880 +1000
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/sched.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -590,6 +591,7 @@ asmlinkage void __init start_kernel(void
 
 	acpi_early_init(); /* before LAPIC and SMP init */
 
+	printk("Running with %s cpu scheduler.\n", scheduler->cpusched_name);
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }


--------------070705060408070403050204--

--------------enigF587588DDB87DB803AD11392
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6fuZUg7+tp6mRURAlWPAJ4j5JxoKFr+E73zGEB+hGR5s2xeTQCfbAci
9GTKcBkPkTARr2bsGhGuKig=
=cXCv
-----END PGP SIGNATURE-----

--------------enigF587588DDB87DB803AD11392--
