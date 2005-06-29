Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVF2PDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVF2PDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVF2PDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:03:54 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:53509 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261260AbVF2PDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:03:50 -0400
Date: Wed, 29 Jun 2005 17:04:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Salah Coronya <salahx@yahoo.com>
Subject: [PATCH 2.6] PCI: Add PCI quirk for SMBus on the Asus P4B-LX
Message-Id: <20050629170406.1a48424d.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

One more Asus motherboard requiring the SMBus quirk (P4B-LX). Original
patch from Salah Coronya.

Please apply, thanks.

Signed-off-by: Salah Coronya <salahx@yahoo.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/pci/quirks.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.12-git5.orig/drivers/pci/quirks.c	2005-06-29 12:18:38.000000000 +0200
+++ linux-2.6.12-git5/drivers/pci/quirks.c	2005-06-29 16:51:14.000000000 +0200
@@ -767,6 +767,7 @@
 	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
 			switch(dev->subsystem_device) {
+			case 0x8025: /* P4B-LX */
 			case 0x8070: /* P4B */
 			case 0x8088: /* P4B533 */
 			case 0x1626: /* L3C notebook */


-- 
Jean Delvare
