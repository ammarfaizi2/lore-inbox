Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULHMHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULHMHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbULHMHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:07:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57042 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261193AbULHMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:07:37 -0500
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices do not work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Krammel <florian_kr@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1102452729.7531.29.camel@orange-bud>
References: <1102333735.5095.4.camel@orange-bud>
	 <1102339694.13485.26.camel@localhost.localdomain>
	 <1102450409.7531.10.camel@orange-bud> <1102452729.7531.29.camel@orange-bud>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102503828.23635.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 11:03:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-07 at 20:52, Florian Krammel wrote:
> > > Ditto, and this is quite possibly the root cause. That suggests the BIOS
> > > handover code for EHCI is insufficient for some cases (and it appears to
> > > be looking at the code quickly - it should register IRQ 5 before doing a
> > > handover which it does but it probably needs to just ack and mask IRQ 5
> > > during the handover. It could be another device breaking IRQ5 however)
> > > 
> > > 
> > > What occurs if you build a kernel with EHCI disabled, ditto what occurs
> > > if you boot with init=/bin/sh and then load ohci before ehci ?
> 
> I don't tested this because "irqpoll" solve my problem. Are you
> interested in the result? I can try it.

I would be very interested to know if this makes a difference yes

