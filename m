Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVDBANI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVDBANI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVDBALt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:11:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:42204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262954AbVDAXsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:20 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] PCI: Quirk for Asus M5N
In-Reply-To: <1112399273300@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:53 -0800
Message-Id: <11123992733687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.19, 2005/03/28 15:09:51-08:00, khali@linux-fr.org

[PATCH] PCI: Quirk for Asus M5N

One more Asus laptop which requires a PCI quirk to unhide the SMBus.
Contributed by Matthias Hensler through bugzilla (#4391).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/quirks.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-04-01 15:33:28 -08:00
+++ b/drivers/pci/quirks.c	2005-04-01 15:33:28 -08:00
@@ -787,6 +787,7 @@
 		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
 			switch (dev->subsystem_device) {
 			case 0x1751: /* M2N notebook */
+			case 0x1821: /* M5N notebook */
 				asus_hides_smbus = 1;
 			}
 		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)

