Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUEWC6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUEWC6i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 22:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUEWC6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 22:58:37 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:10459 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262170AbUEWC6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 22:58:35 -0400
Subject: Re: [PATCH][2.4.26 x86_64] fix ACPI PRT entry handling
From: Len Brown <len.brown@intel.com>
To: Andy Currid <acurrid@nvidia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FBF36@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FBF36@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1085281102.12353.716.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 May 2004 22:58:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accepted.

Thanks,
-Len

On Fri, 2004-05-21 at 18:23, Andy Currid wrote:
> This patch fixes a PCI interrupt routing bug that shows up when
> running
> on x86_64 with ACPI and IOAPIC functionality enabled. Without this
> patch
> in place, the code attempts to route all configurable PCI interrupts
> to
> IRQ 0.
> 
> Regards
> 
> Andy
> --
> Andy Currid, NVIDIA Corporation 
> acurrid@nvidia.com   408 566 6743
> 
> --
> diff -Nupr linux-2.4.26/arch/x86_64/kernel/mpparse.c
> linux-2.4.26-patch/arch/x86_64/kernel/mpparse.c
> --- linux-2.4.26/arch/x86_64/kernel/mpparse.c   2004-05-21
> 06:39:40.000000000 -0700
> +++ linux-2.4.26-patch/arch/x86_64/kernel/mpparse.c     2004-05-21
> 06:39:33.000000000 -0700
> @@ -942,8 +942,6 @@ void __init mp_parse_prt (void)
>                         irq = entry->link.index;
>                 }
>  
> -               irq = entry->link.index;
> -
>                 /* Don't set up the ACPI SCI because it's already set
> up
> */
>                  if (acpi_fadt.sci_int == irq) {
>                           entry->irq = irq; /*we still need to set
> entry's irq*/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

