Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267531AbUHWTxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267531AbUHWTxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUHWTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:52:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:43203 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266786AbUHWSgP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:15 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286089857@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <1093286089538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.42, 2004/08/09 16:39:49-07:00, sziwan@hell.org.pl

[PATCH] PCI: ASUS L3C SMBus fixup

Following the notes on bug #2976, here's the patch to add ASUS L3C notebook
to the list of machines hiding SMBus chip. The patch is against
2.6.8-rc3-mm1.


From: Karol Kozimor <sziwan@hell.org.pl>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-08-23 11:02:39 -07:00
+++ b/drivers/pci/quirks.c	2004-08-23 11:02:39 -07:00
@@ -744,6 +744,7 @@
 			switch(dev->subsystem_device) {
 			case 0x8070: /* P4B */
 			case 0x8088: /* P4B533 */
+			case 0x1626: /* L3C notebook */
 				asus_hides_smbus = 1;
 			}
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
@@ -809,6 +810,7 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
 

