Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVAOCQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVAOCQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVAOCQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:16:23 -0500
Received: from fmr17.intel.com ([134.134.136.16]:55471 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262137AbVAOCQI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:16:08 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: perex@suse.cz, tiwai@suse.de
Subject: [PATCH] AC'97 Audio support for Intel ICH7 - 2.6.11-rc1
Date: Fri, 14 Jan 2005 11:21:34 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501141121.34876.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ICH7 AC'97 DID the the intel8x0.c AC'97 audio driver.  This patch was build against 2.6.11-rc1.
If acceptable, please apply.

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11-rc1/sound/pci/intel8x0.c.orig	2005-01-14 09:50:21.832749040 -0800
+++ linux-2.6.11-rc1/sound/pci/intel8x0.c	2005-01-14 09:55:44.626676904 -0800
@@ -53,6 +53,7 @@
 		"{Intel,82801DB-ICH4},"
 		"{Intel,ICH5},"
 		"{Intel,ICH6},"
+		"{Intel,ICH7},"
 		"{Intel,6300ESB},"
 		"{Intel,MX440},"
 		"{SiS,SI7012},"
@@ -120,6 +121,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH6_3
 #define PCI_DEVICE_ID_INTEL_ICH6_3	0x266e
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ICH7_20
+#define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
+#endif
 #ifndef PCI_DEVICE_ID_SI_7012
 #define PCI_DEVICE_ID_SI_7012		0x7012
 #endif
@@ -438,6 +442,7 @@
 	{ 0x8086, 0x24d5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH5 */
 	{ 0x8086, 0x25a6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ESB */
 	{ 0x8086, 0x266e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH6 */
+	{ 0x8086, 0x27de, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /* ICH7 */
 	{ 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 440MX */
 	{ 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_SIS },	/* SI7012 */
 	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE */
@@ -2685,6 +2690,7 @@
 	{ PCI_DEVICE_ID_INTEL_ICH5, "Intel ICH5" },
 	{ PCI_DEVICE_ID_INTEL_ESB_5, "Intel 6300ESB" },
 	{ PCI_DEVICE_ID_INTEL_ICH6_3, "Intel ICH6" },
+	{ PCI_DEVICE_ID_INTEL_ICH7_20, "Intel ICH7" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia nForce" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },

