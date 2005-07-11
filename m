Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVGKWc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVGKWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVGKWaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:30:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45321 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262962AbVGKW22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:28:28 -0400
Date: Mon, 11 Jul 2005 23:28:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com
Subject: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource
Message-ID: <20050711232812.F1540@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	akpm@osdl.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	greg@kroah.com
References: <20050711222138.GH30827@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050711222138.GH30827@isilmar.linta.de>; from linux@dominikbrodowski.net on Tue, Jul 12, 2005 at 12:21:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 12:21:38AM +0200, Dominik Brodowski wrote:
> --- 2.6.13-rc2-git3.orig/arch/arm/kernel/bios32.c
> +++ 2.6.13-rc2-git3/arch/arm/kernel/bios32.c
> @@ -447,9 +447,26 @@ pcibios_resource_to_bus(struct pci_dev *
>  	region->end   = res->end - offset;
>  }
>  
> +void __devinit
> +pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>...
>  EXPORT_SYMBOL(pcibios_fixup_bus);
>  EXPORT_SYMBOL(pcibios_resource_to_bus);
> +EXPORT_SYMBOL(pcibios_bus_to_resources);

Please look carefully at the above change.  I'd appreciate it if this
could be fixed. 8)

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
