Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSBPOEt>; Sat, 16 Feb 2002 09:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292370AbSBPOEk>; Sat, 16 Feb 2002 09:04:40 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:47109 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S292368AbSBPOEc>;
	Sat, 16 Feb 2002 09:04:32 -0500
Date: Sat, 16 Feb 2002 15:04:22 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.18-rc1 - remove duplicates in include/linux/pci_ids.h
Message-ID: <20020216150422.A9903@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I checked the pci_ids.h file for duplicates and found out that there are some duplicates in it.
The below patch removes these duplicates.
(duplicates haev been found by: 
  cat pci_ids.h | grep -v '^$'| sort > /tmp/pci_ids.h.sorted 
  cat pci_ids.h | grep -v '^$'| sort -u > /tmp/pci_ids.h.sorted-u
  diff -u /tmp/pci_ids.h.sorted /tmp/pci_ids.h.sorted-u )

Greetings,
Wim.

--- linux-2.4.18-rc1/include/linux/pci_ids.h	Sat Feb 16 14:49:58 2002
+++ linux-2.4.18-rc1-patched/include/linux/pci_ids.h	Sat Feb 16 14:54:30 2002
@@ -535,10 +535,6 @@
 #define PCI_DEVICE_ID_ELSA_MICROLINK	0x1000
 #define PCI_DEVICE_ID_ELSA_QS3000	0x3000
 
-#define PCI_VENDOR_ID_ELSA		0x1048
-#define PCI_DEVICE_ID_ELSA_MICROLINK	0x1000
-#define PCI_DEVICE_ID_ELSA_QS3000	0x3000
-
 #define PCI_VENDOR_ID_SGS		0x104a
 #define PCI_DEVICE_ID_SGS_2000		0x0008
 #define PCI_DEVICE_ID_SGS_1764		0x0009
@@ -1287,11 +1283,6 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
-
-#define PCI_VENDOR_ID_ITE		0x1283
-#define PCI_DEVICE_ID_ITE_IT8172G	0x8172
-
-#define PCI_VENDOR_ID_ITE			0x1283
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 
 
@@ -1631,16 +1622,6 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
 #define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
 #define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
-#define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
-#define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
-#define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
-#define PCI_DEVICE_ID_INTEL_82801CA_4	0x2484
-#define PCI_DEVICE_ID_INTEL_82801CA_5	0x2485
-#define PCI_DEVICE_ID_INTEL_82801CA_6	0x2486
-#define PCI_DEVICE_ID_INTEL_82801CA_7	0x2487
-#define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
-#define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
-#define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
 #define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
 #define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
