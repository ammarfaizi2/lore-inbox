Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKOT55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKOT55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUKOT4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:56:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:44929 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261669AbUKOTxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:53:06 -0500
Date: Mon, 15 Nov 2004 11:51:48 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] PCI cleanups
Message-ID: <20041115195148.GA12820@kroah.com>
References: <20041113030203.GU2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113030203.GU2249@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 04:02:03AM +0100, Adrian Bunk wrote:
> The patch below does some cleanups in the PCI code:
> - make OSC_UUID in drivers/pci/pci-acpi.c static
> - remove the completely unused drivers/pci/hotplug/pciehp_sysfs.c
> - remove other unused code
> 
> Please review which of these changes are correct and which conflict with 
> pending changes.
> 

>  drivers/pci/hotplug/Makefile       |    1 
>  drivers/pci/hotplug/pciehp.h       |    3 
>  drivers/pci/hotplug/pciehp_sysfs.c |  143 -------------

Yeah, this can be deleted.  Care to make a patch for just this?

>  drivers/pci/msi.c                  |  301 -----------------------------
>  drivers/pci/msi.h                  |    1 

These changes are for when drivers want to start taking advantage of
some MSI features.  I've heard rumors that those drivers will be public
soon, but haven't seen them yet :(

>  drivers/pci/pci-acpi.c             |   97 ---------

This is needed for some upcoming PCI Express changes, and should not be
dropped.  I've seen the code that needs this, but it is still under
development and isn't ready for mainline yet.

>  drivers/pci/pci.c                  |   60 -----
>  drivers/pci/rom.c                  |   52 -----

These changes are needed by upcoming video driver changes.

thanks,

greg k-h
