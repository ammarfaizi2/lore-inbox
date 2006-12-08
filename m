Return-Path: <linux-kernel-owner+w=401wt.eu-S938064AbWLHPDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938064AbWLHPDV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938063AbWLHPDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:03:21 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1126 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938064AbWLHPDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:03:20 -0500
Date: Fri, 8 Dec 2006 16:03:19 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org, marcel@holtmann.org, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: [PATCH] [Bluetooth] Add support for another Kensington dongle
Message-ID: <20061208150319.GA35838@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org, marcel@holtmann.org,
	maxk@qualcomm.com, bluez-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the stupid sco fixup quirk to yet another Broadcom/Kensington
device.
---
 drivers/bluetooth/hci_usb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index fdea58a..aeefec9 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -126,6 +126,7 @@ static struct usb_device_id blacklist_ids[] = {
 
 	/* Kensington Bluetooth USB adapter */
 	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_WRONG_SCO_MTU },
 
 	/* ISSC Bluetooth Adapter v3.1 */
 	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
-- 
1.4.4.1.g278f

