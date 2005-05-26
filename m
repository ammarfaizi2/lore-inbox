Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVEZWUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVEZWUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVEZWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:20:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51401 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261777AbVEZWUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:20:10 -0400
Date: Thu, 26 May 2005 23:52:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: quirk_via_irqpic() must not be __devinit for S1
Message-ID: <20050526215224.GF16472@elf.ucw.cz>
References: <1117136632.6564.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117136632.6564.9.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Got this testing echo 1 > /proc/acpi/sleep on a box 2.6.12-rc5-mm1. 
> Reference to discarded function, patch at bottom. Works nice
> otherwise :-)

Patch looks good, but can only be applied to -mm tree, so it is not
easy to merge to me. Andrew, could you apply this one?

								Pavel

> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: akpm/drivers/pci/quirks.c
> ===================================================================
> --- akpm.orig/drivers/pci/quirks.c	2005-05-26 12:52:03.000000000 +0200
> +++ akpm/drivers/pci/quirks.c	2005-05-26 21:35:08.000000000 +0200
> @@ -499,7 +499,7 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
>  
> -static void __devinit quirk_via_irqpic(struct pci_dev *dev)
> +static void quirk_via_irqpic(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
>  
> 

-- 
