Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbTGETXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbTGETQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:16:37 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:11156 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266433AbTGETOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:40 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-bk1] AGPGART module compile warning fix
Date: Sat, 5 Jul 2003 20:42:25 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052042.26077.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: assignment from incompatible pointer type"
compiletime warning.

- --- drivers/char/agp/agpgart_be.c.orig  2003-06-13 20:52:36.000000000 +0200
+++ drivers/char/agp/agpgart_be.c       2003-07-05 20:39:10.000000000 +0200
@@ -577,7 +577,7 @@
        for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
                SetPageReserved(page);
 
- -       agp_bridge.gatt_table_real = (unsigned long *) table;
+       agp_bridge.gatt_table_real = (u32*) table;
        agp_gatt_table = (void *)table;
 #ifdef CONFIG_X86
        err = change_page_attr(virt_to_page(table), 1<<page_order, PAGE_KERNEL_NOCACHE);

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 20:40:37 up  1:43,  3 users,  load average: 0.04, 0.46, 0.80

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BxwSoxoigfggmSgRAi2iAJwNsdRGaSwRhadCiwl1sMLbS7nGSwCgg0Gz
RVO5wKcLflF9Ivz9nJc2MqA=
=MM8W
-----END PGP SIGNATURE-----


