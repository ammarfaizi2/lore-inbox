Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUHSXZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUHSXZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHSXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:25:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:27270 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267510AbUHSXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:25:29 -0400
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191603.55327.bjorn.helgaas@hp.com>
References: <20040819092654.27bb9adf.akpm@osdl.org>
	 <1092938035.28370.13.camel@localhost.localdomain>
	 <20040819215124.GA6114@hygelac>  <200408191603.55327.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092954168.28931.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 23:22:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 23:03, Bjorn Helgaas wrote:
> The driver is looking at dev->irq before calling pci_enable_device().
> But dev->irq is not necessarily initialized before pci_enable_device().
> 
> I'm not a PCI expert, but I'm not sure you should be looking at
> all the other dev->resource[] stuff before pci_enable_device()
> either. 

Indeed. pci_enable_device may assign the actual BARs as well as the
interrupt lines to the device. I suspect its harmless here because the
base video device is BIOS configured.

