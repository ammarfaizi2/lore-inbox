Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271312AbTGQHvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271315AbTGQHvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:51:54 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:36316 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271312AbTGQHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:51:52 -0400
Date: Thu, 17 Jul 2003 04:06:32 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH] scripts/ver_linux patch - Bug 267
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bwindle-kbt@fint.org
Message-id: <200307170406.46272.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_PmuLLsONEG9hT/0kk/kTqA)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_PmuLLsONEG9hT/0kk/kTqA)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patch to make scripts/ver_linux work in 2.6.0-test1

http://bugme.osdl.org/show_bug.cgi?id=267

Josef "Jeff" Sipek, aka Jeff.

- -- 
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FlkNwFP0+seVj/4RAgtoAJ9zMNbxclIE8EpEkz9aMrJ4BZBURQCguHIk
mO97t4v6OM5EJ4yAjEUuMpw=
=pZgC
-----END PGP SIGNATURE-----

--Boundary_(ID_PmuLLsONEG9hT/0kk/kTqA)
Content-type: text/x-diff; charset=us-ascii; name=patch-2.6.0-test1_bug267
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-2.6.0-test1_bug267

--- linux-2.6.0-test1-vanilla/scripts/ver_linux	2003-07-13 23:35:16.000000000 -0400
+++ linux-2.6.0-test1-eva/scripts/ver_linux	2003-07-17 03:53:46.000000000 -0400
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

--Boundary_(ID_PmuLLsONEG9hT/0kk/kTqA)--
