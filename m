Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWCNXEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWCNXEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWCNXEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:04:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20631 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750902AbWCNXEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:04:34 -0500
Date: Wed, 15 Mar 2006 00:03:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Message-ID: <20060314230348.GC1579@elf.ucw.cz>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314082634.GG23631@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060314082634.GG23631@granada.merseine.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 14-03-06 10:26:34, Muli Ben-Yehuda wrote:
> This patch hooks Calgary into the build and the x86-64 IOMMU
> initialization paths.
> 
> Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>
> Signed-Off-By: Jon Mason <jdmason@us.ibm.com>
> 
> diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/Kconfig linux/arch/x86_64/Kconfig
> --- iommu_detected/arch/x86_64/Kconfig	2006-03-14 08:58:23.000000000 +0200
> +++ linux/arch/x86_64/Kconfig	2006-03-12 10:49:04.000000000 +0200
> @@ -372,6 +372,16 @@ config GART_IOMMU
>  	  and a software emulation used on other systems.
>  	  If unsure, say Y.
>  
> +config CALGARY_IOMMU
> +	bool "IBM x366 server IOMMU"
> +	default y
> +	depends on PCI && MPSC && EXPERIMENTAL
> +	help
> +	  Support for hardware IOMMUs in IBM's x366 server
> +	  systems. The IOMMU can be turned off at runtime with the
> +	  iommu=off parameter. Normally the kernel will make the right

Runtime? I think you meant boottime.

> +	  choice by itself.  If unsure, say Y.

Eh? How common are those machines?
								Pavel

-- 
32:        bw.Write( sbuffer );
