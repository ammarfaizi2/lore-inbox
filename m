Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316170AbSEOA3D>; Tue, 14 May 2002 20:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316171AbSEOA3C>; Tue, 14 May 2002 20:29:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8976 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316170AbSEOA3C>; Tue, 14 May 2002 20:29:02 -0400
Date: Tue, 14 May 2002 17:28:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Diego Calleja <DiegoCG@teleline.es>, Andi Kleen <ak@muc.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_ISA
In-Reply-To: <20020513123731.B34@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44.0205141725430.22739-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2002, Pavel Machek wrote:
>
> outb to 0x80, and watch it go to ISA. Not all ports < 0x80 are mainboard.

True and false. 0x0-0xff is specced for motherboard stuff, and you'r enot
supposed to use them for add-in cards.

Anyway, add-in ISA cards are _supposed_ to all be in the 0x100-0x3ff IO
port range. Anything else might be routed to the MB or over PCI.

But yes, motherboards generally do negative decoding for ISA, so anything
that isn't claimed by anything else will just be sent out to the ISA bus.

In particular, PC's aren't really standardized, they are mostly a big heap
of "existing practice".

		Linus

