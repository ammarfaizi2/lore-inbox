Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVJ2Kbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVJ2Kbw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVJ2Kbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:31:52 -0400
Received: from math.ut.ee ([193.40.36.2]:4256 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750916AbVJ2Kbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:31:51 -0400
Date: Sat, 29 Oct 2005 13:31:49 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix VIA 686 PCI quirk names
Message-ID: <Pine.SOC.4.61.0510291327500.23616@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The quirk names for VIA 686 are mistyped in 2.6.14 (686 vs 868). S3 868 
influence? :) Here is a patch to correct them.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -447,11 +447,11 @@ static void __devinit quirk_vt82c686_acp

  	pci_read_config_word(dev, 0x70, &hm);
  	hm &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, hm, 128, PCI_BRIDGE_RESOURCES + 1, "vt82c868 HW-mon");
+	quirk_io_region(dev, hm, 128, PCI_BRIDGE_RESOURCES + 1, "vt82c686 HW-mon");

  	pci_read_config_dword(dev, 0x90, &smb);
  	smb &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2, "vt82c868 SMB");
+	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2, "vt82c686 SMB");
  }
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi );


-- 
Meelis Roos (mroos@linux.ee)
