Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRFETJp>; Tue, 5 Jun 2001 15:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbRFETJf>; Tue, 5 Jun 2001 15:09:35 -0400
Received: from barn.holstein.com ([198.134.143.193]:9998 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S264080AbRFETJ1>;
	Tue, 5 Jun 2001 15:09:27 -0400
Date: Tue, 5 Jun 2001 19:08:37 GMT
Message-Id: <200106051908.f55J8bS32044@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: patch for ide.2.4.5-ac8
Reply-To: troy@holstein.com
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 06/05/2001 03:08:47 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 06/05/2001 03:08:48 PM,
	Serialize complete at 06/05/2001 03:08:48 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,
  Minor typo fix:
--- ide-dma.c.~1~	Tue Jun  5 14:39:06 2001
+++ ide-dma.c	Tue Jun  5 15:04:54 2001
@@ -708,15 +708,15 @@
 	if ((!dma_base) && (!second_chance)) {
 		unsigned long set_bmiba = 0;
 		second_chance++;
-		switch(dev->vender) {
-			PCI_VENDOR_ID_AL:
-				set_bmiba = DEFAULT_BMALIBA; break;
-			PCI_VENDOR_ID_VIA:
-				set_bmiba = DEFAULT_BMCRBA; break;
-			PCI_VENDOR_ID_INTEL:
-				set_bmiba = DEFAULT_BMIBA; break;
-			default:
-				return dma_base;
+		switch (dev->vendor) {
+		         case PCI_VENDOR_ID_AL:
+				        set_bmiba = DEFAULT_BMALIBA; break;
+		         case PCI_VENDOR_ID_VIA:
+		                set_bmiba = DEFAULT_BMCRBA; break;
+		         case PCI_VENDOR_ID_INTEL:
+		                set_bmiba = DEFAULT_BMIBA; break;
+		         default:
+		                return dma_base;
 		}
 		pci_write_config_dword(dev, 0x20, set_bmiba|1);
 		goto second_chance_to_dma;

Cheers,
  Todd
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
