Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDSJXj>; Fri, 19 Apr 2002 05:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDSJXj>; Fri, 19 Apr 2002 05:23:39 -0400
Received: from vivi.uptime.at ([62.116.87.11]:13988 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S311871AbSDSJXi>;
	Fri, 19 Apr 2002 05:23:38 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Alexander Viro'" <viro@math.psu.edu>,
        "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (5/6) alpha fixes
Date: Fri, 19 Apr 2002 11:23:06 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <017c01c1e783$d3cd1750$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <Pine.GSO.4.21.0204190047140.20383-100000@weyl.math.psu.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are those changes (all Patches) for alpha already in some
kernel? Or do I have to do it on my own? For what kernel
is this?

Best Regards,
  Oliver

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Alexander Viro
> Sent: Friday, April 19, 2002 6:47 AM
> To: Linus Torvalds
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] (5/6) alpha fixes
> 
> 
> 
> diff -urN C8-cpu_idle/arch/alpha/mm/init.c 
> C8-max_pfn/arch/alpha/mm/init.c
> --- C8-cpu_idle/arch/alpha/mm/init.c	Fri Mar  8 02:09:42 2002
> +++ C8-max_pfn/arch/alpha/mm/init.c	Thu Apr 18 23:28:48 2002
> @@ -283,7 +283,7 @@
>  	unsigned long dma_pfn, high_pfn;
>  
>  	dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> -	high_pfn = max_low_pfn;
> +	high_pfn = max_pfn = max_low_pfn;
>  
>  	if (dma_pfn >= high_pfn)
>  		zones_size[ZONE_DMA] = high_pfn;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


