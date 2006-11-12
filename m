Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932974AbWKLRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932974AbWKLRPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932975AbWKLRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:15:19 -0500
Received: from pool-72-66-199-5.ronkva.east.verizon.net ([72.66.199.5]:4807
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932974AbWKLRPS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:15:18 -0500
Message-Id: <200611121715.kACHF6nt029832@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.19-rc5-mm1 - ver_linux additions
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163351706_6400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Nov 2006 12:15:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163351706_6400P
Content-Type: text/plain; charset=us-ascii


scripts/ver_linux needed some minor clean-ups, as follows:
1) Add reporting of actual oprofile release
2) Add reporting of actual wireless-tools release

Signed-Off-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
--- linux-2.6.19-rc5-mm1/scripts/ver_linux.dist	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.19-rc5-mm1/scripts/ver_linux	2006-11-12 12:02:41.000000000 -0500
@@ -87,10 +87,16 @@
 loadkeys -V 2>&1 | awk \
 '(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
 
+oprofiled --version 2>&1 | awk \
+'(NR==1 && ($2 == "oprofile")) {print "oprofile              ", $3}'
+
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 
 udevinfo -V 2>&1 | grep version | awk '{print "udev                  ", $3}'
 
+iwconfig --version 2>&1 | awk \
+'(NR==1 && ($3 == "version")) {print "wireless-tools        ",$4}'
+
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
     echo "Modules Loaded         "$X



--==_Exmh_1163351706_6400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFV1aacC3lWbTT17ARAnBrAKCFjkzgIr3F4an4h+sDTsJYVmvylgCfcFNV
GuqdDCp+G64Zhj6U9CfYdjY=
=tmb0
-----END PGP SIGNATURE-----

--==_Exmh_1163351706_6400P--
