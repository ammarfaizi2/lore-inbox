Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753385AbWKFUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbWKFUQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbWKFUQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:16:12 -0500
Received: from palrel13.hp.com ([156.153.255.238]:26024 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1753367AbWKFUQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:16:11 -0500
Date: Mon, 6 Nov 2006 14:16:11 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 4/12] repost: cciss: fix pci ssid for the E500 controller
Message-ID: <20061106201611.GD17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 4/11

The patch changes the SSID on the E500 as a workaround for a firmware bug. It
looks like the original patch was backed out between rc2 and rc4.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

------------------------------------------------------------------------------------------
---

 drivers/block/cciss.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/cciss.c~cciss_e500_fix_for_lx2619-rc2 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_e500_fix_for_lx2619-rc2	2006-11-06 13:15:56.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:15:56.000000000 -0600
@@ -82,7 +82,7 @@ static const struct pci_device_id cciss_
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3213},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3214},
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSD,     0x103C, 0x3215},
-	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3233},
+	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSC,     0x103C, 0x3237},
 	{PCI_VENDOR_ID_HP,     PCI_ANY_ID,	PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_RAID << 8, 0xffff << 8, 0},
 	{0,}
@@ -114,7 +114,7 @@ static struct board_type products[] = {
 	{0x3213103C, "Smart Array E200i", &SA5_access, 120},
 	{0x3214103C, "Smart Array E200i", &SA5_access, 120},
 	{0x3215103C, "Smart Array E200i", &SA5_access, 120},
-	{0x3233103C, "Smart Array E500", &SA5_access, 512},
+	{0x3237103C, "Smart Array E500", &SA5_access, 512},
 	{0xFFFF103C, "Unknown Smart Array", &SA5_access, 120},
 };
 
_
