Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264953AbRFUN10>; Thu, 21 Jun 2001 09:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbRFUN1H>; Thu, 21 Jun 2001 09:27:07 -0400
Received: from cpe126.netz6.cablesurf.de ([195.206.156.126]:17282 "EHLO
	idun.neukum.org") by vger.kernel.org with ESMTP id <S264953AbRFUN0z>;
	Thu, 21 Jun 2001 09:26:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Is it useful to support user level drivers
Date: Thu, 21 Jun 2001 15:24:39 +0200
X-Mailer: KMail [version 1.2]
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.10.10106211905030.3193032-100000@Sky.inp.nsk.su>
In-Reply-To: <Pine.SGI.4.10.10106211905030.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Message-Id: <01062115243900.01881@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is that the IRQ has to be cleared in kernel space, because
> > otherwise you may deadlock.
>
> It depends on device type. Good designed ones does not raises a new
> interrupt until an explicit acknowledge by I/O from [user space] driver
> will be received.
>
> Access to device's ports and IRQs from user space is subject
> of system admistration policy so direct access to a dangerous devices
> should not be allowed.
>
> Lastly an IRQ kernel module can disable_irq() from interrupt handler
> and enable it again only on explicit acknowledge from user.

Unless you need that interrupt to be enabled to deliver the signal or let 
userspace reenable the interrupt.

In addition, how do you handle shared interrupts ?

	Regards
		Oliver
