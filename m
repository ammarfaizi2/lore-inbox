Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRF1S44>; Thu, 28 Jun 2001 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRF1S4g>; Thu, 28 Jun 2001 14:56:36 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:19215 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262614AbRF1S40>; Thu, 28 Jun 2001 14:56:26 -0400
Message-ID: <A2C35BB97A9A384CA2816D24522A53BBE3B390@cceexc18.americas.cpqcorp.net>
From: "White, Charles" <Charles.White@COMPAQ.com>
To: "'Marcus Meissner'" <Marcus.Meissner@caldera.de>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arrays <Arrays@COMPAQ.com>
Subject: RE: PATCH: cciss small pci id table patch
Date: Thu, 28 Jun 2001 13:56:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree...  pci.txt says it should end in a zero..   

I will include that change in my future updates as well... 

		-----Original Message-----
		From:	Marcus Meissner [mailto:Marcus.Meissner@caldera.de]
		Sent:	Thursday, June 28, 2001 10:34 AM
		To:	White, Charles; linux-kernel@vger.kernel.org; Alan
Cox; Arrays
		Subject:	PATCH: cciss small pci id table patch

		Hi,

		The cciss driver in 2.4.5-ac19 is missing the terminating
{0,}.

		Ciao, Marcus

		Index: drivers/block/cciss.c
	
===================================================================
		RCS file:
/build/mm/work/repository/linux-mm/drivers/block/cciss.c,v
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
		 
