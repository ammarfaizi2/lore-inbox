Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760039AbWLCThz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760039AbWLCThz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760040AbWLCThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:37:55 -0500
Received: from smtp.flash.net.br ([201.46.240.48]:40597 "EHLO
	smtp.gru.flash.tv.br") by vger.kernel.org with ESMTP
	id S1760039AbWLCThy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:37:54 -0500
Date: Sat, 2 Dec 2006 23:49:52 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: The return of the dreaded "nobody cared" message with a Promise  Card
Message-ID: <20061203014952.GA2893@ime.usp.br>
References: <20061129060130.GA2913@ime.usp.br> <20061129110336.22e2ca18@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061129110336.22e2ca18@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan.

First of all, thank you very much for your usual kind responses to me.

Second, let me apologize for not being able to reply earlier. :-( I hope
that you have not lost interest in fixing this strange situation.

I think that I can be speedier with the replies now and, if you wish, I
can even go to an IRC channel so that we can exchange information
faster, if you want.

On Nov 29 2006, Alan wrote:
> On Wed, 29 Nov 2006 04:01:30 -0200
> Rogério Brito <rbrito@ime.usp.br> wrote:
> 
> >> The problem is that whenever I plug the Quantum drive, I get stack
> > traces like this one (with a bit of context, so that you can get sense of
> > what I am talking about):
> 
> Ok IRQ routing problem on what seems to be an external IRQ.

Nice that you have at least identified a possibility.

> > ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> > PCI: setting IRQ 10 as level-triggered
> > ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
> 
> Do your working kernels also have ACPI enabled and what do they say
> here ?

I have always had ACPI enabled, but, as you asked me, I grabbed a
-rc6-mm2 kernel and tried to pass irqpoll.

The nice news is that it doesn't hang like vanilla -rc6 with
"Uncompressing Linux...", but the unexpected side effect that I got is
that none of my Ethernet devices work now. :-(

I booted with both "irqpoll" and with "acpi=off irqpoll" and the results
were the same.

Without any of these options, the kernel boots (like with 2.6.18.x), but
it stays there saying that the secondary channel is downgraded due to
the lack of 80-pin cable and the drive that *has* an 80-pin cable starts
showing "hde: lost interrupt" some times and, after, say, 5 minutes, it
still has not completed the boot. :-(

> Ok I have a guess here - what does 2.6.19-rc6-mm2 do ? I've been
> working on fixing up the VIA IRQ routing bugs as it happens. full
> dmesg of the work/fail cases and an lspci -vxxx would be useful so I
> can see how the hardware thinks it is configured.

Ok, it's quite late at night here and I will upload the dmesg of the
2.6.19-rc6-mm2 kernel (together with lspci -vxxx) to
http://www.ime.usp.br/~rbrito/promise/

I will post the behaviour of other kernels as soon as I wake up and you
wish. BTW, should I disable ACPI compilation entirely or is "acpi=off"
sufficient in further tests? I can do whatever you tell me to...

Oh, one thing that is possibly worth bringing up to you is that I have
this "nobody cared" problem for some time now (I think that it goes back
to several kernel revisions---say, dating back from the 2.6.10 era?).

I don't know if git has anything imported from such earlier kernels, but
I can bisect/binary search whatever is convenient.

One thing that I will try to see if I can get my hands on is on a
80-ribbon cable for this drive, just to see if there are any changes in
behaviour (is it worth me trying to find one?).


Thank you very much, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
