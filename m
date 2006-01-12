Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWALW7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWALW7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWALW7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:59:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:28082 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161398AbWALW7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:59:54 -0500
Date: Thu, 12 Jan 2006 16:59:44 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Matt_Wu@acersoftech.com.cn
Subject: [PATCH] ali5451: Add PCI_DEVICE and #defines in snd_ali_ids
Message-ID: <20060112225943.GL17539@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses #defines for the Vendor ID and Device ID and uses the
new PCI_DEVICE macro.

No hardware to test, but compiles and should work.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 4a7597b41d25 sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Wed Jan 11 19:14:08 2006
+++ b/sound/pci/ali5451/ali5451.c	Thu Jan 12 16:43:05 2006
@@ -279,7 +279,7 @@
 };
 
 static struct pci_device_id snd_ali_ids[] = {
-	{0x10b9, 0x5451, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5451), 0, 0, 0},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, snd_ali_ids);
