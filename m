Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263207AbVGAVOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbVGAVOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVGAUzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:55:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:50657 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262617AbVGAUti convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:38 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] PCI: Add PCI quirk for SMBus on the Asus P4B-LX
In-Reply-To: <11202509124001@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509121851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Add PCI quirk for SMBus on the Asus P4B-LX

One more Asus motherboard requiring the SMBus quirk (P4B-LX). Original
patch from Salah Coronya.

Signed-off-by: Salah Coronya <salahx@yahoo.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a00db371624e2e3718e5ab7d73bf364681098106
tree e1911719bc7bb14eb806b93950ac8c73e5f77e19
parent 75865858971add95809c5c9cd35dc4cfba08e33b
author Jean Delvare <khali@linux-fr.org> Wed, 29 Jun 2005 17:04:06 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:51 -0700

 drivers/pci/quirks.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -767,6 +767,7 @@ static void __init asus_hides_smbus_host
 	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
 			switch(dev->subsystem_device) {
+			case 0x8025: /* P4B-LX */
 			case 0x8070: /* P4B */
 			case 0x8088: /* P4B533 */
 			case 0x1626: /* L3C notebook */

