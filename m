Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUHaH2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUHaH2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 03:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUHaH2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 03:28:37 -0400
Received: from havoc.gtf.org ([216.162.42.101]:35786 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267304AbUHaH2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 03:28:32 -0400
Date: Tue, 31 Aug 2004 03:28:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.4.x misc updates
Message-ID: <20040831072831.GA23149@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.4

This will update the following files:

 drivers/sound/ac97_codec.c |    1 +
 drivers/sound/i810_audio.c |    8 ++++++++
 include/linux/pci_ids.h    |    4 ++++
 3 files changed, 13 insertions(+)

through these ChangeSets:

<achew@nvidia.com> (04/08/31 1.1550)
   [PATCH] i810_audio.c and pci_ids.h: add support for nforce MCP2S,

<ileong@nvidia.com> (04/08/28 1.1549)
   [ac97_codec] add new codec

diff -Nru a/drivers/sound/ac97_codec.c b/drivers/sound/ac97_codec.c
--- a/drivers/sound/ac97_codec.c	2004-08-31 03:27:52 -04:00
+++ b/drivers/sound/ac97_codec.c	2004-08-31 03:27:52 -04:00
@@ -155,6 +155,7 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x43585430, "CXT48",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x43585442, "CXT66",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x44543031, "Diamond Technology DT0893", &default_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
diff -Nru a/drivers/sound/i810_audio.c b/drivers/sound/i810_audio.c
--- a/drivers/sound/i810_audio.c	2004-08-31 03:27:52 -04:00
+++ b/drivers/sound/i810_audio.c	2004-08-31 03:27:52 -04:00
@@ -304,6 +304,14 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP2S_AUDIO,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_AUDIO,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP04_AUDIO,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
 	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7445,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768},
 	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_AUDIO,
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-08-31 03:27:52 -04:00
+++ b/include/linux/pci_ids.h	2004-08-31 03:27:52 -04:00
@@ -981,13 +981,16 @@
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_MCP04_AUDIO	0x003a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
+#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
+#define PCI_DEVICE_ID_NVIDIA_MCP2S_AUDIO	0x008a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
@@ -996,6 +999,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
+#define PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO		0x00ea
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
