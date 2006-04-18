Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDRWqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDRWqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDRWqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:46:05 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51107 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750777AbWDRWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:46:04 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] Kernel doesn't compile with CONFIG_HOTPLUG && !CONFIG_NET
Date: Wed, 19 Apr 2006 08:44:21 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2097297.5xyEGRXhtZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604190844.25476.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2097297.5xyEGRXhtZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

2.6.17-rc1 doesn't compile if networking support is disabled but hotplug is
enabled. This patch addresses that issue.

Please consider applying.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff -ruNp 9904.patch-old/kernel/sysctl.c 9904.patch-new/kernel/sysctl.c
--- 9904.patch-old/kernel/sysctl.c	2006-04-19 08:40:47.000000000 +1000
+++ 9904.patch-new/kernel/sysctl.c	2006-04-17 21:06:23.000000000 +1000
@@ -401,7 +401,7 @@ static ctl_table kern_table[] = {
 		.strategy	= &sysctl_string,
 	},
 #endif
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 	{
 		.ctl_name	= KERN_HOTPLUG,
 		.procname	= "hotplug",

--nextPart2097297.5xyEGRXhtZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERWvJN0y+n1M3mo0RAsmzAKCMD6Se3/GE20hzVtStl9V8knCzsgCeJ6u7
+a9KX9SRdAQbs4YYA11qBOI=
=WD5G
-----END PGP SIGNATURE-----

--nextPart2097297.5xyEGRXhtZ--
