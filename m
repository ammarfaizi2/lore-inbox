Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDEPf4 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 10:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbTDEPf4 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 10:35:56 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:65457 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262482AbTDEPfz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 10:35:55 -0500
Date: Sat, 5 Apr 2003 17:47:26 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Linux 2.4.21-pre7 HPT372N is missing its PCI ID
Message-ID: <Pine.LNX.4.51.0304051732060.3047@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while compiling 2.4.21-pre7 i noticed that there are problems with
compiling support for HPT372N.
I think that we need a PCI_ID for it in include/linux/pci_ids.h, like

diff -Nru linux-2.4.20.orig/include/linux/pci_ids.h linux-2.4.20/include/linux/pci_ids.h
--- linux-2.4.20.orig/include/linux/pci_ids.h	2003-04-05 17:01:45.000000000 +0200
+++ linux-2.4.20/include/linux/pci_ids.h	2003-04-05 17:38:25.000000000 +0200
@@ -983,6 +983,7 @@
 #define PCI_DEVICE_ID_TTI_HPT302	0x0006
 #define PCI_DEVICE_ID_TTI_HPT371	0x0007
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009

 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305



I do not now the real PCI ID of HPT372N, so it would have to be checked.
With the patch above it compiles but i can not say if it is the correct
id.

Regards,
Maciej Soltysiak
This is the error log:
hpt366.h:517: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a function)
hpt366.h:517: initializer element is not constant
hpt366.h:517: (near initialization for `hpt366_chipsets[5].device')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits[0]')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits[1]')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits')
hpt366.h:529: initializer element is not constant
hpt366.h:529: (near initialization for `hpt366_chipsets[5]')
hpt366.h:534: initializer element is not constant
hpt366.h:534: (near initialization for `hpt366_chipsets[6]')
hpt366.c: In function `hpt_revision':
hpt366.c:183: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this function)
hpt366.c:183: (Each undeclared identifier is reported only once
hpt366.c:183: for each function it appears in.)
hpt366.c: In function `init_setup_hpt366':
hpt366.c:1227: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this function)
hpt366.c: At top level:
hpt366.c:1289: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a function)
hpt366.c:1289: initializer element is not constant
hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5].device')
hpt366.c:1289: initializer element is not constant
hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5]')
hpt366.c:1290: initializer element is not constant
hpt366.c:1290: (near initialization for `hpt366_pci_tbl[6]')
