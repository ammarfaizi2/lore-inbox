Return-Path: <linux-kernel-owner+w=401wt.eu-S1751369AbXAFMLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXAFMLS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXAFMLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:11:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:43519 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXAFMLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:11:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tM7gsDNpChYrJvRD8xd2Uvc7uUnXm/JqQGhD4tpfLNDWKy3nrOWAjjXoBTFypdlimqWZ6XdYnYQLqsmYKGdpQXutc8yPSqoLEftWBCRZCAQc3j3D1SVj6kVCCHOQVBh/vaejwvr0shjItro0d+t/PBhDymJdPbS44GFSO5v+2FY=
Message-ID: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
Date: Sat, 6 Jan 2007 20:11:15 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
Subject: [PATCH 1/3] atiixp.c: remove unused code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch to atiixp.c was removed but some code has not been
cleaned. Now we remove these code sine they are no use any longer.

Signed-off-by: Conke Hu <conke.hu@amd.com>
-----------------
--- linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c.orig	2007-01-06
18:45:28.000000000 +0800
+++ linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c.1	2007-01-06
19:13:55.000000000 +0800
@@ -318,19 +318,6 @@ static void __devinit init_hwif_atiixp(i
 	hwif->drives[0].autodma = hwif->autodma;
 }

-static void __devinit init_hwif_sb600_legacy(ide_hwif_t *hwif)
-{
-
-	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-}

 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
@@ -340,13 +327,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "ATI SB600 SATA Legacy IDE",
-		.init_hwif	= init_hwif_sb600_legacy,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
+	},
 };

 /**
