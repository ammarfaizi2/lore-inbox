Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135596AbREBPVK>; Wed, 2 May 2001 11:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135594AbREBPUu>; Wed, 2 May 2001 11:20:50 -0400
Received: from NO-SPAM.it.helsinki.fi ([128.214.205.34]:46075 "EHLO
	no-spam.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S135588AbREBPUo>; Wed, 2 May 2001 11:20:44 -0400
Date: Wed, 2 May 2001 18:17:55 +0300 (EEST)
Message-Id: <200105021517.f42FHtn29038@no-spam.it.helsinki.fi>
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: linux-kernel@vger.kernel.org
Subject: TV viewing broken in 2.4.4 (and 2.4.3)
X-Mailer: Cronos II 0.2.2 (gnome-libs 1.2.13; Linux 2.4.3; i586)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When my tv picture gets over a certain size, say when I enter fullscreen mode using xawtv or just resize my window over a certain point, most of the picture turns black and I get only a small strip of tv picture to the left of xawtv's window. TV was working well under 2.4.2.

I reported this bug before for 2.4.3 and a patch which fixed (or worked around) this problem was posted. The patch still works for 2.4.4

diff -urN linux/arch/i386/kernel/pci-pc.c
linux/arch/i386/kernel/pci-pc.c
--- linux/arch/i386/kernel/pci-pc.c Sat Mar 31 00:12:41 2001
+++ linux/arch/i386/kernel/pci-pc.c Thu Mar 29 05:00:04 2001
@@ -1035,7 +1035,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	pci_fixup_via_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixup_vt8363 },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C691,	pci_fixup_via691 },
- 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C598_1,	pci_fixup_via691_2 },
+// 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C598_1,	pci_fixup_via691_2 },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	pci_fixup_piix4_acpi },
 	{ 0 }
 };

Since the seems to be a VIA problem: I have a VIA MPV3 motherboard using an AMD K6-2 processor. My TV card is a Hauppage WinTV.

Robert.
