Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293031AbSCEACn>; Mon, 4 Mar 2002 19:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSCEACb>; Mon, 4 Mar 2002 19:02:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293021AbSCEACW>; Mon, 4 Mar 2002 19:02:22 -0500
Subject: Re: Q:Shared IRQ
To: dstroupe@keyed-upsoftware.com (David Stroupe)
Date: Tue, 5 Mar 2002 00:17:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8407C0.1000503@keyed-upsoftware.com> from "David Stroupe" at Mar 04, 2002 05:48:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i2e4-0001At-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I get not only my interrupts, but also the interrupts of the shared 
> device, namely the network card.  Is this what I should expect?  If I 

Yes.

> get a notification for the network card, why is the dev_id the same as 
> what I passed?  If I didn't have an interrupt pending bit on my 
> hardware, how would I distinguish between the interrupts?

If you don't have an interrupt pending bit you are probably completely screwed.
PCI assumes you can tell if you caused the interrupt or you can service events
even if not needed (which basically comes down to the same thing).

Only your driver knows if you are a possible IRQ cause, its up to you to
handle it
