Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTEKK65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEKK65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:58:57 -0400
Received: from pb148.mielec.sdi.tpnet.pl ([80.49.1.148]:3077 "EHLO
	enigma.put.mielec.pl") by vger.kernel.org with ESMTP
	id S261280AbTEKK6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:58:55 -0400
From: Grzesiek Wilk <toulouse@put.mielec.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SiS648 support for agpgart, kernel 2.4.21-rc2-ac1
Date: Sun, 11 May 2003 13:11:31 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305111311.31915.toulouse@put.mielec.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just adds sis648 chipset support as a generic sis chipset into
agpgart. You need it if you want to get a 3d acceleration to work.

So far it works fine on my Radeon 9000
(glxgears 1200fps instead of 300, glTron works excellent).

One thing i'm not sure is in which agp mode it is working. SiS648 as well as
R9k supports agp 3.0 but I don't think that generic sis driver does.
(correct me if i'm wrong).


diff -u orig_linux.21rc2-ac1/drivers/char/agp/agpgart_be.c linux.21rc2-ac1/drivers/char/agp/agpgart_be.c
--- orig_linux.21rc2-ac1/drivers/char/agp/agpgart_be.c	2003-05-11 12:23:51.000000000 +0200
+++ linux.21rc2-ac1/drivers/char/agp/agpgart_be.c	2003-05-11 12:39:03.000000000 +0200
@@ -4655,6 +4655,12 @@
 		"SiS",
 		"646",
 		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_648,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"648",
+		sis_generic_setup },		
 	{ PCI_DEVICE_ID_SI_735,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,


