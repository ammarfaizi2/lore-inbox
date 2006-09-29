Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWI2Q75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWI2Q75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWI2Q75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:59:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42201 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161329AbWI2Q7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:59:55 -0400
Subject: [PATCH] libata: pata_ali support for the newer chipsets
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:23:40 +0100
Message-Id: <1159550621.13029.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bring it into line with drivers/ide

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/pata_ali.c linux-2.6.18-mm2/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.18-mm2/drivers/ata/pata_ali.c	2006-09-28 14:33:46.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/pata_ali.c	2006-09-29 11:43:12.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.5"
+#define DRV_VERSION "0.6.6"
 
 /*
  *	Cable special cases
@@ -630,7 +630,7 @@
 		pci_read_config_byte(pdev, 0x53, &tmp);
 		if (rev <= 0x20)
 			tmp &= ~0x02;
-		if (rev == 0xc7)
+		if (rev >= 0xc7)
 			tmp |= 0x03;
 		else
 			tmp |= 0x01;	/* CD_ROM enable for DMA */

