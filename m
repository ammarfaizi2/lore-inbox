Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVFGWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVFGWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVFGWi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:38:29 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:56983 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S261997AbVFGWh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:37:57 -0400
Message-ID: <42A621BC.7040607@a-wing.co.uk>
Date: Tue, 07 Jun 2005 23:37:48 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sis5513.c patch
Content-Type: multipart/mixed;
 boundary="------------080308080006050202010106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308080006050202010106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm not sure if a similar patch has been submitted or not, but here is a 
patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L 
chipset combo.

I'm looking at trying to revive the old sis190.c net driver for this 
board too, this does depend on my boss giving me some development time.

Anyway, this is my first kernel patch so I hope it helps.

Regards
Andrew
-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 183: filesystem not big enough for Jumbo Kernel Patch

--------------080308080006050202010106
Content-Type: text/x-patch;
 name="SiS5513.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SiS5513.patch"

diff -u -r linux-2.6.11.11.orig/drivers/ide/pci/sis5513.c linux-2.6.11.11/drivers/ide/pci/sis5513.c
--- linux-2.6.11.11.orig/drivers/ide/pci/sis5513.c	2005-05-27 06:06:46.000000000 +0100
+++ linux-2.6.11.11/drivers/ide/pci/sis5513.c	2005-06-07 22:14:25.000000000 +0100
@@ -112,6 +112,7 @@
 	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
 	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
 	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
+	{ "SiS5513",	PCI_DEVICE_ID_SI_5513,	ATA_133	 },
 };
 
 /* Cycle time bits and values vary across chip dma capabilities

--------------080308080006050202010106--
