Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJAWni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJAWni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJAWn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:43:29 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:15323 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266663AbUJAWlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:41:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Sy@eeyore.fc.hp.com, Dely L <dely.l.sy@intel.com>
Subject: Re: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Date: Fri, 1 Oct 2004 16:40:47 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410011640.47357.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I encountered a problem in running shpchp & pciehp drivers on
> 2.6.9-rc2-mm4 kernel.  With ACPI & MSI enabled in the kernel, I 
> got dev->irq properly for the hot-plug controllers.  With ACPI 
> enabled and MSI not-enabled in this kernel, I got dev->irq 
> equal 0 for the controllers. With the same options set in 
> 2.6.8.1 & 2.6.9-rc2, things worked fine on the same system.

Does it make any difference if you boot with "pci=routeirq"?
I haven't looked at MSI recently, but it's possible that's
sensitive to have all the IRQs programmed at boot-time.

If that does make a difference, please send me the output
of lspci and a dmesg.
