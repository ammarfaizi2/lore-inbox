Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135985AbRAJVsc>; Wed, 10 Jan 2001 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbRAJVsZ>; Wed, 10 Jan 2001 16:48:25 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:19114 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S136755AbRAJVsN>; Wed, 10 Jan 2001 16:48:13 -0500
Date: Wed, 10 Jan 2001 21:55:09 +0000
From: Philip Armstrong <phil@kantaka.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christian.Engstler@gmx.net, evaner@bigfoot.com, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
Message-ID: <20010110215509.A2846@kantaka.co.uk>
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <200101072352.PAA28348@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101072352.PAA28348@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 03:52:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 03:52:41PM -0800, Linus Torvalds wrote:
> In article <20010107122800.A636@kantaka.co.uk>,
> Philip Armstrong  <phil@kantaka.co.uk> wrote:
> >In supplement to Evan Thompson's emails with the subject "Additional
> >info. for PCI VIA IDE crazyness. Please read." I've noticed the
> >following message with recent 2.4.0 test + release kernels:
> >
> >IRQ routing conflict in pirq table! Try 'pci=autoirq'
> 
> But the machine still works fine, ie the SCSI driver and the network
> driver still seem happy?

extra information. I just spent an hour trying to convince this board
to play nice with an ISA PNP AWE64 sound card.

This caused the BIOS to throw its hands in the air and give up
entirely as far as I can see. IRQ conflicts all over the place. Linux
runs; windows manages to start, but can't talk to the scsi card at
all.

And isa-pnp.o in 2.4.0 resulted in a never ending stream of messages
to the console, hanging the machine, like so:

isapnp: unexpected or unknown tag type 0xff ...

Taking the AWE64 out solved the issues. It could be a bust card of
course, but I think the BIOS is stuffed.

cheers,

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
