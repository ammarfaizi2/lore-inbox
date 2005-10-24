Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVJXWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVJXWfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVJXWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:35:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4367 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751363AbVJXWfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:35:22 -0400
Date: Mon, 24 Oct 2005 23:35:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Chen, Justin" <justin.chen@hp.com>
Cc: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: [PATCH] new hp diva console port
Message-ID: <20051024223512.GG26959@flint.arm.linux.org.uk>
Mail-Followup-To: "Chen, Justin" <justin.chen@hp.com>,
	"Helgaas, Bjorn" <bjorn.helgaas@hp.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB8D6@cacexc04.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB8D6@cacexc04.americas.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 02:38:02PM -0700, Chen, Justin wrote:
> On Monday, October 24, 2005 11:33 AM, Helgaas, Bjorn wrote:
> >It'll be easier to apply this if you follow the guidelines in 
> >Documentation/SubmittingPatches.  For example, the patch 
> >should apply with "patch -p1", add "Signed-off-by:", etc.
> 
> Okay,  here is the adjusted format and the signature -
> 
> This patch adds the new ID 0x132a and configure the new PCI Diva console
> port.  This device support only 1 single console UART. Please apply.
> Thanks,
>  
> Signed-off-by: Justin Chen <justin.chen@hp.com>

I've actually already committed this, via Andrew Morton.  Note,
however, that your mailer has wrapped the patch, so maybe it's
better for you to attach patches (as text/plain) to your emails?

> ------------------------------------------------------------------------
> -------------------------------------------------------
> diff -uprN -X dontdiff linux-vanilla/drivers/serial/8250_pci.c
> ia-26126/drivers/serial/8250_pci.c
> --- linux-vanilla/drivers/serial/8250_pci.c	2005-10-24
> 12:32:01.817851490 -0700
> +++ ia-26126/drivers/serial/8250_pci.c	2005-10-24 12:24:13.628404100
> -0700
> @@ -177,6 +177,7 @@ static int __devinit pci_hp_diva_init(st
>  		rc = 4;
>  		break;
>  	case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
> +	case PCI_DEVICE_ID_HP_DIVA_HURRICANE:
>  		rc = 1;
>  		break;
>  	}
> diff -uprN -X dontdiff linux-vanilla/include/linux/pci_ids.h
> ia-26126/include/linux/pci_ids.h
> --- linux-vanilla/include/linux/pci_ids.h	2005-10-24
> 12:31:49.661601638 -0700
> +++ ia-26126/include/linux/pci_ids.h	2005-10-24 12:23:31.366685868
> -0700
> @@ -711,6 +711,7 @@
>  #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
>  #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
>  #define PCI_DEVICE_ID_HP_DIVA_RMP3	0x1301
> +#define PCI_DEVICE_ID_HP_DIVA_HURRICANE 0x132a
>  #define PCI_DEVICE_ID_HP_CISSA		0x3220
>  #define PCI_DEVICE_ID_HP_CISSB		0x3230
>  #define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031
> ------------------------------------------------------------------------
> --------------------------------------------------------------

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
