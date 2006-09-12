Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWILPxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWILPxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWILPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:53:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19684 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751446AbWILPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:52:59 -0400
Subject: [PATCH]: Update SiS PATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, "." <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 17:15:12 +0100
Message-Id: <1158077712.6780.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New chipset identifiers

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_sis.c linux-2.6.18-rc6-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_sis.c	2006-09-11 17:00:08.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ata/pata_sis.c	2006-09-11 20:10:29.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.4.2"
+#define DRV_VERSION	"0.4.3"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -857,6 +857,10 @@
 	struct sis_chipset *chipset = NULL;
 
 	static struct sis_chipset sis_chipsets[] = {
+	
+		{ 0x0968, &sis_info133 },
+		{ 0x0966, &sis_info133 },
+		{ 0x0965, &sis_info133 },
 		{ 0x0745, &sis_info100 },
 		{ 0x0735, &sis_info100 },
 		{ 0x0733, &sis_info100 },

