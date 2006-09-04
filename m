Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWIDN3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWIDN3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWIDN3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:29:24 -0400
Received: from server6.greatnet.de ([83.133.96.26]:21128 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751369AbWIDN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:29:23 -0400
Message-ID: <44FC2A5C.4070100@nachtwindheim.de>
Date: Mon, 04 Sep 2006 15:30:04 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] pci_module_init() convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtinwdheim.de>

pci_module_init() convertion in tmscsim.c
This one works on linus tree too.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/scsi/tmscsim.c	2006-08-01 01:31:43.000000000 +0200
+++ linux/drivers/scsi/tmscsim.c	2006-09-04 15:26:31.000000000 +0200
@@ -177,6 +177,8 @@
  *	2.1d  04/05/27	GL	Moved setting of scan_devices to	*
  *				slave_alloc/_configure/_destroy, as	*
  *				suggested by CH.			*
+ *	2.1e  06/09/04	HENKR	change pci_module_init() to		*
+ *				pci_register_driver()			*
  ***********************************************************************/
 
 /* DEBUG options */
@@ -245,7 +247,7 @@
 
 
 #define DC390_BANNER "Tekram DC390/AM53C974"
-#define DC390_VERSION "2.1d 2004-05-27"
+#define DC390_VERSION "2.1e 2006-09-04"
 
 #define PCI_DEVICE_ID_AMD53C974 	PCI_DEVICE_ID_AMD_SCSI
 
@@ -2670,7 +2672,7 @@
 		printk (KERN_INFO "DC390: Using safe settings.\n");
 	}
 
-	return pci_module_init(&dc390_driver);
+	return pci_register_driver(&dc390_driver);
 }
 
 static void __exit dc390_module_exit(void)


