Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVAATYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVAATYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVAATYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 14:24:33 -0500
Received: from gprs214-85.eurotel.cz ([160.218.214.85]:61824 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261165AbVAATYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 14:24:31 -0500
Date: Sat, 1 Jan 2005 18:59:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Message-ID: <20050101175934.GB1345@elf.ucw.cz>
References: <1104249508.22366.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104249508.22366.101.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ported to the new kernel/irq code.

Perhaps some Documentation/ patch would be nice?

I always thought manually polling interrupt handlers might be usefull,
and it indeed was very usefull on philips velo 1...
								Pavel

> +static int __init irqfixup_setup(char *str)
> +{
> +	irqfixup = 1;
> +	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
> +	printk(KERN_WARNING "This may impact system performance.\n");
> +	return 1;
> +}
> +
> +__setup("irqfixup", irqfixup_setup);
> +
> +static int __init irqpoll_setup(char *str)
> +{
> +	irqfixup = 2;
> +	printk(KERN_WARNING "Misrouted IRQ fixup and polling support enabled.\n");
> +	printk(KERN_WARNING "This may significantly impact system performance.\n");
> +	return 1;
> +}
> +
> +__setup("irqpoll", irqpoll_setup);
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
