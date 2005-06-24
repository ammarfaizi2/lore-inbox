Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbVFXRTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbVFXRTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbVFXRRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:17:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263375AbVFXRNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:13:22 -0400
Date: Fri, 24 Jun 2005 10:13:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Pasha Zubkov <pasha.zubkov@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.12.1 & disabled CONFIG_PCI
Message-ID: <20050624171319.GD9153@shell0.pdx.osdl.net>
References: <42BC41C4.7010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC41C4.7010501@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pasha Zubkov (pasha.zubkov@gmail.com) wrote:
> --- linux-2.6.12.1/drivers/pnp/pnpacpi/rsparser.c	2005-06-24 20:12:26.000000000 +0300
> +++ /usr/src/linux-2.6.12.1/drivers/pnp/pnpacpi/rsparser.c	2005-06-24 20:03:32.000000000 +0300
> @@ -20,7 +20,13 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
> +
> +#ifdef CONFIG_PCI
>  #include <linux/pci.h>
> +#else
> +inline void pcibios_penalize_isa_irq(int irq) {}
> +#endif /* CONFIG_PCI */
> +
>  #include "pnpacpi.h"
>  
>  #ifdef CONFIG_IA64

This should be done in header file, then the pnpbios bit can be cleaned
up as well.

thanks,
-chris
