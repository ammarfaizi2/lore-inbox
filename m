Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313560AbSDLLzp>; Fri, 12 Apr 2002 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313561AbSDLLzo>; Fri, 12 Apr 2002 07:55:44 -0400
Received: from employees.nextframe.net ([212.169.100.200]:13552 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S313560AbSDLLzm>; Fri, 12 Apr 2002 07:55:42 -0400
Date: Fri, 12 Apr 2002 13:57:22 +0200
From: Morten Helgesen <admin@nextframe.net>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.8-pre3 - drivers/net/wan/farsync.c
Message-ID: <20020412135722.H6609@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20020412133438.A5627@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Francois! 

I`ve been working with Kevin Curtis <kevin.curtis@farsite.co.uk> (the current maintainer of farsync.c) the last couple
of days, and we`ve performed a bit of spring cleaning, including pci_enable_device() fixes and this fix for
dev->rmem_end/start. Kevin also said he has been working on performance issues, so the next release of this driver should be
really fancy :) 

Right, Kevin ? :)

== Morten

On Fri, Apr 12, 2002 at 01:34:38PM +0200, Francois Romieu wrote:
> Greetings,
> 
> Problem:
> compilation fails due to removal of rmem_{start/end} in struct net_device.
> 
> Fix:
> Simple removal. I haven't found any other use of these fields in the driver.
> 
> --- linux-2.5.8-pre3.orig/drivers/net/wan/farsync.c	Thu Apr 11 23:51:52 2002
> +++ linux-2.5.8-pre3/drivers/net/wan/farsync.c	Thu Apr 11 23:55:24 2002
> @@ -1469,10 +1469,6 @@ fst_init_card ( struct fst_card_info *ca
>                                   + BUF_OFFSET ( txBuffer[i][0][0]);
>                  dev->mem_end     = card->phys_mem
>                                   + BUF_OFFSET ( txBuffer[i][NUM_TX_BUFFER][0]);
> -                dev->rmem_start  = card->phys_mem
> -                                 + BUF_OFFSET ( rxBuffer[i][0][0]);
> -                dev->rmem_end    = card->phys_mem
> -                                 + BUF_OFFSET ( rxBuffer[i][NUM_RX_BUFFER][0]);
>                  dev->base_addr   = card->pci_conf;
>                  dev->irq         = card->irq;
>  
> -- 
> Ueimor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
