Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVERQbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVERQbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVERQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:27:59 -0400
Received: from colin.muc.de ([193.149.48.1]:49673 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262281AbVERQ1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:27:14 -0400
Date: 18 May 2005 18:27:10 +0200
Date: Wed, 18 May 2005 18:27:10 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, apw@shadowen.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 4/4] add x86-64 specific support for sparsemem
Message-ID: <20050518162710.GD88141@muc.de>
References: <200505181528.j4IFSTo1026925@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181528.j4IFSTo1026925@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -400,9 +401,12 @@ static __init void parse_cmdline_early (
>  }
>  
>  #ifndef CONFIG_NUMA
> -static void __init contig_initmem_init(void)
> +static void __init
> +contig_initmem_init(unsigned long start_pfn, unsigned long end_pfn)
>  {
>          unsigned long bootmap_size, bootmap; 
> +
> +	memory_present(0, start_pfn, end_pfn);

Watch indentation.

Rest looks good.

-Andi
