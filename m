Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSG3NnR>; Tue, 30 Jul 2002 09:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSG3NnR>; Tue, 30 Jul 2002 09:43:17 -0400
Received: from 4-249.ctame701-3.telepar.net.br ([200.193.150.249]:1525 "EHLO
	matthew.cathedral.com") by vger.kernel.org with ESMTP
	id <S318287AbSG3NnQ>; Tue, 30 Jul 2002 09:43:16 -0400
Date: Tue, 30 Jul 2002 10:48:25 -0300
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro 0.13a
Message-ID: <20020730134825.GU16077@cathedrallabs.org>
References: <20020730125601.GT16077@cathedrallabs.org.suse.lists.linux.kernel> <p73sn21s5ij.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73sn21s5ij.fsf@oldwotan.suse.de>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -633,37 +633,37 @@
> >  
> >  	i = inb(dev->base_addr + ID_REG);
> >  	printk(KERN_DEBUG " id: %#x ",i);
> > -	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
> > +	printk(" io: %#x ", (unsigned)dev->base_addr);
> >  
> >  	switch (lp->eepro) {
> >  		case LAN595FX_10ISA:
> > -			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
> > +			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
> >  					dev->name, (unsigned)dev->base_addr);
> 
> [more cases deleted]
> 
> This surely can't be right. Why are you dropping all the KERN_*s ?
printk that doesn't start a new line had KERN_* removed because it prints in
the middle of line KERN_* macros like
 id: 0xb4 <7> io: 0x340 <6>eth0: Intel EtherExpress Pro/10+ ISA
i had the same reaction but Michael pointed this to me. i don't know exactly
how this macro works, but you'll have the line printed out with the
beggining using KERN_* macro. isn't that sufficient?

-- 
aris
