Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265005AbRFUPVD>; Thu, 21 Jun 2001 11:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265006AbRFUPUx>; Thu, 21 Jun 2001 11:20:53 -0400
Received: from cpe126.netz6.cablesurf.de ([195.206.156.126]:19075 "EHLO
	idun.neukum.org") by vger.kernel.org with ESMTP id <S265005AbRFUPUs>;
	Thu, 21 Jun 2001 11:20:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Subject: Re: Is it useful to support user level drivers
Date: Thu, 21 Jun 2001 17:19:06 +0200
X-Mailer: KMail [version 1.2]
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.10.10106212130280.3193032-100000@Sky.inp.nsk.su>
In-Reply-To: <Pine.SGI.4.10.10106212130280.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Message-Id: <01062117190601.02209@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21. June 2001 16:46, Dmitry A. Fedorov wrote:
> On Thu, 21 Jun 2001, Oliver Neukum wrote:
> > > Lastly an IRQ kernel module can disable_irq() from interrupt handler
> > > and enable it again only on explicit acknowledge from user.
> >
> > Unless you need that interrupt to be enabled to deliver the signal or let
>
> Need not. Signal and other event delivery mechanisms has nothing
> common with disable/enable_irq().

And how do you ensure that no interrupt is lost ?
In fact you now are likely to have a race condition reading device status or 
the like.

> > userspace reenable the interrupt.
>
> "user acknowledge" is mean that.
>
> > In addition, how do you handle shared interrupts ?
>
> It is impossible, see my another message.

Which IMHO makes the concept pretty much useless.
Interrupt sharing is pretty much the norm today. And there is no evidence for 
this to change in the near future. Rather the opposite seems to happen in 
fact.

Which devices were you thinking of, that need a hardware IRQ and no kernel 
driver ?

	Regards
		Oliver
