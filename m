Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWFKVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWFKVGS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWFKVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:06:18 -0400
Received: from www.osadl.org ([213.239.205.134]:17062 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750974AbWFKVGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:06:17 -0400
Subject: Re: [PATCH -rt] fix misspelled PREEMPT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dwalker@mvista.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060611194749.358928000@mvista.com>
References: <20060611194749.358928000@mvista.com>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 23:07:02 +0200
Message-Id: <1150060022.5257.214.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 12:47 -0700, dwalker@mvista.com wrote:
> While reviewing I noticed this .. It didn't effect me, but it
> must effect someone .. The patch is untested ..

Good catch. 

Thanks,

	tglx


> ---
>  arch/i386/kernel/io_apic.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.16/arch/i386/kernel/io_apic.c
> ===================================================================
> --- linux-2.6.16.orig/arch/i386/kernel/io_apic.c
> +++ linux-2.6.16/arch/i386/kernel/io_apic.c
> @@ -1297,7 +1297,7 @@ static void ioapic_register_intr(int irq
>  
>  	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  			trigger == IOAPIC_LEVEL)
> -#ifdef CONFIG_PREMMPT_HARDIRQS
> +#ifdef CONFIG_PREEMPT_HARDIRQS
>  		set_irq_chip_and_handler(idx, &ioapic_chip,
>  					 handle_level_irq);
>  #else
> --

