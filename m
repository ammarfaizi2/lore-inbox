Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUHTGzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUHTGzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUHTGzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:55:06 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:1979 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262837AbUHTGy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:54:59 -0400
Message-ID: <4125A036.8020401@kolivas.org>
Date: Fri, 20 Aug 2004 16:54:46 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeremy@goop.org
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] dothan speedstep fix
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07DB70C1F961B1FB0D78384C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07DB70C1F961B1FB0D78384C
Content-Type: multipart/mixed;
 boundary="------------030004070105060904080505"

This is a multi-part message in MIME format.
--------------030004070105060904080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy

My new dothan cpu comes up as stepping 6. This patch fixes speedstep 
support for my laptop unless it can come up as multiple stepping values? 
Now all I need is for a way to make it report the correct L2 cache.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------030004070105060904080505
Content-Type: text/x-patch;
 name="dothan-speedstep-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dothan-speedstep-fix.diff"

Index: linux-2.6.8.1-ck/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.8.1-ck.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-15 14:08:04.000000000 +1000
+++ linux-2.6.8.1-ck/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-20 16:52:19.292124878 +1000
@@ -57,7 +57,7 @@ static const struct cpu_id cpu_id_dothan
 	.x86_vendor = X86_VENDOR_INTEL,
 	.x86 = 6,
 	.x86_model = 13,
-	.x86_mask = 1,
+	.x86_mask = 6,
 };
 
 struct cpu_model

--------------030004070105060904080505--

--------------enig07DB70C1F961B1FB0D78384C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJaA4ZUg7+tp6mRURAmpIAJ4pU2pCNh/tqDHF+FFN83ZW7qXQiACfcy/D
ooTW/B3eMurHPRNnBjPUdPI=
=gFQd
-----END PGP SIGNATURE-----

--------------enig07DB70C1F961B1FB0D78384C--
