Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUJDT0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUJDT0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUJDTYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:24:31 -0400
Received: from fmr06.intel.com ([134.134.136.7]:54678 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268474AbUJDTQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:16:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Date: Mon, 4 Oct 2004 12:16:18 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E02C29ABE@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Thread-Index: AcSoB7y0FgfNoMZiTNunqxaSAETYnQCK4ulA
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>
X-OriginalArrivalTime: 04 Oct 2004 19:16:18.0905 (UTC) FILETIME=[A06B8490:01C4AA46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 01, 2004 3:41 PM, Bjorn Helgaas wrote:
> > I encountered a problem in running shpchp & pciehp drivers on
> > 2.6.9-rc2-mm4 kernel.  With ACPI & MSI enabled in the kernel, I 
> > got dev->irq properly for the hot-plug controllers.  With ACPI 
> > enabled and MSI not-enabled in this kernel, I got dev->irq 
> > equal 0 for the controllers. With the same options set in 
> > 2.6.8.1 & 2.6.9-rc2, things worked fine on the same system.

> Does it make any difference if you boot with "pci=routeirq"?
> I haven't looked at MSI recently, but it's possible that's
> sensitive to have all the IRQs programmed at boot-time.

Basically, the problem found was when I tried to use INTx mode 
for hot-plug controllers in ACPI enabled kernel.  I don't think 
this is related to MSI; the way I stated in the original email 
was not clear.  

I tried to boot with "pci=routeirq" and I got proper dev->irq for 
the hot-plug controllers. This tells me that my hot-plug drivers 
need to call pci_enable_device(), correct?
  
> If that does make a difference, please send me the output
> of lspci and a dmesg.

I will send them to you.

Thanks,
Dely

