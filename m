Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUAWNdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUAWNdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:33:00 -0500
Received: from lists.us.dell.com ([143.166.224.162]:15834 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266557AbUAWNc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:32:56 -0500
Date: Fri, 23 Jan 2004 07:32:50 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: DMI updates from 2.4
Message-ID: <20040123073250.A21294@lists.us.dell.com>
References: <E1Ajuub-0000x4-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1Ajuub-0000x4-00@hardwired>; from davej@redhat.com on Fri, Jan 23, 2004 at 06:35:25AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
> +			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
> +			NO_MATCH, NO_MATCH
> +			} },
> +	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
> +			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
> +			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
> +			MATCH(DMI_BIOS_VERSION,"A11")
> +			} },
> +	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
> +			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
> +			NO_MATCH, NO_MATCH
> +			} },
>  	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
>  			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
>  			MATCH(DMI_BIOS_VERSION, "A04"),
> @@ -568,6 +608,12 @@ static __initdata struct dmi_blacklist d
>  			MATCH(DMI_BIOS_VERSION, "A12"),
>  			MATCH(DMI_BIOS_DATE, "02/04/2002"), NO_MATCH
>  			} },
> +	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
> +			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
> +			MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
> +			MATCH(DMI_BIOS_VERSION,"A11")
> +			} },
> -	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
> -			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> -			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
> -			NO_MATCH, NO_MATCH
> -			} },


For Dell desktops/notebooks, if someone can provide me with details
regarding BIOS crashes (more than "it's horked", but how it's horked,
and if it's clearly like an ACPI table that's wrong and can be shown
how), I've got the ears of the BIOS guys (being held in jars on
my desk).  They're getting tired of hearing on the discussion boards
"Dell BIOSses are broken".

Of course, I take reports of server and workstation BIOS problems too.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
