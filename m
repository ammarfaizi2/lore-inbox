Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQKMXfj>; Mon, 13 Nov 2000 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKMXf3>; Mon, 13 Nov 2000 18:35:29 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:57349 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129177AbQKMXfO>; Mon, 13 Nov 2000 18:35:14 -0500
Date: Mon, 13 Nov 2000 23:04:19 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Hinds <dhinds@valinux.com>, <torvalds@transmeta.com>,
        <tytso@valinux.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A106F81.FB5BE7F1@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0011132254320.29233-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Jeff Garzik wrote:

> It's purposefully not on Ted's critical list, the official line is "use
> pcmcia_cs external package" if you need i82365 or tcic instead of yenta
> AFAIK.  However... fixing things and being able to support all pcmcia
> and cardbus adapters would be wonderful.
>
> drivers/pcmcia/Config.in:
> > #tristate 'PCMCIA/CardBus support' CONFIG_PCMCIA
> > #if [ "$CONFIG_PCMCIA" != "n" ]; then
> > #   if [ "$CONFIG_PCI" != "n" ]; then
> > #      bool '  CardBus support' CONFIG_CARDBUS
> > #   fi
> > #   bool '  i82365 compatible bridge support' CONFIG_I82365
> > #   bool '  Databook TCIC host bridge support' CONFIG_TCIC
> > #fi

Ok, well the patch I've just submitted _ought_ to fix stuff, and certainly
works with my own socket drivers for an embedded board I'm working on.

I have an i82365 eval board kicking around somewhere. I'll see if I can
dig it out tomorrow and verify that it now works, and then perhaps we can
consider re-enabling the config options.

I may add code to handle non-CardBus PCI->PCMCIA i82365 devices again
while I'm at it - because I disapprove of having to specify
"i365_base=0xc800 cs_irq=17" for a PCI card.

-- 
dwmw2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
