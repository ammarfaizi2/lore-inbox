Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQLRVAy>; Mon, 18 Dec 2000 16:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLRVAn>; Mon, 18 Dec 2000 16:00:43 -0500
Received: from magic.adaptec.com ([208.236.45.80]:47259 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S129391AbQLRVA0>; Mon, 18 Dec 2000 16:00:26 -0500
Message-ID: <E9EF680C48EAD311BDF400C04FA07B612D4DA5@ntcexc02.ntc.adaptec.com>
From: "Boerner, Brian" <Brian_Boerner@adaptec.com>
To: "'Andi Kleen'" <ak@suse.de>, "Boerner, Brian" <Brian_Boerner@adaptec.com>
Cc: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: RE: Disabling interrupts in 2.4.x
Date: Mon, 18 Dec 2000 15:24:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a UP configured system.

-bmb-


> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Monday, December 18, 2000 3:18 PM
> To: Boerner, Brian
> Cc: 'linux-kernel@vger.redhat.com'
> Subject: Re: Disabling interrupts in 2.4.x
> 
> 
> > The only thing I am sure of is that interrupts are simply 
> not disabled.
> 
> They are only disabled on the local CPU, they could still 
> occur on other 
> CPUs. This is not different from 2.2.
> 
> > 
> > I've also looked at some other scsi drivers that are 
> disabling interrupts
> > and they appear to be making similar calls to spin_lock_irqsave.
> > 
> > Does anyone have any suggestions for debugging this? Is 
> there a call that
> > can be made to find out if interrupts are actually disabled?
> 
> unsigned flag; 
> asm volatile("pushfl ; popfl %0" : "=r" (flag)); 
> printk(KERN_DEBUG "local interrupts are %s\n", (flag & 
> (1<<9)) ? "enabled" : "disabled"); 
> 
> -Andi
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
