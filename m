Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSG3Nby>; Tue, 30 Jul 2002 09:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSG3Nbx>; Tue, 30 Jul 2002 09:31:53 -0400
Received: from ns.suse.de ([213.95.15.193]:34067 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318268AbSG3Nbw>;
	Tue, 30 Jul 2002 09:31:52 -0400
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro 0.13a
References: <20020730125601.GT16077@cathedrallabs.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2002 15:35:16 +0200
In-Reply-To: Aristeu Sergio Rozanski Filho's message of "30 Jul 2002 14:58:35 +0200"
Message-ID: <p73sn21s5ij.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -633,37 +633,37 @@
>  
>  	i = inb(dev->base_addr + ID_REG);
>  	printk(KERN_DEBUG " id: %#x ",i);
> -	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
> +	printk(" io: %#x ", (unsigned)dev->base_addr);
>  
>  	switch (lp->eepro) {
>  		case LAN595FX_10ISA:
> -			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
> +			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
>  					dev->name, (unsigned)dev->base_addr);

[more cases deleted]

This surely can't be right. Why are you dropping all the KERN_*s ?

-Andi
