Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTANJxu>; Tue, 14 Jan 2003 04:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTANJxu>; Tue, 14 Jan 2003 04:53:50 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:24508
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261581AbTANJxt>; Tue, 14 Jan 2003 04:53:49 -0500
Message-ID: <3E23E04B.2050802@redhat.com>
Date: Tue, 14 Jan 2003 10:02:51 +0000
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: new CPUID bit
X-Enigmail-Version: 0.72.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4170116AE57C3200A81391F7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4170116AE57C3200A81391F7
Content-Type: multipart/mixed;
 boundary="------------030809010808000004040709"

This is a multi-part message in MIME format.
--------------030809010808000004040709
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Northwood P4's have one more bit in the CPUID processor info set: bit
31.  Intel calls the feature PBE (Pending Break Enable).

The attached patch for the current BK kernel adds the necessary entry.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------030809010808000004040709
Content-Type: text/plain;
 name="aaa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aaa"

--- /home/drepper/kernel/linux-2.5/arch/i386/kernel/cpu/proc.c-save	2002-12-29 01:24:52.000000000 -0800
+++ /home/drepper/kernel/linux-2.5/arch/i386/kernel/cpu/proc.c	2003-01-14 02:00:33.000000000 -0800
@@ -22,7 +22,7 @@
 	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
 	        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
 	        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
-	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", NULL,
+	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
 
 		/* AMD-defined */
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,

--------------030809010808000004040709--

--------------enig4170116AE57C3200A81391F7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+I+BL2ijCOnn/RHQRAk9yAJd6t2NcGUNuUPBm5hp3zoRGP3ICAKCFYfij
57TI6tCvXZhJFcfXQRaiog==
=P4C6
-----END PGP SIGNATURE-----

--------------enig4170116AE57C3200A81391F7--

