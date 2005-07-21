Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVGUQho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVGUQho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGUQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 12:37:43 -0400
Received: from ipcny.ipc.com ([65.244.37.61]:37443 "EHLO
	stsnycon1.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S261813AbVGUQhl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 12:37:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH] PPC compilation error with CONFIG_PQ2FADS
Date: Thu, 21 Jul 2005 12:37:34 -0400
Message-ID: <1D6EDDB3E43F3B40BC089CCFEE99DB7D14D054@exnanycmbx1.corp.root.ipc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PPC compilation error with CONFIG_PQ2FADS
Thread-Index: AcWOEmaOfE2si1dmQRKxg1tpLnyx2w==
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jul 2005 16:37:35.0077 (UTC) FILETIME=[7F923150:01C58E12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.12.3 kernel compilation fails for
ARCH=ppc when CONFIG_PQ2FADS=y.  This patch
has been tested on Freescale PQ2FADS-ZU and
-VR boards.

--- linux-2.6.12.3/arch/ppc/syslib/m82xx_pci.c	2005-07-15 17:18:57.000000000 -0400
+++ linux-musrum/arch/ppc/syslib/m82xx_pci.c	2005-07-20 08:42:41.000000000 -0400
@@ -238,9 +238,9 @@
 	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
 	 * and local bus for PCI (SIUMCR [LBPC]).
 	 */
-	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.sc_siumcr &
-				~(SIUMCR_L2PC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
-				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10;
+	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.siu_82xx.sc_siumcr &
+				~(SIUMCR_L2CPC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
+				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10);
 #endif
 	/* Enable PCI  */
 	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);

Thomas Downing
IPC Information Systems, LLC
