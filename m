Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266429AbTGETOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266433AbTGETOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:14:31 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:5780 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266429AbTGETOa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:30 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       GOTO Masanori <gotom@debian.or.jp>
Subject: [PATCH 2.4.21-bk1] NinjaSCSI compile warning fix
Date: Sat, 5 Jul 2003 19:32:26 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307051932.36743.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: extra tokens at end of #endif directive"
compiletime warnings.


- --- drivers/scsi/nsp32.h.orig   2003-06-13 20:52:42.000000000 +0200
+++ drivers/scsi/nsp32.h        2003-07-05 19:22:42.000000000 +0200
@@ -425,5 +425,5 @@
 #define BUSPHASE_STATUS      ( BUSMON_STATUS      & BUSMON_PHASE_MASK )
 #define BUSPHASE_SELECT      ( BUSMON_SEL | BUSMON_IO )
 
- -#endif _NSP32_H
+#endif /* _NSP32_H */
 /* end */
- --- drivers/scsi/nsp32_io.h.orig        2003-06-13 20:52:42.000000000 +0200
+++ drivers/scsi/nsp32_io.h     2003-07-05 19:23:30.000000000 +0200
@@ -265,5 +265,5 @@
        nsp32_multi_write4(base, FIFO_DATA_LOW, buf, count);
 }
 
- -#endif _NSP32_IO_H
+#endif /* _NSP32_IO_H */
 /* end */

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 19:24:46 up 27 min,  3 users,  load average: 1.11, 1.31, 1.14

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Bwu0oxoigfggmSgRAoLxAKCCru2aWaBkwPhi+QOre7l3zk2xowCeM3h/
j4n9XSErLXxcat8XAVHCRO8=
=duVk
-----END PGP SIGNATURE-----


