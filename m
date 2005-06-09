Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVFIMLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVFIMLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVFIMLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:11:46 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:26082 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262364AbVFIML0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:11:26 -0400
Message-ID: <42A831E3.5080607@a-wing.co.uk>
Date: Thu, 09 Jun 2005 13:11:15 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: sis5513.c patch take 2
Content-Type: multipart/mixed;
 boundary="------------040509030302010108060403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509030302010108060403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Is this patch safer?  I am burn-in testing it now and it seems work fine 
with UDMA transfers.  I added the PCI ID of the northbridge as suggested.

Regards
Andrew
-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 348: We're on Token Ring, and it looks like the token got loose.

--------------040509030302010108060403
Content-Type: text/x-patch;
 name="sis5513-new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis5513-new.patch"

--- linux-2.6.12-rc6/drivers/ide/pci/sis5513.c	2005-06-06 16:22:29.000000000 +0100
+++ linux-2.6.12-rc6.new/drivers/ide/pci/sis5513.c	2005-06-09 17:41:07.000000000 +0100
@@ -87,6 +87,7 @@
 	u8 chipset_family;
 	u8 flags;
 } SiSHostChipInfo[] = {
+	{ "SiS760",	PCI_DEVICE_ID_SI_760,	ATA_133	 },
 	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100  },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100  },
 	{ "SiS733",	PCI_DEVICE_ID_SI_733,	ATA_100  },

--------------040509030302010108060403--
