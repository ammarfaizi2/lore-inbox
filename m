Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSG3Nwp>; Tue, 30 Jul 2002 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318260AbSG3Nwp>; Tue, 30 Jul 2002 09:52:45 -0400
Received: from ns.suse.de ([213.95.15.193]:31241 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318258AbSG3Nwp>;
	Tue, 30 Jul 2002 09:52:45 -0400
To: Andi Kleen <ak@suse.de>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro 0.13a
References: <20020730125601.GT16077@cathedrallabs.org.suse.lists.linux.kernel>
	<p73sn21s5ij.fsf@oldwotan.suse.de>
X-Yow: I've got to get these SNACK CAKES to NEWARK by DAWN!!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 30 Jul 2002 15:56:06 +0200
In-Reply-To: <p73sn21s5ij.fsf@oldwotan.suse.de> (Andi Kleen's message of "30
 Jul 2002 15:35:16 +0200")
Message-ID: <jeit2xuxop.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

|> > @@ -633,37 +633,37 @@
|> >  
|> >  	i = inb(dev->base_addr + ID_REG);
|> >  	printk(KERN_DEBUG " id: %#x ",i);
|> > -	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
|> > +	printk(" io: %#x ", (unsigned)dev->base_addr);
|> >  
|> >  	switch (lp->eepro) {
|> >  		case LAN595FX_10ISA:
|> > -			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
|> > +			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
|> >  					dev->name, (unsigned)dev->base_addr);
|> 
|> [more cases deleted]
|> 
|> This surely can't be right. Why are you dropping all the KERN_*s ?

Because the previous output is not terminated by a newline, and KERN_*s
are only recognized after newline, not in the middle of a line.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
