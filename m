Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264989AbRFUO0w>; Thu, 21 Jun 2001 10:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbRFUO0c>; Thu, 21 Jun 2001 10:26:32 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:716 "EHLO inpbox.inp.nsk.su")
	by vger.kernel.org with ESMTP id <S264986AbRFUO0W>;
	Thu, 21 Jun 2001 10:26:22 -0400
Date: Thu, 21 Jun 2001 21:20:54 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <E15D4VG-0001Lw-00@the-village.bc.nu>
Message-ID: <Pine.SGI.4.10.10106212050430.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Alan Cox wrote:

> > Lastly an IRQ kernel module can disable_irq() from interrupt handler
> > and enable it again only on explicit acknowledge from user.
> 
> No. The IRQ might be shared, and you get a slight problem if you just disabled
> an IRQ needed to make progress for user space to handle the IRQ

Disabling the IRQ till user acknowledge is an option for particular
device handling.
Yes, IRQ sharing is impossible with it and IRQ module must reject setup
requests with this option and SA_SHIRQ flag together.
However, it is important for rare cases only with "bad" devices
(their interrupt behaviour is really bad!) and IRQ sharing requirement.

