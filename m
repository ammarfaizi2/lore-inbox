Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRATVdk>; Sat, 20 Jan 2001 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRATVdc>; Sat, 20 Jan 2001 16:33:32 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:49343 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130673AbRATVdC>; Sat, 20 Jan 2001 16:33:02 -0500
Date: Sat, 20 Jan 2001 22:20:57 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201124090.10317-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101202107590.12223-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jan 2001, Linus Torvalds wrote:

> There's no no-no here: you can even create the "struct page"s on demand,
> and create a dummy local zone that contains them that they all point back
> to. It should be trivial - nobody else cares about those pages or that
> zone anyway.

AFAIK as long as that dummy page struct is only used in the page cache,
that should work, but you get new problems as soon as you map the page
also into a user process (grep for CONFIG_DISCONTIGMEM under
include/asm-mips64 to see the needed changes). In the worst case one
might need reverse mapping to get the page back. :)

> That said, nobody has actually done this in practice yet, so there may be
> details to work out, of course. I don't see any fundamental reasons it
> wouldn't easily work, but..

I hope I have soon the time to experiment with this, so I'll now for sure.
I don't see major problems, except I don't know yet, how the performance
will be.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
