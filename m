Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWAKCB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWAKCB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWAKCB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:01:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27633 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1161133AbWAKCBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:01:55 -0500
Subject: Re: [PATCH] enable soft-irq state w/ raw state
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       mlachwani@mvista.com
In-Reply-To: <200601110128.k0B1Smvi025723@dhcp153.mvista.com>
References: <200601110128.k0B1Smvi025723@dhcp153.mvista.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 18:01:52 -0800
Message-Id: <1136944913.5756.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Disregard this one. Turns out to be something board specific ..

Daniel


On Tue, 2006-01-10 at 17:28 -0800, Daniel Walker wrote:
> 	MIPS needs this due to PF_IRQSOFF being set in the 
> flags during start_kernel() .
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.15/init/main.c
> ===================================================================
> --- linux-2.6.15.orig/init/main.c
> +++ linux-2.6.15/init/main.c
> @@ -515,6 +515,7 @@ asmlinkage void __init start_kernel(void
>  	 * Soft IRQ state will be enabled with the hard state.
>  	 */
>  	raw_local_irq_enable();
> +	local_irq_enable();
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start && !initrd_below_start_ok &&
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

