Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265993AbRF1Pe0>; Thu, 28 Jun 2001 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbRF1PeQ>; Thu, 28 Jun 2001 11:34:16 -0400
Received: from ns.caldera.de ([212.34.180.1]:55736 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S265994AbRF1PeD>;
	Thu, 28 Jun 2001 11:34:03 -0400
Date: Thu, 28 Jun 2001 17:33:50 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: charles.white@compaq.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, arrays@compaq.com
Subject: PATCH: cciss small pci id table patch
Message-ID: <20010628173350.A12535@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The cciss driver in 2.4.5-ac19 is missing the terminating {0,}.

Ciao, Marcus

Index: drivers/block/cciss.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/block/cciss.c,v
retrieving revision 1.23
diff -u -r1.23 cciss.c
--- drivers/block/cciss.c	2001/05/27 18:05:54	1.23
+++ drivers/block/cciss.c	2001/06/28 15:27:34
@@ -63,6 +63,7 @@
                         0x0E11, 0x4080, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
                         0x0E11, 0x4082, 0, 0, 0},
+	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cciss_pci_device_id);
 
