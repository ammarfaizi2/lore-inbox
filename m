Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266444AbTGETP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266438AbTGETOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:14:37 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:8340 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266433AbTGETOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:33 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-bk1] linux/fs/buffer.c compile warning fix
Date: Sat, 5 Jul 2003 19:48:49 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307051948.49082.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: label `out_putf' defined but not used"
compiletime warning.

- --- fs/buffer.c.orig    2003-07-05 19:09:47.000000000 +0200
+++ fs/buffer.c 2003-07-05 19:46:44.000000000 +0200
@@ -474,7 +474,6 @@
        ret = do_fdatasync(file);
        up(&inode->i_sem);
 
- -out_putf:
        fput(file);
 out:
        return ret;

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 19:46:52 up 49 min,  3 users,  load average: 1.40, 1.32, 1.17

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Bw+BoxoigfggmSgRAhFcAJ9/xfPGPZeTi0igpY8nzLfUiyIYWgCdGXeB
mlhFm9mPu/nVmdBbApFabnE=
=hoxK
-----END PGP SIGNATURE-----


