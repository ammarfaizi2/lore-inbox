Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269130AbRGaAoU>; Mon, 30 Jul 2001 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269128AbRGaAoL>; Mon, 30 Jul 2001 20:44:11 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:52664 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269129AbRGaAn4>; Mon, 30 Jul 2001 20:43:56 -0400
Date: Mon, 30 Jul 2001 20:44:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107310044.f6V0i1s04417@devserv.devel.redhat.com>
To: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
Subject: Re: LANCE ethernet chip - ~24 drivers
In-Reply-To: <mailman.996536700.4319.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.996536700.4319.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> ./drivers/net/sunlance.c                        NCR92c990
>         `-> Father of declance.c as I think

It handles 79c90, but also includes support for ledma,
lebuffer, and Lance-fixed-with-PAL. Hardly a target for merge.

> ./drivers/net/sunhme.c                          none mentioned
>         `-> *some* cards seem to be compatible?!

Nope, not even close. Make it 23 Lance drivers.

> ./drivers/net/sunqu.c                           "looks like LANCE"

QE is a quad of some Lance derivatives, plus a bus interface
for DMA which is not compatible with ledma. It is sufficiently
unusual for Solaris to have separate drivers for le and qe.

> ./drivers/net/sun3lance.c                       none mentioned,
>					 but adopted from sunlance.c

Yes, they are basically the same. Dunno why sun3 people split it.

>  However - having
> more than 20 drivers for one kind of device sucks a lot.

Not really, as long as they are maintained.

> I think, it will be a 2.5.x thing to
> re-unify them again (at lease, write a central implementation
> for the chip and let bus specific drivers use it). Just the
> same words are to be said for the Zilog8530 serial chip.

Large number of them is going to die fromm bitrot naturally,
so I do not see a major problem. For instance, sunle is going
to disappear in 5..10 years, as old machines break down.

-- Pete
