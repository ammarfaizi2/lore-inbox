Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbVCDXID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbVCDXID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbVCDXEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:04:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:45986 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263194AbVCDUzA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:55:00 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] PCI: One more Asus SMBus quirk
In-Reply-To: <11099696383203@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:59 -0800
Message-Id: <11099696391236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org

[PATCH] PCI: One more Asus SMBus quirk

One more Asus laptop requiring the SMBus quirk (W1N model).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/quirks.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-03-04 12:41:06 -08:00
+++ b/drivers/pci/quirks.c	2005-03-04 12:41:06 -08:00
@@ -786,6 +786,7 @@
 			}
 		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch (dev->subsystem_device) {
+			case 0x184b: /* W1N notebook */
 			case 0x186a: /* M6Ne notebook */
 				asus_hides_smbus = 1;
 			}

