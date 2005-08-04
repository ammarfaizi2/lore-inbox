Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVHDKhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVHDKhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVHDKhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:37:55 -0400
Received: from colin.muc.de ([193.149.48.1]:40458 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262472AbVHDKhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:37:51 -0400
Date: 4 Aug 2005 12:37:49 +0200
Date: Thu, 4 Aug 2005 12:37:49 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] x86_64: create sysfs entries for cpu only for present cpus
Message-ID: <20050804103749.GA97893@muc.de>
References: <20050801202017.043754000@araj-em64t> <20050801203011.065721000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203011.065721000@araj-em64t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:20:19PM -0700, Ashok Raj wrote:
> Need to create sysfs only for cpus that are present. Without which we see
> NR_CPUS entries created when we have CONFIG_HOTPLUG and CONFIG_HOTPLUG_CPU
> enabled.

Thanks looks good.

-Andi

> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> --------------------------------------------------------------
>  arch/i386/mach-default/topology.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.13-rc3-ak/arch/i386/mach-default/topology.c
> ===================================================================
> --- linux-2.6.13-rc3-ak.orig/arch/i386/mach-default/topology.c
> +++ linux-2.6.13-rc3-ak/arch/i386/mach-default/topology.c
> @@ -76,7 +76,7 @@ static int __init topology_init(void)
>  	for_each_online_node(i)
>  		arch_register_node(i);
>  
> -	for_each_cpu(i)
> +	for_each_present_cpu(i)
>  		arch_register_cpu(i);
>  	return 0;
>  }
> @@ -87,7 +87,7 @@ static int __init topology_init(void)
>  {
>  	int i;
>  
> -	for_each_cpu(i)
> +	for_each_present_cpu(i)
>  		arch_register_cpu(i);
>  	return 0;
>  }
> 
> --
> 
