Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267771AbUHEQ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbUHEQ1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUHEQ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:27:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10659 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267771AbUHEQ1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:27:17 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Thu, 5 Aug 2004 09:25:16 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040805050556.9899.qmail@web14924.mail.yahoo.com> <200408050854.32619.jbarnes@engr.sgi.com>
In-Reply-To: <200408050854.32619.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050925.16695.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 5, 2004 8:54 am, Jesse Barnes wrote:
> On Wednesday, August 4, 2004 10:05 pm, Jon Smirl wrote:
> > Version 10
>
> For some reason this version doesn't work on ia64.  It just returns bytes
> containing 0 when I try to dump the ROM.

pci_assign_resource is mucking with the values in 
pci_dev->resource[PCI_ROM_RESOURCE].  If I remove the call to 
pci_assign_resource, things work for me.  Is that call really necessary?  
Don't we just need ioremap?

Thanks,
Jesse
