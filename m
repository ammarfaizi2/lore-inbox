Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWJXTpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWJXTpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWJXTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:45:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37525 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030441AbWJXTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:45:08 -0400
Date: Tue, 24 Oct 2006 14:44:49 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] ioc4: fix printk format warning
In-Reply-To: <20061023214330.04657b3c.randy.dunlap@oracle.com>
Message-ID: <20061024142933.P826@pkunk.americas.sgi.com>
References: <20061023214330.04657b3c.randy.dunlap@oracle.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change is fine by me.

Acked-by: Brent Casavant <bcasavan@sgi.com>

On Mon, 23 Oct 2006, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warning:
> drivers/misc/ioc4.c:213: warning: long long int format, u64 arg (arg 3)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
> 
>  drivers/misc/ioc4.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2619-rc3-pv.orig/drivers/misc/ioc4.c
> +++ linux-2619-rc3-pv/drivers/misc/ioc4.c
> @@ -209,8 +209,8 @@ ioc4_clock_calibrate(struct ioc4_driver_
>  
>  		do_div(ns, IOC4_EXTINT_COUNT_DIVISOR);
>  		printk(KERN_DEBUG
> -		       "IOC4 %s: PCI clock is %lld ns.\n",
> -		       pci_name(idd->idd_pdev), ns);
> +		       "IOC4 %s: PCI clock is %llu ns.\n",
> +		       pci_name(idd->idd_pdev), (unsigned long long)ns);
>  	}
>  
>  	/* Remember results.  We store the extint clock period rather
> 
> 
> ---
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
