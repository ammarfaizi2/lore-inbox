Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbTGETTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbTGETRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:17:48 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:15252 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266441AbTGETOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:48 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-bk1] head.S compile warning fix
Date: Sat, 5 Jul 2003 21:28:16 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052128.16674.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: extra tokens at end of #endif directive"
compiletime warning.

- --- arch/i386/kernel/head.S.orig        2003-06-13 20:52:34.000000000 +0200
+++ arch/i386/kernel/head.S     2003-07-05 21:26:03.000000000 +0200
@@ -113,7 +113,7 @@
        popfl
        jmp checkCPUtype
 1:
- -#endif CONFIG_SMP
+#endif /* CONFIG_SMP */
 
 /*
  * Clear BSS first so that there are no surprises...

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 21:26:26 up  2:29,  3 users,  load average: 0.36, 0.12, 0.11

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BybQoxoigfggmSgRAkCDAJsGDEN/u9C+5nOjjQQw4q9lUrtPAwCfV145
wELFwa7s8HcHfskg68D4pNE=
=NMPf
-----END PGP SIGNATURE-----


