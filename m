Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbULIUtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbULIUtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbULIUtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:49:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:53156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261614AbULIUs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:48:59 -0500
Date: Thu, 9 Dec 2004 12:42:23 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH] PCI/x86-64: build with PCI=n
Message-ID: <20041209204223.GA27309@kroah.com>
References: <20041130172354.2bd60e89.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130172354.2bd60e89.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 05:23:54PM -0800, Randy.Dunlap wrote:
> 
> Fix (most of) x64-64 kernel build for CONFIG_PCI=n.  Fixes these 2 errors:
> 
> 1. arch/x86_64/kernel/built-in.o(.text+0x8186): In function `quirk_intel_irqbalance':
> : undefined reference to `raw_pci_ops'
> 
> Kconfig change:
> 2. arch/x86_64/kernel/pci-gart.c:194: error: `pci_bus_type' undeclared (first use in this function)
> 
> Still does not fix this one:
> drivers/built-in.o(.text+0x3dcd8): In function `pnpacpi_allocated_resource':
> : undefined reference to `pcibios_penalize_isa_irq'
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Applied, thanks.

greg k-h
