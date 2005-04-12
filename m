Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVDMBZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVDMBZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVDLT56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:57:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:41672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262156AbVDLKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:46 -0400
Message-Id: <200504121031.j3CAVces005364@shell0.pdx.osdl.net>
Subject: [patch 060/198] intel8x0: AC'97 audio patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       Jason.d.gaston@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the intel8x0.c file for AC'97 audio
support.

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/pci/intel8x0.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN sound/pci/intel8x0.c~intel8x0-ac97-audio-patch-for-intel-esb2 sound/pci/intel8x0.c
--- 25/sound/pci/intel8x0.c~intel8x0-ac97-audio-patch-for-intel-esb2	2005-04-12 03:21:17.697446480 -0700
+++ 25-akpm/sound/pci/intel8x0.c	2005-04-12 03:21:17.701445872 -0700
@@ -55,6 +55,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel,82801AA
 		"{Intel,ICH6},"
 		"{Intel,ICH7},"
 		"{Intel,6300ESB},"
+		"{Intel,ESB2},"
 		"{Intel,MX440},"
 		"{SiS,SI7012},"
 		"{NVidia,nForce Audio},"
@@ -124,6 +125,9 @@ MODULE_PARM_DESC(xbox, "Set to 1 for Xbo
 #ifndef PCI_DEVICE_ID_INTEL_ICH7_20
 #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ESB2_13
+#define PCI_DEVICE_ID_INTEL_ESB2_13	0x2698
+#endif
 #ifndef PCI_DEVICE_ID_SI_7012
 #define PCI_DEVICE_ID_SI_7012		0x7012
 #endif
@@ -443,6 +447,7 @@ static struct pci_device_id snd_intel8x0
 	{ 0x8086, 0x25a6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ESB */
 	{ 0x8086, 0x266e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH6 */
 	{ 0x8086, 0x27de, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH7 */
+	{ 0x8086, 0x2698, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ESB2 */
 	{ 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 440MX */
 	{ 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_SIS },	/* SI7012 */
 	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE */
@@ -2736,6 +2741,7 @@ static struct shortname_table {
 	{ PCI_DEVICE_ID_INTEL_ESB_5, "Intel 6300ESB" },
 	{ PCI_DEVICE_ID_INTEL_ICH6_18, "Intel ICH6" },
 	{ PCI_DEVICE_ID_INTEL_ICH7_20, "Intel ICH7" },
+	{ PCI_DEVICE_ID_INTEL_ESB2_13, "Intel ESB2" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia nForce" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },
_
