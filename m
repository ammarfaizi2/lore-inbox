Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTEPNts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTEPNtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 09:49:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55970 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264437AbTEPNtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 09:49:45 -0400
Date: Fri, 16 May 2003 16:02:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lionel.Bouton@inet6.fr, alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fix support for SiS5581/5582/5596 IDE
Message-ID: <20030516160222.A19746@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

The last patch for SiS96* also added support for SiS5581, SiS5582 and
SiS5596. However, the PCI IDs for these three chips were incorrect by
mistake (cut and paste problem). This patch, on top of the previous one
fixes it, and thus adds proper support for these old chips.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis5581-2.4.diff"

ChangeSet@1.1213, 2003-05-16 15:52:40+02:00, vojtech@suse.cz
  sis5513.c: Fix newly added SiS55** PCI IDs.


 drivers/ide/pci/sis5513.c |    9 ++++-----
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c	Fri May 16 15:53:18 2003
+++ b/drivers/ide/pci/sis5513.c	Fri May 16 15:53:18 2003
@@ -105,12 +105,11 @@
 	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	ATA_33   },
 	{ "SiS5598",	PCI_DEVICE_ID_SI_5598,	ATA_33   },
 	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	ATA_33   },
-	{ "SiS5592",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
-	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
-	{ "SiS5581",	PCI_DEVICE_ID_SI_5571,	ATA_33   },
-	{ "SiS5582",	PCI_DEVICE_ID_SI_5571,	ATA_33   },
+	{ "SiS5591/2",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
+	{ "SiS5582",	PCI_DEVICE_ID_SI_5582,	ATA_33   },
+	{ "SiS5581",	PCI_DEVICE_ID_SI_5581,	ATA_33   },
 
-	{ "SiS5596",	PCI_DEVICE_ID_SI_5597,	ATA_16   },
+	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
 	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
 	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
 };
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 16 15:53:18 2003
+++ b/include/linux/pci_ids.h	Fri May 16 15:53:18 2003
@@ -521,7 +521,10 @@
 #define PCI_DEVICE_ID_SI_5513		0x5513
 #define PCI_DEVICE_ID_SI_5518		0x5518
 #define PCI_DEVICE_ID_SI_5571		0x5571
+#define PCI_DEVICE_ID_SI_5581		0x5581
+#define PCI_DEVICE_ID_SI_5582		0x5582
 #define PCI_DEVICE_ID_SI_5591		0x5591
+#define PCI_DEVICE_ID_SI_5596		0x5596
 #define PCI_DEVICE_ID_SI_5597		0x5597
 #define PCI_DEVICE_ID_SI_5598		0x5598
 #define PCI_DEVICE_ID_SI_5600		0x5600

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis5581-2.5.diff"

ChangeSet@1.1151, 2003-05-16 15:54:27+02:00, vojtech@suse.cz
  sis5513.c: Fix newly added SiS55** PCI IDs.


 drivers/ide/pci/sis5513.c |    9 ++++-----
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c	Fri May 16 15:57:07 2003
+++ b/drivers/ide/pci/sis5513.c	Fri May 16 15:57:07 2003
@@ -105,12 +105,11 @@
 	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	ATA_33   },
 	{ "SiS5598",	PCI_DEVICE_ID_SI_5598,	ATA_33   },
 	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	ATA_33   },
-	{ "SiS5592",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
-	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
-	{ "SiS5581",	PCI_DEVICE_ID_SI_5571,	ATA_33   },
-	{ "SiS5582",	PCI_DEVICE_ID_SI_5571,	ATA_33   },
+	{ "SiS5591/2",	PCI_DEVICE_ID_SI_5591,	ATA_33   },
+	{ "SiS5582",	PCI_DEVICE_ID_SI_5582,	ATA_33   },
+	{ "SiS5581",	PCI_DEVICE_ID_SI_5581,	ATA_33   },
 
-	{ "SiS5596",	PCI_DEVICE_ID_SI_5597,	ATA_16   },
+	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
 	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
 	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
 };
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 16 15:57:07 2003
+++ b/include/linux/pci_ids.h	Fri May 16 15:57:07 2003
@@ -577,7 +577,10 @@
 #define PCI_DEVICE_ID_SI_5513		0x5513
 #define PCI_DEVICE_ID_SI_5518		0x5518
 #define PCI_DEVICE_ID_SI_5571		0x5571
+#define PCI_DEVICE_ID_SI_5581		0x5581
+#define PCI_DEVICE_ID_SI_5582		0x5582
 #define PCI_DEVICE_ID_SI_5591		0x5591
+#define PCI_DEVICE_ID_SI_5596		0x5596
 #define PCI_DEVICE_ID_SI_5597		0x5597
 #define PCI_DEVICE_ID_SI_5598		0x5598
 #define PCI_DEVICE_ID_SI_5600		0x5600

--h31gzZEtNLTqOjlF--
