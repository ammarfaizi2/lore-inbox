Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277321AbRJJRFO>; Wed, 10 Oct 2001 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277323AbRJJRFF>; Wed, 10 Oct 2001 13:05:05 -0400
Received: from mail.aubi.de ([62.159.82.131]:16279 "EHLO imhotep.aubi.de")
	by vger.kernel.org with ESMTP id <S277321AbRJJREz>;
	Wed, 10 Oct 2001 13:04:55 -0400
Message-ID: <7B1EED0C5D58D411B73200508BDE77B2C53CAB@EXCHANGEB>
From: =?iso-8859-1?Q?Markus_D=F6hr?= <doehrm@aubi.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] for 2.4.11 to get the Compaq array driver compiled
Date: Wed, 10 Oct 2001 19:05:18 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -udr linux/include/scsi/scsi.h
linux-2.4.10-ac10enterprise64/include/scsi/scsi.h
--- linux/include/scsi/scsi.h   Fri Apr 27 22:59:19 2001
+++ linux-2.4.10-ac10enterprise64/include/scsi/scsi.h   Tue Oct  9 00:02:19
2001
@@ -214,6 +214,12 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387

+/* Used to get Fibre Channel WWN and port_id from device */
+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5387
+
+/* Used to invoke Target Defice Reset for Fibre Channel */
+#define SCSI_IOCTL_FC_TDR 0x5388
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

I don't know if this patch is correct but it seems to work fine :-) 
This is not fixed in 2.4.10 neither in 2.4.11.


Greetings,

-- 
Markus Doehr            AUBI Baubschlaege GmbH
IT Admin/SAP R/3 Basis  Zum Grafenwald
fon: +49 6503 917 152   54411 Hermeskeil
fax: +49 6503 917 190   http://www.aubi.de 
