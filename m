Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbRFUM4l>; Thu, 21 Jun 2001 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbRFUM4b>; Thu, 21 Jun 2001 08:56:31 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:12490 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S264943AbRFUM4Z>; Thu, 21 Jun 2001 08:56:25 -0400
Date: Thu, 21 Jun 2001 19:45:51 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <E15D2GI-00019a-00@the-village.bc.nu>
Message-ID: <Pine.SGI.4.10.10106211905030.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Alan Cox wrote:

> > it would be a good idea to add user level interrupt
> > support ? I have a framework for it, but it still
> 
> The problem is that the IRQ has to be cleared in kernel space, because otherwise
> you may deadlock. 

It depends on device type. Good designed ones does not raises a new
interrupt until an explicit acknowledge by I/O from [user space] driver
will be received.

Access to device's ports and IRQs from user space is subject
of system admistration policy so direct access to a dangerous devices
should not be allowed.

Lastly an IRQ kernel module can disable_irq() from interrupt handler
and enable it again only on explicit acknowledge from user.

