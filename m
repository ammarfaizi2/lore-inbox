Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUJGTbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUJGTbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJGT27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:28:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26051 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267968AbUJGT1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:27:55 -0400
Date: Thu, 07 Oct 2004 12:28:35 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: David Vrabel <dvrabel@arcom.com>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [PATCH 2.6][2/54] arch/i386/pci/acpi.c Use for_each_pci_dev macro
Message-ID: <22840000.1097177314@w-hlinder.beaverton.ibm.com>
In-Reply-To: <41650CB9.80608@arcom.com>
References: <3740000.1097094228@w-hlinder.beaverton.ibm.com> <41650CB9.80608@arcom.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, October 07, 2004 10:30:33 AM +0100 David Vrabel <dvrabel@arcom.com> wrote:

> Hanna Linder wrote:
>> 
>> +		for_each_pci_dev(dev);
> 
> That semicolon doesn't look right.

Woops. You are right. Here is the reroll

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/i386/pci/acpi.c linux-2.6.9-rc3-mm2patch/arch/i386/pci/acpi.c
--- linux-2.6.9-rc3-mm2cln/arch/i386/pci/acpi.c	2004-10-04 11:38:04.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/i386/pci/acpi.c	2004-10-07 12:21:49.825530848 -0700
@@ -41,7 +41,7 @@ static int __init pci_acpi_init(void)
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");



