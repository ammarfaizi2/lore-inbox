Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSFCJSv>; Mon, 3 Jun 2002 05:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSFCJSu>; Mon, 3 Jun 2002 05:18:50 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:21239 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317320AbSFCJSt>; Mon, 3 Jun 2002 05:18:49 -0400
Subject: agppart SiS 745 Patch - did it wrong before
From: Carsten Rietzschel <cr@daRav.de>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-eMWLFWZ8cJfs1vpZyy5j"
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 11:12:31 +0200
Message-Id: <1023095891.1520.22.camel@rav-pc-linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eMWLFWZ8cJfs1vpZyy5j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
only added support SiS 745-IDs to PCI-Device list.

So agp-try-unsupported kernel option will not be nessecary
for let this chipset work.

This patch is against 2.5.20 
(but the same changes will also work for 2.4-kernel series).


Carsten Rietzschel


Adempt 2: "diffed" it the wrong way before. Big Sorry !!!


--=-eMWLFWZ8cJfs1vpZyy5j
Content-Disposition: attachment; filename=agppart-sis735-patch-2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=agppart-sis735-patch-2; charset=ISO-8859-15

--- linux-2.5.20/drivers/char/agp/agpgart_be.c.org	Mon Jun  3 03:44:42 2002
+++ linux-2.5.20/drivers/char/agp/agpgart_be.c	Mon Jun  3 10:43:45 2002
@@ -4562,6 +4562,12 @@
 		"SiS",
 		"735",
 		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_745,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"745",
+		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_730,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,

--=-eMWLFWZ8cJfs1vpZyy5j--

