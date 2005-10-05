Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVJEU7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVJEU7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVJEU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:59:10 -0400
Received: from farad.aurel32.net ([82.232.2.251]:17322 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1751163AbVJEU7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:59:09 -0400
Date: Wed, 5 Oct 2005 22:59:06 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Lionel.Bouton@inet6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
Message-ID: <20051005205906.GA4320@farad.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Lionel.Bouton@inet6.fr, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.9i (2005-03-13)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch that enables the ATA133 mode for the SiS965 southbridge 
in the SiS5513 driver.

Thanks,
Aurelien


Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- linux-2.6.14-rc3-git4.orig/drivers/ide/pci/sis5513.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc3-git4/drivers/ide/pci/sis5513.c	2005-10-05 22:12:30.000000000 +0200
@@ -87,6 +87,7 @@
 	u8 chipset_family;
 	u8 flags;
 } SiSHostChipInfo[] = {
+	{ "SiS965",	PCI_DEVICE_ID_SI_965,	ATA_133  },
 	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100  },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100  },
 	{ "SiS733",	PCI_DEVICE_ID_SI_733,	ATA_100  },
--- linux-2.6.14-rc3-git4.orig/include/linux/pci_ids.h	2005-10-05 22:08:49.000000000 +0200
+++ linux-2.6.14-rc3-git4/include/linux/pci_ids.h	2005-10-05 22:13:35.000000000 +0200
@@ -672,6 +672,7 @@
 #define PCI_DEVICE_ID_SI_961		0x0961
 #define PCI_DEVICE_ID_SI_962		0x0962
 #define PCI_DEVICE_ID_SI_963		0x0963
+#define PCI_DEVICE_ID_SI_965		0x0965
 #define PCI_DEVICE_ID_SI_5107		0x5107
 #define PCI_DEVICE_ID_SI_5300		0x5300
 #define PCI_DEVICE_ID_SI_5511		0x5511

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
