Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVJEURn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVJEURn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVJEURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:17:43 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:49926 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030365AbVJEURm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pkFJjQTr8rrH2BXxfwPuJaR+YchdSXCAbqEEXZCMdWF8+Gsca5UsSvpWrwA6nWAIQlzeyDgQ9WA20gO301czF3CSv/MN55hkipnxpD/Ljvw/DtIyJPD8zoRRNWOpU6mriaT2Y3dbfXZlaRMUSwFmB+c9Y7MbjsdZvbIiXclshYA=
Date: Thu, 6 Oct 2005 00:29:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.6.14-rc3-git4-bird1
Message-ID: <20051005202904.GA27229@mipter.zuzino.mipt.ru>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004203009.GQ7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- RC14-rc3-git4/arch/arm/mm/consistent.c
> +++ RC14-rc3-git4-final/arch/arm/mm/consistent.c

> -vm_region_alloc(struct vm_region *head, size_t size, int gfp)
> +vm_region_alloc(struct vm_region *head, size_t size, unsigned int gfp)

> -__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, int gfp,
> -	    pgprot_t prot)
> +__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +	    unsigned int gfp, pgprot_t prot)

	unsigned int __nocast gfp

	=> dma_alloc_coherent
	=> dma_alloc_writecombine

