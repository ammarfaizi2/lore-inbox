Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPCEP>; Wed, 15 Nov 2000 21:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKPCEE>; Wed, 15 Nov 2000 21:04:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18440 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbQKPCDz>; Wed, 15 Nov 2000 21:03:55 -0500
Date: Wed, 15 Nov 2000 17:33:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aeb@veritas.com>
cc: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>, emoenke@gwdg.de,
        eric@andante.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <Pine.LNX.4.10.10011151709380.3216-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10011151730550.880-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2000, Linus Torvalds wrote:
> 
> Does this patch fix it for you?
> 
> Warning: TOTALLY UNTESTED!!! Please test carefully.

Ok, I tested it with the broken image.

It looks like "readdir()" is ok now (but not really knowing what the right
output should be I cannot guarantee that). HOWEVER, doing an "ls -l" on
some of the files gets ENOENT, implying that "lookup()" still has some
problems with the image.

I suspect the code to handle split entries in isofs_find_entry() has some
simple bug, but I'm too lazy to check it out right now. Anybody else
willing to finish this one off?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
