Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVDEShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVDEShW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDESgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:36:50 -0400
Received: from fmr19.intel.com ([134.134.136.18]:35210 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261893AbVDESfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:35:07 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: perex@suse.cz, tiwai@suse.de
Subject: [PATCH 2.6.11.6 3/6] intel8x0: AC'97 audio patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:10:10 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050810.10903.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the intel8x0.c file for AC'97 audio support.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply.   Note:  This patch depends on the previous 1/6 patch for pci_ids.h

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/sound/pci/intel8x0.c.orig	2005-03-28 09:29:48.611042184 -0800
+++ linux-2.6.11.6/sound/pci/intel8x0.c	2005-03-28 09:32:49.771501608 -0800
@@ -55,6 +55,7 @@
 		"{Intel,ICH6},"
 		"{Intel,ICH7},"
 		"{Intel,6300ESB},"
+		"{Intel,ESB2},"
 		"{Intel,MX440},"
 		"{SiS,SI7012},"
 		"{NVidia,nForce Audio},"
@@ -124,6 +125,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH7_20
 #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ESB2_13
+#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2698
+#endif
 #ifndef PCI_DEVICE_ID_SI_7012
 #define PCI_DEVICE_ID_SI_7012		0x7012
 #endif
@@ -443,6 +447,7 @@
 	{ 0x8086, 0x25a6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ESB */
 	{ 0x8086, 0x266e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH6 */
 	{ 0x8086, 0x27de, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH7 */
+	{ 0x8086, 0x2698, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ESB2 */
 	{ 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 440MX */
 	{ 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_SIS },	/* SI7012 */
 	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE */
@@ -2715,6 +2720,7 @@
 	{ PCI_DEVICE_ID_INTEL_ESB_5, "Intel 6300ESB" },
 	{ PCI_DEVICE_ID_INTEL_ICH6_3, "Intel ICH6" },
 	{ PCI_DEVICE_ID_INTEL_ICH7_20, "Intel ICH7" },
+	{ PCI_DEVICE_ID_INTEL_ESB2_13, "Intel ESB2" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia nForce" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },
