Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWHPPpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWHPPpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHPPpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:45:32 -0400
Received: from hera.kernel.org ([140.211.167.34]:51591 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932082AbWHPPpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:45:32 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [125/145] i376: Make acpi_force static
Date: Wed, 16 Aug 2006 11:47:15 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193724.A2B5F13C16@wotan.suse.de>
In-Reply-To: <20060810193724.A2B5F13C16@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161147.15704.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:37, Andi Kleen wrote:

Ack -- assuming there was a previous patch I didn't see to move the definition of acpi_force
to boot.c from setup.c on i386...

-Len

> 
> From: Adrian Bunk <bunk@stusta.de>
> 
> acpi_force can become static.
> 
> Cc: len.brown@intel.com
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/kernel/acpi/boot.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/acpi/boot.c
> +++ linux/arch/i386/kernel/acpi/boot.c
> @@ -36,7 +36,7 @@
>  #include <asm/io.h>
>  #include <asm/mpspec.h>
>  
> -int __initdata acpi_force = 0;
> +static int __initdata acpi_force = 0;
>  
>  #ifdef	CONFIG_ACPI
>  int acpi_disabled = 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
