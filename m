Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKMXSb>; Mon, 13 Nov 2000 18:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQKMXSW>; Mon, 13 Nov 2000 18:18:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17426 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129047AbQKMXSG>;
	Mon, 13 Nov 2000 18:18:06 -0500
Message-ID: <3A106F81.FB5BE7F1@mandrakesoft.com>
Date: Mon, 13 Nov 2000 17:47:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: David Hinds <dhinds@valinux.com>, torvalds@transmeta.com,
        tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <Pine.LNX.4.30.0011132222070.28525-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Mon, 13 Nov 2000, David Hinds wrote:
> 
> > The i82365 and tcic drivers in the 2.4 tree have not been converted to
> > use the thread stuff; as far as I know, the yenta driver is the only
> > socket driver that works at all in 2.4.
> >
> > On Mon, Nov 13, 2000 at 09:52:30PM +0000, David Woodhouse wrote:
> > > OK. I take it you support my proposed change?
> > > Can you review this patch for i82365.c?
> >
> > It looks reasonable and straighforward to me.
> 
> Cool. Linus, please could you apply this patch. If the fact that i82365
> and tcic are broken in 2.4 isn't on Ted's critical list, then I think it
> probably ought to have been - and this should fix it.

It's purposefully not on Ted's critical list, the official line is "use
pcmcia_cs external package" if you need i82365 or tcic instead of yenta
AFAIK.  However... fixing things and being able to support all pcmcia
and cardbus adapters would be wonderful.

drivers/pcmcia/Config.in:
> #tristate 'PCMCIA/CardBus support' CONFIG_PCMCIA
> #if [ "$CONFIG_PCMCIA" != "n" ]; then
> #   if [ "$CONFIG_PCI" != "n" ]; then
> #      bool '  CardBus support' CONFIG_CARDBUS
> #   fi
> #   bool '  i82365 compatible bridge support' CONFIG_I82365
> #   bool '  Databook TCIC host bridge support' CONFIG_TCIC
> #fi



-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
