Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVJCSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVJCSfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVJCSfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:35:19 -0400
Received: from [81.2.110.250] ([81.2.110.250]:43751 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932512AbVJCSfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:35:18 -0400
Subject: Re: [PATCH 2/7] AMD Geode GX/LX support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@AMD.COM>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
In-Reply-To: <20051003175032.GD29264@cosmic.amd.com>
References: <20051003175032.GD29264@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:03:06 +0100
Message-Id: <1128366186.26992.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 11:50 -0600, Jordan Crouse wrote:
> This patch adds support for the Geode LX processor, including CPU 
> identification, config options, and PCI IDs.  Please apply against 
> linux-2.4.15-rc2-mm2.
> 
> Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

>  config X86_USE_3DNOW
>  	bool
> -	depends on MCYRIXIII || MK7 || MGEODE_GX
> +	depends on MCYRIXIII || MK7 || MGEODE_GX || MGEODE_LX
>  	default y
>  
>  config X86_OOSTORE
> @@ -539,7 +548,7 @@ source "kernel/Kconfig.preempt"
>  
>  config X86_UP_APIC
>  	bool "Local APIC support on uniprocessors"
> -	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX)
> +	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX || MGEODE_LX)
>  	help
>  	  A local APIC (Advanced Programmable Interrupt Controller) is an
>  	  integrated interrupt controller in the CPU. If you have a single-CPU
> @@ -756,7 +765,7 @@ config HIGHMEM4G
>  
>  config HIGHMEM64G
>  	bool "64GB"
> -	depends on !MGEODE_GX
> +	depends on !MGEODE_GX && !MGEODE_LX
>  	help


Same question and comments apply to this patch. I've no idea if the
3DNOW is correct since I've not benched an LX but the others look wrong

