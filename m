Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBXNYN>; Sun, 24 Feb 2002 08:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSBXNYE>; Sun, 24 Feb 2002 08:24:04 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:22794 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S287578AbSBXNXp>;
	Sun, 24 Feb 2002 08:23:45 -0500
Date: Sun, 24 Feb 2002 14:23:38 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18-rc4 PCI Subsystem : pci-irq's for the i8xx chipsets
Message-ID: <20020224142338.A22265@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

included a small patch for the detection of the irq-router for all i8xx chipsets.

Greetings,
Wim.

diff -u --recursive --new-file linux-2.4.18-rc4/arch/i386/kernel/pci-irq.c linux-2.4.18-rc4-patched/arch/i386/kernel/pci-irq.c
--- linux-2.4.18-rc4/arch/i386/kernel/pci-irq.c	Sun Feb 24 13:06:07 2002
+++ linux-2.4.18-rc4-patched/arch/i386/kernel/pci-irq.c	Sun Feb 24 13:14:41 2002
@@ -443,7 +443,12 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
