Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUFWOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUFWOyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFWOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:54:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265974AbUFWOxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:53:46 -0400
Message-ID: <40D9996C.3080904@pobox.com>
Date: Wed, 23 Jun 2004 10:53:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@donpac.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 5/6] 2.6.7-mm1, remove unused ASUS K7V-RM DMI quirk
References: <10879946911371@donpac.ru>
In-Reply-To: <10879946911371@donpac.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> BROKEN_ACPI_Sx flag doesn't seem to be used anywhere in the kernel,
> so ASUS K7V-RM can be removed.
> 
> Signed-off-by: Andrey Panin <pazke@donpac.ru>
> 
>  arch/i386/kernel/dmi_scan.c |   17 -----------------
>  1 files changed, 17 deletions(-)
> 
> diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
> --- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:59:58 2004
> +++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 23:00:53 2004
> @@ -348,17 +348,6 @@ static __init int swab_apm_power_in_minu
>  }
>  
>  /*
> - * ASUS K7V-RM has broken ACPI table defining sleep modes
> - */
> -
> -static __init int broken_acpi_Sx(struct dmi_blacklist *d)
> -{
> -	printk(KERN_WARNING "Detected ASUS mainboard with broken ACPI sleep table\n");
> -	dmi_broken |= BROKEN_ACPI_Sx;
> -	return 0;
> -}
> -
> -/*
>   * Toshiba keyboard likes to repeat keys when they are not repeated.
>   */
>  
> @@ -712,12 +701,6 @@ static __initdata struct dmi_blacklist d
>  	{ local_apic_kills_bios, "ASUS L3C", {
>  			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
>  			MATCH(DMI_BOARD_NAME, "P4_L3C"),
> -			NO_MATCH, NO_MATCH
> -			} },
> -
> -	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
> -			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
> -			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
>  			NO_MATCH, NO_MATCH
>  			} },

Maybe CC Len Brown on this, to see if he screams?  :)

	Jeff



