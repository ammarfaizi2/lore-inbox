Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbRHKOh6>; Sat, 11 Aug 2001 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbRHKOhi>; Sat, 11 Aug 2001 10:37:38 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267860AbRHKOhS>; Sat, 11 Aug 2001 10:37:18 -0400
Date: Sat, 11 Aug 2001 16:33:23 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: VIA MVP3 problem is still there...
Message-ID: <20010811163323.A555@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
Long, long ago, in 2.4.3-pre - appeared fixup for VIA chipsets, however, fixups
for VIA MVP3 was unnecessary, and even slowed down system. It's already fixed
in -ac, but this broken fixup is still in 2.4.8 kernel. It affects most of
K6-2/K6-3 users. There are stable kernels in distributions, not -ac, so IMHO it will
be good to fix that problem at last - and it's only two lines of code:

--- linux-2.4.8/arch/i386/kernel/pci-pc.c       Sat Aug 11 16:19:30 2001
+++ linux/arch/i386/kernel/pci-pc.c     Sat Aug 11 16:20:04 2001
@@ -994,8 +994,6 @@
        { PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     pci_fixup_ide_bases },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5597,          pci_fixup_latency },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5598,          pci_fixup_latency },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_82C691,       pci_fixup_via691 },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_82C598_1,     pci_fixup_via691_2 },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371AB_3,  pci_fixup_piix4_acpi },
        { 0 }
 };

