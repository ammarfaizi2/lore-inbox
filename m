Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUCIOcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUCIOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:32:04 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:20749 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261955AbUCIOcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:32:01 -0500
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] give root=/dev/ram special handling, needed for root fs on ramdisk
Date: Tue, 9 Mar 2004 16:31:14 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2CCBC5YH0VOGGGY77BWS"
Message-Id: <200403091631.14392.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2CCBC5YH0VOGGGY77BWS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This fixes a regression versus 2.4 reported earlied,
see http://lkml.org/lkml/2004/3/5/45
--=20
vda
--------------Boundary-00=_2CCBC5YH0VOGGGY77BWS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dev_ram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dev_ram.patch"

diff -urN linux-2.6.3.orig/init/do_mounts.c linux-2.6.3/init/do_mounts.c
--- linux-2.6.3.orig/init/do_mounts.c	Tue Mar  9 16:17:14 2004
+++ linux-2.6.3/init/do_mounts.c	Tue Mar  9 16:18:42 2004
@@ -163,6 +163,9 @@
 	res = Root_NFS;
 	if (strcmp(name, "nfs") == 0)
 		goto done;
+	res = Root_RAM0;
+	if (strcmp(name, "ram") == 0)
+		goto done;
 
 	if (strlen(name) > 31)
 		goto fail;

--------------Boundary-00=_2CCBC5YH0VOGGGY77BWS--

