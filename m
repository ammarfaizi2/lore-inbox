Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWFJVoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWFJVoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWFJVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:44:44 -0400
Received: from www.osadl.org ([213.239.205.134]:56473 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161030AbWFJVon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:44:43 -0400
Subject: Re: [PATCH-rt] genirq error message clarification
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dsaxena@plexity.net
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060610214338.GA14760@plexity.net>
References: <20060610214338.GA14760@plexity.net>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 23:45:23 +0200
Message-Id: <1149975924.5257.205.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 14:43 -0700, Deepak Saxena wrote:
> It makes it a bit easier to debug issues when we know what irq we're
> having problems with.
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> 
> Index: linux-2.6-rt/kernel/irq/manage.c
> ===================================================================
> --- linux-2.6-rt.orig/kernel/irq/manage.c
> +++ linux-2.6-rt/kernel/irq/manage.c
> @@ -328,7 +328,8 @@ int setup_irq(unsigned int irq, struct i
>  mismatch:
>  	spin_unlock_irqrestore(&desc->lock, flags);
>  	if (!(new->flags & SA_PROBEIRQ)) {
> -		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
> +		printk(KERN_ERR "%s: irq %d handler mismatch\n", __FUNCTION__,
> +				irq);
>  		dump_stack();
>  	}
>  	return -EBUSY;

Makes sense. Thanks, applied

	tglx





