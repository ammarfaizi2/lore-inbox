Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTAUBfC>; Mon, 20 Jan 2003 20:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTAUBfB>; Mon, 20 Jan 2003 20:35:01 -0500
Received: from mail1.cornernet.com ([207.195.212.6]:27880 "EHLO
	mail1.cornernet.com") by vger.kernel.org with ESMTP
	id <S266944AbTAUBfA>; Mon, 20 Jan 2003 20:35:00 -0500
Date: Mon, 20 Jan 2003 19:43:54 -0600 (CST)
From: Coax <coax@cornernet.com>
To: "David D. Hagood" <wowbagger@sktc.net>
cc: AnonimoVeneziano <voloterreno@tin.it>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
In-Reply-To: <3E2C9623.60709@sktc.net>
Message-ID: <Pine.LNX.4.30.0301201943290.4362-100000@shell1.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have seen this problem with a motherboard with a bad PCI slot, too.
happened with a pci network card in the slot...

Chad Schwartz
CornerNet System Administration

On Mon, 20 Jan 2003, David D. Hagood wrote:

> AnonimoVeneziano wrote:
> > What does it mean this message?
> >
> > Of what problem is the signal?
>
> It is most likely a hardware problem.
>
> When a device signals an interrupt, it asserts its interrupt pin. When
> the CPU asks the interrupt controller what device generated the
> interrupt, the interrupt controller tells the CPU.
>
> But if the interrupt line "goes away" before the CPU fetches the vector,
> then the interrupt controller doesn't "know" what IRQ caused the
> interrupt. So the interrupt controller sends an IRQ #7 to the CPU, along
> with setting a bit in the interrupt controller's status register that
> says in effect "this isn't really an IRQ 7, but I have no idea what it
> was. Sorry."
>
> If you have ISA cards in your system, remove them from the system and
> re-insert them (with the power off, of course) - they may have developed
> some oxidization on the card edge connector. You can also try scrubbing
> the card edge with some plain paper (a US dollar bill works even better,
> but you might not have access to dead presidents in Italy.)
>
> Ditto with PCI cards - remove them, polish the connector, then re-insert
> them.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

