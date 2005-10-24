Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVJXScp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVJXScp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVJXScp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:32:45 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:40328 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751241AbVJXSco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:32:44 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Chen, Justin" <justin.chen@hp.com>
Subject: Re: [PATCH] new hp diva console port
Date: Mon, 24 Oct 2005 12:32:36 -0600
User-Agent: KMail/1.8.2
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
References: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB2F2@cacexc04.americas.cpqcorp.net>
In-Reply-To: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB2F2@cacexc04.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241232.36948.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 October 2005 6:30 pm, Chen, Justin wrote:
> This patch adds the new ID 0x132a and configure the new PCI Diva console
> port.  This device support only 1 single console UART. Please apply.

It'll be easier to apply this if you follow the guidelines in
Documentation/SubmittingPatches.  For example, the patch should
apply with "patch -p1", add "Signed-off-by:", etc.

> --- 8250_pci.c.orig     2005-10-18 15:56:50.148489501 -0700
> +++ 8250_pci.c  2005-10-18 15:55:25.624076474 -0700
> @@ -178,6 +178,7 @@ static int __devinit pci_hp_diva_init(st
>                 rc = 4;
>                 break;
>         case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
> +       case PCI_DEVICE_ID_HP_DIVA_HURRICANE:
>                 rc = 1;
>                 break;
>         }
> --- pci_ids.h.orig      2005-10-18 16:02:56.864305321 -0700
> +++ pci_ids.h   2005-10-18 16:03:54.002976496 -0700
> @@ -710,6 +710,7 @@
>  #define PCI_DEVICE_ID_HP_DIVA_EVEREST  0x1282
>  #define PCI_DEVICE_ID_HP_DIVA_AUX      0x1290
>  #define PCI_DEVICE_ID_HP_DIVA_RMP3     0x1301
> +#define PCI_DEVICE_ID_HP_DIVA_HURRICANE 0x132a
>  #define PCI_DEVICE_ID_HP_CISSA         0x3220
>  #define PCI_DEVICE_ID_HP_CISSB         0x3230
>  #define PCI_DEVICE_ID_HP_ZX2_IOC       0x4031
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
