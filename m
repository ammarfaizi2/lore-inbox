Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVF1GKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVF1GKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVF1GJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:09:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:25324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261855AbVF1Fdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:40 -0400
Cc: gud@eth.net
Subject: [PATCH] pci: remove deprecates
In-Reply-To: <11199367714038@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:51 -0700
Message-Id: <11199367711516@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci: remove deprecates

Replace pci_find_device() with more safer pci_get_device().

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit efe1ec27837d6639eae82e1f5876910ba6433c3f
tree 16070e93c8ea98f2da9ab8546024cc6d0e11388f
parent 881a8c120acf7ec09c90289e2996b7c70f51e996
author Amit Gud <gud@eth.net> Tue, 12 Apr 2005 19:04:27 +0530
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:38 -0700

 drivers/char/rio/rio_linux.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -1095,7 +1095,7 @@ static int __init rio_init(void) 
 
 #ifdef CONFIG_PCI
     /* First look for the JET devices: */
-    while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
+    while ((pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
                                     PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
                                     pdev))) {
        if (pci_enable_device(pdev)) continue;
@@ -1169,7 +1169,7 @@ static int __init rio_init(void) 
   */
 
     /* Then look for the older RIO/PCI devices: */
-    while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
+    while ((pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
                                     PCI_DEVICE_ID_SPECIALIX_RIO, 
                                     pdev))) {
        if (pci_enable_device(pdev)) continue;

