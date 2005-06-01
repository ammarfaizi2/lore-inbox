Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFATEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFATEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFATES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:04:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:14483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261244AbVFAS7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:59:24 -0400
Date: Wed, 1 Jun 2005 20:59:19 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm2 on x86_64 missing pci_bus_to_node symbol
Message-ID: <20050601185919.GH23831@wotan.suse.de>
References: <200506011857.j51IvjmE027415@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506011857.j51IvjmE027415@linux.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:57:45AM -0700, Rusty Lynch wrote:
> Attempting to install a fresh 2.6.12-rc5-mm2 kernel on my x86_64 box, 
> I am unable to load my e1000 driver because pci_bus_to_node is undefined.
> 
> I'm not sure if this is the correct way of fixing this, but here is a quick 
> patch to export pci_bus_to_node on x86_64.

Looks good, thanks.
-Andi

> 
>     --rusty
> 
>  arch/x86_64/kernel/x8664_ksyms.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/x8664_ksyms.c
> ===================================================================
> --- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/x8664_ksyms.c
> +++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/x8664_ksyms.c
> @@ -207,3 +207,4 @@ EXPORT_SYMBOL(flush_tlb_page);
>  #endif
>  
>  EXPORT_SYMBOL(cpu_khz);
> +EXPORT_SYMBOL(pci_bus_to_node);
