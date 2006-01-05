Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752116AbWAEIuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWAEIuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWAEIuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:50:44 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:2983 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S1752116AbWAEIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:50:44 -0500
To: Ben Collins <bcollins@ubuntu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] i386: Handle HP laptop rebooting properly.
References: <0ISL004R0943MT@a34-mta01.direcway.com>
Date: Thu, 5 Jan 2006 09:50:39 +0100
From: ulm@kph.uni-mainz.de (Ulrich Mueller)
Message-ID: <usls3awio@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 04 Jan 2006, Ben Collins wrote:

> --- a/arch/i386/kernel/reboot.c
> +++ b/arch/i386/kernel/reboot.c
> @@ -111,6 +111,14 @@ static struct dmi_system_id __initdata r
>  			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
>  		},
>  	},
> +	{	/* HP laptops have weird reboot issues */
> +		.callback = set_bios_reboot,
> +		.ident = "HP Laptop",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
> +		},
> +	},
>  	{	/* Handle problems with rebooting on HP nc6120 */
>  		.callback = set_bios_reboot,
>  		.ident = "HP Compaq nc6120",

An essentially identical patch is already included in 2.6.15-rc5-mm3:
reboot-through-the-bios-on-newer-hp-laptops.patch 
