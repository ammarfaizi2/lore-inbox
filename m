Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbTGETQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266447AbTGETQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:16:10 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:9364 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266434AbTGETOf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:35 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH 2.4.21-bk1] RPC server socket compile warning fix
Date: Sat, 5 Jul 2003 20:06:08 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052006.08084.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: int format, long unsigned int arg (arg 3)"
compiletime warning.

- --- net/sunrpc/svcsock.c.orig   2003-07-05 19:09:49.000000000 +0200
+++ net/sunrpc/svcsock.c        2003-07-05 20:03:10.000000000 +0200
@@ -826,7 +826,7 @@
                        goto error;
                svsk->sk_tcplen += len;
                if (len < want) {
- -                       dprintk("svc: short recvfrom while reading record length (%d of %d)\n",
+                       dprintk("svc: short recvfrom while reading record length (%d of %lu)\n",
                                len, want);
                        svc_sock_received(svsk);
                        return -EAGAIN; /* record header not complete */

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 19:52:50 up 55 min,  3 users,  load average: 1.20, 1.31, 1.21

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE/BxOQoxoigfggmSgRAod8AJsEqoJIUp0TTJsbQWrsWY9IQGOAJACYxEx/
+6/mn7yqWXqQda3AtUewyw==
=DzuI
-----END PGP SIGNATURE-----


