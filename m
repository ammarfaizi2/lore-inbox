Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTGFT5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTGFT5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:57:51 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:14859 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263355AbTGFT5t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:57:49 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-bk2] bootsect.S compile warning fix
Date: Sun, 6 Jul 2003 21:46:50 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307062147.02153.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: extra tokens at end of #ifdef directive"
compiletime warning:

- --- arch/i386/boot/bootsect.S.orig      2001-11-09 22:58:02.000000000 +0100
+++ arch/i386/boot/bootsect.S   2003-07-06 21:41:34.000000000 +0200
@@ -234,7 +234,8 @@
 die:   jne     die                     # %es must be at 64kB boundary
        xorw    %bx, %bx                # %bx is starting address within segment
 rp_read:
- -#ifdef __BIG_KERNEL__                  # look in setup.S for bootsect_kludge
+#ifdef __BIG_KERNEL__
+                                       # look in setup.S for bootsect_kludge
        bootsect_kludge = 0x220         # 0x200 + 0x20 which is the size of the
        lcall   bootsect_kludge         # bootsector + bootsect_kludge offset
 #else

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 21:41:40 up  2:16,  2 users,  load average: 1.04, 1.39, 1.29

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/CHy2oxoigfggmSgRAjwEAJ9G2Qa/BWuhD7DJ6DwQDK2QNKuIDACePrQh
oT8CqgpZYXCwHQ2uECHcYrU=
=Ic2J
-----END PGP SIGNATURE-----

