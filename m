Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVA2WEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVA2WEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVA2WEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:04:37 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:12587 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261572AbVA2WEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:04:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ev6iKBszElBUJbQDWY9yvV4B0n29zA19lxfhulg+waaWyPWUQSwkWKxgE05n1ywgDUHrfWkeKC8IQe2a8iMRmOFYow5XcvIKy02SeTXZ0H0lAm7MLPXX9en2ZMQFy03/3xGUO1QnkhooRYJuNirIrRR21XULLSw3o75DiLzZrT0=
Message-ID: <1295c7b005012914042f936bcf@mail.gmail.com>
Date: Sat, 29 Jan 2005 14:04:33 -0800
From: Mike Cumings <mcumings@gmail.com>
Reply-To: Mike Cumings <mcumings@gmail.com>
To: Mike Cumings <mcumings@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yenta CardBus IRQ storm disabling interrupt
In-Reply-To: <1295c7b0050129125720854f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1295c7b005012912423352cd9d@mail.gmail.com>
	 <20050129205345.A14428@flint.arm.linux.org.uk>
	 <1295c7b0050129125720854f18@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

I doubt that this issue is specifically related to the card being
used.  I just recalled the fact that the IRQ probing done by the
yenta_socket driver code has run into the IRQ storm at
boot time as well, without any cards in the slots.

Another piece of info for the pile.

Mike


On Sat, 29 Jan 2005 12:57:56 -0800, Mike Cumings <mcumings@gmail.com> wrote:
> Hi Russell,
> 
> This is a different card (NetGear WG511U) than the USB card that
> was discussed in the previous thread.  I haven't tried a 2.4.x kernel
> yet, but that was on my list of things to do. :)  Unfortunately, this is
> the only machine I've got which has CardBus so I'd have a hard time
> attempting to reproduce on another machine.
> 
> Mike
> 
> 
> On Sat, 29 Jan 2005 20:53:45 +0000, Russell King
> <rmk+lkml@arm.linux.org.uk> wrote:
> > On Sat, Jan 29, 2005 at 12:42:17PM -0800, Mike Cumings wrote:
> > > In my Googling, I encountered a thread on January 10th of this year entitled
> > > "yenta_socket rapid fires interrupts" (between Dick Hollenbeck, Linus,
> > > and others)
> >
> > Out of interest, is it the same cardbus card you're inserting into
> > the socket as the problem mentioned above?
> >
> > I think what is suspected is that the Cardbus card is holding its
> > interrupt output active.  This normally shares the same interrupt
> > as the yenta socket status change interrupt, and, since we're
> > listening for interrupts from the card, it causes this problem.
> >
> > A thought: can you reproduce this problem with 2.4?  Has this cardbus
> > card been used with other Linux kernels?  On other machines?
> >
> > I suspect what you'll find is that any Linux kernel on any machine
> > with this card will exhibit this problem - which would prove my
> > theory.
> >
> > --
> > Russell King
> >  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> >  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
> >                  2.6 Serial core
> >
> 
> 
> --
> Mike Cumings
> 


-- 
Mike Cumings
