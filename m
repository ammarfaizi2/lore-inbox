Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVFWTpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVFWTpC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVFWTll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:41:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37571 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262700AbVFWTdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:33:52 -0400
Date: Thu, 23 Jun 2005 11:05:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, yshpilevsky@ru.mvista.com
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
Message-ID: <20050623140522.GA25724@logos.cnet>
References: <42BAD78E.1020801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAD78E.1020801@ru.mvista.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrei,

On Thu, Jun 23, 2005 at 07:38:54PM +0400, Andrei Konovalov wrote:
<snip>

> diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> --- a/arch/ppc/syslib/m8xx_setup.c
> +++ b/arch/ppc/syslib/m8xx_setup.c
> @@ -369,7 +369,7 @@ m8xx_map_io(void)
>  #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
>  	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
>  #endif
> -#ifdef CONFIG_FADS
> +#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
>  	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
>  #endif
>  #ifdef CONFIG_PCI

I suppose you also want to include CONFIG_MPC885ADS in the io_block_mapping(IO_BASE) 
here?
