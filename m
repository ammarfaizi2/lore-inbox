Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbTGETTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbTGETSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:18:01 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:32404 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266443AbTGETOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:51 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Tom Zerucha <tz@execpc.com>
Subject: [PATCH 2.4.21-bk1] Qlogic compile warning fix
Date: Sat, 5 Jul 2003 21:28:38 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052114.38023.fsdeveloper@yahoo.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

FIXME: Tom, are you the maintainer?


fixes "Warning: passing arg 1 of `scsi_unregister' from incompatible pointer type"
compiletime warning.

- --- drivers/scsi/qlogicfas.c.orig       2003-06-13 20:52:42.000000000 +0200
+++ drivers/scsi/qlogicfas.c    2003-07-05 21:09:59.000000000 +0200
@@ -647,7 +647,7 @@
        if(request_irq(qlirq, do_ql_ihandl, SA_SHIRQ, "qlogicfas", hreg) < 0)
 #endif
        {
- -               scsi_unregister(host);
+               scsi_unregister((struct Scsi_Host*)host);
                goto err_release_mem;
        }
 #endif

- --
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 21:10:16 up  2:13,  3 users,  load average: 0.44, 0.25, 0.23



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BybmoxoigfggmSgRAtihAJ9ktdjsk2/6YoRqleRqDb6TDY6XQwCfaORR
ZuSI2KFHPWcjgnUcjR9eDBI=
=bu/y
-----END PGP SIGNATURE-----

