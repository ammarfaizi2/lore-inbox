Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbULEUwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbULEUwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULEUwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:52:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23495 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261387AbULEUt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:49:59 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041203215927.GE1709@hygelac>
References: <20041203215927.GE1709@hygelac>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102275985.9335.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Dec 2004 19:46:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-03 at 21:59, Terence Ripperda wrote:
> I assume you mean traditional pci in this case, but I remain confused.
> the pci spec calls for 32-bits of addressing, although there is an
> optional extension for 64-bit bus extension pins. I can't speak for other
> pci devices, but all of our pci devices are 32-bit.

The current DRI drivers don't really deal much with PCI devices. A pure
PCI video card on 64bit boxes might be problematic although I'd question
the sanity of anyone doing this 8)

> 
> additionally, the pci-express spec defines legacy and non-legacy
> devices.  legacy devices are only required to address 32-bits, whereas
> non-legacy devices are required to handle 64-bit addresses.

I'd assumed video card vendors were non-legacy but ok

> I certainly understand the concerns with this, although I was led to
> believe that recent 2.6 work made the zone balancing much less
> expensive.  is that not the case?

Andrew certainly believes this is. Certainly in 2.4 it was not.

> > I can find users for a 512Mb or 1Gb DMA region
> 
> there was some brief discussion of this when we originally discussed
> 32-bit addressing issues, but I don't know if a satisfactory solution was
> reached.  If a 1Gb region was prefered for this reason, that should satisfy
> nvidia's needs for 32-bit addressing, but I couldn't speak for any other device
> drivers.

If the VM can take it and get it right I am all for a 512Mb or 1Gb DMA
region to fix the various devices that have 29-31bit DMA issues. If it
fixes Nvidia's needs to then fine.

Alan

