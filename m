Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWIVWI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWIVWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWIVWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:08:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2516 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965217AbWIVWI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:08:27 -0400
Message-ID: <45145ED9.1080801@garzik.org>
Date: Fri, 22 Sep 2006 18:08:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Judith Lebzelter <judith@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dale@farnsworth.org
Subject: Re: Arrr! Linux 2.6.18
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org> <20060922215120.GD23169@shell0.pdx.osdl.net>
In-Reply-To: <20060922215120.GD23169@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith Lebzelter wrote:
>> Dale Farnsworth:
>>       mv643xx_eth: Unmap DMA buffers in receive path
>>
> 
> In OSDL's automated cross-compile for powerpc64, kernel 2.6.18 had this 
> unexpected error:
> 
> drivers/net/mv643xx_eth.c: In function 'mv643xx_eth_receive_queue':
> drivers/net/mv643xx_eth.c:388: error: 'RX_SKB_SIZE' undeclared (first use in this function)
> 
> Here is a patch that stops the error.
> 
> Judith Lebzelter
> OSDL
> 
> --- drivers/net/mv643xx_eth.c.old	2006-09-22 11:22:47.951049416 -0700
> +++ drivers/net/mv643xx_eth.c	2006-09-22 11:23:17.787625304 -0700
> @@ -385,7 +385,7 @@
>  	struct pkt_info pkt_info;
>  
>  	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
> -		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
> +		dma_unmap_single(NULL, pkt_info.buf_ptr, ETH_RX_SKB_SIZE,
>  							DMA_FROM_DEVICE);

Man, talk about timing.  I just sent this to Andrew & Linus just a few 
seconds ago :)

	Jeff



