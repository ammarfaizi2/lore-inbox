Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWJRRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWJRRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWJRRg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:36:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22419 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751445AbWJRRg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:36:27 -0400
Date: Wed, 18 Oct 2006 13:36:26 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] another fallout from the pt_regs removal
In-reply-to: <Pine.LNX.4.64.0610181310440.1971@xanadu.home>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0610181335280.1971@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0610181310440.1971@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK please drop that one -- it has been fixed already.


On Wed, 18 Oct 2006, Nicolas Pitre wrote:

> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> ---
> 
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index ee80d62..142c33c 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -397,7 +397,7 @@ static void lubbock_mmc_poll(unsigned lo
>  	if (LUB_IRQ_SET_CLR & (1 << 0))
>  		mod_timer(&mmc_timer, jiffies + MMC_POLL_RATE);
>  	else {
> -		(void) mmc_detect_int(LUBBOCK_SD_IRQ, (void *)data, NULL);
> +		(void) mmc_detect_int(LUBBOCK_SD_IRQ, (void *)data);
>  		enable_irq(LUBBOCK_SD_IRQ);
>  	}
>  }
> 


Nicolas
