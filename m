Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWJMPic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWJMPic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWJMPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:38:32 -0400
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:29815 "EHLO
	outbound3-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751213AbWJMPib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:38:31 -0400
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.18] hda_intel: add ATI RS690 HDMI audio support
Date: Fri, 13 Oct 2006 11:38:23 -0400
Message-ID: <3AF59FEEF017114286E7EF94EEC971B5599E67@TORCAEXMB3.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.18] hda_intel: add ATI RS690 HDMI audio support
Thread-Index: Acbu2FQGt1uh/A8VQuuW/VgavqK/BA==
From: "Luugi Marsan" <lmarsan@ati.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2006 15:38:21.0415 (UTC) FILETIME=[9CE62770:01C6EEDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the HDMI codec of the ATI RS690 IGP
northbridge.

Signed-off-by: Felix Kuehling <fkuehlin@ati.com>

diff -urN vanilla/sound/pci/hda/hda_intel.c
linux-2.6.18.x86_64/sound/pci/hda/hda_intel.c
--- vanilla/sound/pci/hda/hda_intel.c	2006-09-19 23:42:06.000000000
-0400
+++ linux-2.6.18.x86_64/sound/pci/hda/hda_intel.c	2006-09-26
04:24:02.000000000 -0400
@@ -83,6 +83,7 @@
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
 			 "{ATI, RS600},"
+			 "{ATI, RS690},"
 			 "{VIA, VT8251},"
 			 "{VIA, VT8237A},"
 			 "{SiS, SIS966},"
@@ -1637,6 +1638,7 @@
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
}, /* ATI SB450 */
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
}, /* ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */
+	{ 0x1002, 0x7919, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS690 HDMI */
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
diff -urN vanilla/sound/pci/hda/patch_atihdmi.c
linux-2.6.18.x86_64/sound/pci/hda/patch_atihdmi.c
--- vanilla/sound/pci/hda/patch_atihdmi.c	2006-09-19
23:42:06.000000000 -0400
+++ linux-2.6.18.x86_64/sound/pci/hda/patch_atihdmi.c	2006-09-26
04:23:27.000000000 -0400
@@ -161,5 +161,6 @@
  */
 struct hda_codec_preset snd_hda_preset_atihdmi[] = {
 	{ .id = 0x1002793c, .name = "ATI RS600 HDMI", .patch =
patch_atihdmi },
+	{ .id = 0x1002791a, .name = "ATI RS690 HDMI", .patch =
patch_atihdmi },
 	{} /* terminator */
 };

