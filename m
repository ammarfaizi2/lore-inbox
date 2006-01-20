Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWATTIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWATTIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWATTFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:30160 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751164AbWATTFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:00 -0500
Cc: jason.d.gaston@intel.com
Subject: [PATCH] PCI: irq and pci_ids: patch for Intel ICH8
In-Reply-To: <20060120190400.GA12894@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:37 -0800
Message-Id: <11377838772370@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: irq and pci_ids: patch for Intel ICH8

This patch adds the Intel ICH8 DID's to the irq.c and pci_ids.h files.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ac142f4e6f34d59ae0554dc96fe5bb030df02ab9
tree 7c4c0079727fa1e4c5bbfe08ca3fca3ec93445f3
parent e63ee95d25ba6663180153b7533f9c0fe77eb9dd
author Jason Gaston <jason.d.gaston@intel.com> Mon, 09 Jan 2006 10:53:45 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:33 -0800

 arch/i386/pci/irq.c     |    5 +++++
 include/linux/pci_ids.h |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index e715aa9..3ca59ca 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -539,6 +539,11 @@ static __init int intel_router_probe(str
 		case PCI_DEVICE_ID_INTEL_ICH7_30:
 		case PCI_DEVICE_ID_INTEL_ICH7_31:
 		case PCI_DEVICE_ID_INTEL_ESB2_0:
+		case PCI_DEVICE_ID_INTEL_ICH8_0:
+		case PCI_DEVICE_ID_INTEL_ICH8_1:
+		case PCI_DEVICE_ID_INTEL_ICH8_2:
+		case PCI_DEVICE_ID_INTEL_ICH8_3:
+		case PCI_DEVICE_ID_INTEL_ICH8_4:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ecc1fc1..117e023 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2104,6 +2104,13 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_19	0x27dd
 #define PCI_DEVICE_ID_INTEL_ICH7_20	0x27de
 #define PCI_DEVICE_ID_INTEL_ICH7_21	0x27df
+#define PCI_DEVICE_ID_INTEL_ICH8_0	0x2810
+#define PCI_DEVICE_ID_INTEL_ICH8_1	0x2811
+#define PCI_DEVICE_ID_INTEL_ICH8_2	0x2812
+#define PCI_DEVICE_ID_INTEL_ICH8_3	0x2814
+#define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
+#define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
+#define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577

