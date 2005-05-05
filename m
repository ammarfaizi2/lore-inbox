Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVEETtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVEETtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVEETst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:48:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47597 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262211AbVEET2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:28:48 -0400
Date: Thu, 5 May 2005 14:28:21 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: support for TPMs on additional LPC bus
Message-ID: <Pine.LNX.4.62.0505051417550.15240@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch it adds support for TPMs on additional LPC 
buses.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2-mm2-collect/drivers/char/tpm/tpm_atmel.c	2005-05-03 13:05:43.000000000 -0700
+++ linux-2.6.12-rc3/drivers/char/tpm/tpm_atmel.c	2005-04-20 17:03:13.000000000 -0700
@@ -205,7 +183,8 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6LPC)},
 	{0,}
 };
 
