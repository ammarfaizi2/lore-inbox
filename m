Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269223AbUHaVBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269223AbUHaVBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaUd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:33:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34039 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268875AbUHaU1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:27:15 -0400
Date: Tue, 31 Aug 2004 22:27:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dmitry Golubev <dmitry@mikrotik.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] embedding 2.6 or more findings on kernel size
Message-ID: <20040831202707.GQ3466@fs.tum.de>
References: <200408302307.35052.dmitry@mikrotik.com> <200408311710.01601.dmitry@mikrotik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408311710.01601.dmitry@mikrotik.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 05:10:01PM +0300, Dmitry Golubev wrote:
>...
> --- ./linux-2.6.8.1/arch/i386/Kconfig	2004-08-14 13:54:50.000000000 +0300
> +++ ./linux-2.6.8.1_new/arch/i386/Kconfig	2004-08-31 15:19:02.000000000 +0300
> @@ -321,6 +321,46 @@
>  
>  endchoice
>  
> +menu "Specific x86 vendor support"
> +	depends on X86
> +	
> +config X86_CPU_VENDOR_AMD
> +	bool "Advanced Micro Devices"
> +	default y
> +
> +config X86_CPU_VENDOR_CYRIX
> +	bool "Cyrix | VIA | National Semiconductor"
> +	default y
> +
> +config X86_CPU_VENDOR_CENTAUR
> +	bool "Centaur Technology"
> +	default y
> +	help
> +	  This option enables support for Centaur C6 (IDT WinChip) 
> +	  processor family.
> +
> +config X86_CPU_VENDOR_TRANSMETA
> +	bool "Transmeta Crusoe"
> +	default y
> +
> +config X86_CPU_VENDOR_INTEL
> +	bool "Intel"
> +	default y
> +
> +config X86_CPU_VENDOR_RISE
> +	bool "Rise Technology"
> +	default y
> +
> +config X86_CPU_VENDOR_NEXGEN
> +	bool "NexGen"
> +	default y
> +
> +config X86_CPU_VENDOR_UMC
> +	bool "UMC Green CPUs"
> +	default y
> +
> +endmenu
> +
>...


Please don't include this.

I'd prefer to switch i386 cpu selection to a different scheme which 
gives you effectively these options for free without additional options.

@Andrew:
You rejected my i386 cpu selection patch for 2.6 some time ago, and 
asked me to resend it for 2.7 .
With the new 2.6 development model, will you now accept this patch
in 2.6?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

