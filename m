Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULDUqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULDUqR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULDUqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 15:46:17 -0500
Received: from 4.Red-80-32-108.pooles.rima-tde.net ([80.32.108.4]:17536 "EHLO
	gimli") by vger.kernel.org with ESMTP id S261155AbULDUqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 15:46:13 -0500
Message-ID: <41B222BE.9020205@sombragris.com>
Date: Sat, 04 Dec 2004 21:49:02 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx large integer
Content-Type: multipart/mixed;
 boundary="------------080701020401050709040706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701020401050709040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I noticed a large integer warning when compiling 2.6.10rc3 with the SCSI 
AIC-7xxx driver.

Here is the patch.

Cheers,
MaF

--------------080701020401050709040706
Content-Type: text/plain;
 name="patch-aic7xxx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-aic7xxx"

diff -r -u linux-2.6.10-rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.6.10-rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6.10-rc3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-04 20:48:11.000000000 +0100
+++ linux-2.6.10-rc3-maf/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-04 20:37:54.000000000 +0100
@@ -226,7 +226,7 @@
 	}
 	pci_set_master(pdev);
 
-	mask_39bit = 0x7FFFFFFFFFULL;
+	mask_39bit = 0x7FFFFFFF;
 	if (sizeof(dma_addr_t) > 4
 	 && ahc_linux_get_memsize() > 0x80000000
 	 && pci_set_dma_mask(pdev, mask_39bit) == 0) {

--------------080701020401050709040706--
