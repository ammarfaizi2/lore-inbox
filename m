Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145353AbRA2GZZ>; Mon, 29 Jan 2001 01:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145367AbRA2GZG>; Mon, 29 Jan 2001 01:25:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30724 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S145353AbRA2GY7>; Mon, 29 Jan 2001 01:24:59 -0500
Date: Sun, 28 Jan 2001 22:24:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
In-Reply-To: <20010129070810S.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.10.10101282220460.5605-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Robert Siemer wrote:
> > 
> > and see if that changes the behaviour. 
> 
> It doesn't.   A diff from the kernel output is following. Maybe it
> helps...

Actually, this looks like it _did_ fix something - now the kernel no
longer thinks there is a IRQ routing conflict, so it does seem to be
happier.

Also, while you're unhappy that it assigns irq 12 instead of 9, the pirq
table actually says that it's ok, and again the code seems to say that
this was actually what the system was set up for.

Can you re-iterate what the failure mode is, again? Preferable with this
kernel that definitely looks like it at least agrees with what the BIOS
tells it.

Oh, and please do a "lspci -vvvxxx" as root and send me that as well.

Thanks,

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
