Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUC3PFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbUC3PFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:05:13 -0500
Received: from mail.cyclades.com ([64.186.161.6]:60887 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263705AbUC3PFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:05:06 -0500
Date: Tue, 30 Mar 2004 11:54:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dave Jones <davej@redhat.com>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pc300 driver misplaced ;
Message-ID: <20040330145414.GA5887@logos.cnet>
References: <20040330143524.GB25834@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330143524.GB25834@redhat.com>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, Linus, please apply.

On Tue, Mar 30, 2004 at 03:35:24PM +0100, Dave Jones wrote:
> --- linux-2.6.4/drivers/net/wan/pc300_drv.c~	2004-03-30 15:30:57.000000000 +0100
> +++ linux-2.6.4/drivers/net/wan/pc300_drv.c	2004-03-30 15:32:11.000000000 +0100
> @@ -3661,7 +3661,7 @@
>  			release_mem_region(card->hw.falcphys, card->hw.falcsize);
>  		}
>  		for (i = 0; i < card->hw.nchan; i++)
> -			if (card->chan[i].d.dev);
> +			if (card->chan[i].d.dev)
>  				free_netdev(card->chan[i].d.dev);
>  		if (card->hw.irq)
>  			free_irq(card->hw.irq, card);
