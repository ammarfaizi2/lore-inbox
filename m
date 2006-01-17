Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWAQVRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWAQVRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWAQVRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:17:39 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:41158 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbWAQVRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:17:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XSJqeLgRRahKyPKNmHSEnhxHXUOsmIUdWwFuiy0Iob09DzagW4UUbpZ/VB5F7xtsEthC+2DB5e6yvWXYujESFRLuq1UbkuUaAz6QcYPeXnLFUnbk30ynA+GMTeVwreslhUwK0MlvVxwREv1u15zNtkPwyiFT1Ti37ZzqPnhdqpc=
Date: Wed, 18 Jan 2006 00:34:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, asun@darksunrising.com
Subject: Re: PATCH: cassini printk format warning
Message-ID: <20060117213442.GA22002@mipter.zuzino.mipt.ru>
References: <1137523175.14135.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137523175.14135.84.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 06:39:34PM +0000, Alan Cox wrote:
> --- linux.vanilla-2.6.16-rc1/drivers/net/cassini.c
> +++ linux-2.6.16-rc1/drivers/net/cassini.c
> @@ -1925,7 +1925,7 @@
>  	u64 compwb = le64_to_cpu(cp->init_block->tx_compwb);
>  #endif
>  	if (netif_msg_intr(cp))
> -		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %lx\n",
> +		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %llx\n",
>  			cp->dev->name, status, compwb);

	"%llx", (unsigned long long)u64

is the warningless way on all archs.

