Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbRFVFBE>; Fri, 22 Jun 2001 01:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRFVFAz>; Fri, 22 Jun 2001 01:00:55 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:31708 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S265333AbRFVFAo>; Fri, 22 Jun 2001 01:00:44 -0400
Date: Fri, 22 Jun 2001 11:19:50 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: Balbir Singh <balbir_soni@yahoo.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <01062117190601.02209@idun>
Message-ID: <Pine.SGI.4.10.10106221043470.3059659-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Oliver Neukum wrote:

> > > In addition, how do you handle shared interrupts ?
> >
> > It is impossible, see my another message.
> 
> Which IMHO makes the concept pretty much useless.
> Interrupt sharing is pretty much the norm today. And there is no evidence for 
> this to change in the near future. Rather the opposite seems to happen in 
> fact.
> 
> Which devices were you thinking of, that need a hardware IRQ and no kernel 
> driver ?

An ISA cards, mostly for data acquisition - edge triggered interrupts,
no ack required immediately from interrupt handler. Rest of hardware
handling can be deferred to user space.
IRQ sharing is possible there in spite of some hardware hacking.

Yes, it is very limited range of hardware today but it exists
and /dev/irq kernel module provide one of generic mechanisms for user
space driver implementation.

