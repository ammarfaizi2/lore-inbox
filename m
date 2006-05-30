Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWE3X1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWE3X1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWE3X1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:27:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46345 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964821AbWE3X1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:27:33 -0400
Date: Wed, 31 May 2006 01:27:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
Message-ID: <20060530232731.GH3955@stusta.de>
References: <20060524002013.19403.57410.stgit@gitlost.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524002013.19403.57410.stgit@gitlost.site>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 05:20:13PM -0700, Chris Leech wrote:
> Adds a new ioatdma driver
> 
> Signed-off-by: Chris Leech <christopher.leech@intel.com>
> ---
> 
>  drivers/dma/Kconfig             |    9 
>  drivers/dma/Makefile            |    1 
>  drivers/dma/ioatdma.c           |  839 +++++++++++++++++++++++++++++++++++++++
>  drivers/dma/ioatdma.h           |  126 ++++++
>  drivers/dma/ioatdma_hw.h        |   52 ++
>  drivers/dma/ioatdma_io.h        |  118 +++++
>  drivers/dma/ioatdma_registers.h |  126 ++++++
>  7 files changed, 1271 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index f9ac4bc..0f15e76 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -10,4 +10,13 @@ config DMA_ENGINE
>  	  DMA engines offload copy operations from the CPU to dedicated
>  	  hardware, allowing the copies to happen asynchronously.
>  
> +comment "DMA Devices"
> +
> +config INTEL_IOATDMA
> +	tristate "Intel I/OAT DMA support"
> +	depends on DMA_ENGINE && PCI
> +	default m
> +	---help---
> +	  Enable support for the Intel(R) I/OAT DMA engine.
> +
>  endmenu
>...

- please don't use "default m"
- can you enhance the help text?
  e.g. you could list which hardware contains this DMA engine

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

