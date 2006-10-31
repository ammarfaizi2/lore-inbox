Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWJaIHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWJaIHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWJaIHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:07:31 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:58641 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422949AbWJaIHP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:07:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [Patch] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c
Date: Tue, 31 Oct 2006 16:03:42 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D5A3@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c
Thread-Index: Acb8vu2NQ2MILa8LRF6jliRYyUc2LwABAKYQ
From: "Peer Chen" <pchen@nvidia.com>
To: <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>
X-OriginalArrivalTime: 31 Oct 2006 08:04:09.0786 (UTC) FILETIME=[251911A0:01C6FCC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for HD audio controllers of MCP51,MCP55,MCP61,MCP65 &
MCP67.
The following hda_intel.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- hda_intel.c.orig	2006-10-30 14:13:08.000000000 +0800
+++ hda_intel.c	2006-10-31 13:44:36.000000000 +0800
@@ -1640,8 +1640,14 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
-	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 026c */
-	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 0371 */
+	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP51 */
+	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP55 */
+	{ 0x10de, 0x03e4, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x03f0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x044a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x044b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x055c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
+	{ 0x10de, 0x055d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
