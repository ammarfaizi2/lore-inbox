Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUHXOJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUHXOJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUHXOJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:09:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2469 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267850AbUHXOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:09:12 -0400
Message-Id: <200408241409.i7OE91PW021326@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: bjornw@axis.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef cleanup for cris port
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1009898428P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 10:09:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1009898428P
Content-Type: text/plain; charset=us-ascii

Another small #if/#ifdef cleanup, to make things safer for compiling with -Wundef

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc1/arch/cris/arch-v10/kernel/debugport.c.ifdef	2004-08-14 01:36:12.000000000 -0400
+++ linux-2.6.9-rc1/arch/cris/arch-v10/kernel/debugport.c	2004-08-24 10:06:14.443566890 -0400
@@ -259,7 +259,7 @@ static struct console sercons = {
 void __init 
 init_etrax_debug(void)
 {
-#if CONFIG_ETRAX_DEBUG_PORT_NULL
+#ifdef CONFIG_ETRAX_DEBUG_PORT_NULL
 	return;
 #endif
 


--==_Exmh_-1009898428P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK0v8cC3lWbTT17ARAnKqAJ9J7gwj8mrID10daprCUm/ZIXRIKwCfcihs
T2WambWQ9hzdSa/x0sniEmw=
=xXE3
-----END PGP SIGNATURE-----

--==_Exmh_-1009898428P--
