Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbQKRFVO>; Sat, 18 Nov 2000 00:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQKRFUz>; Sat, 18 Nov 2000 00:20:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130870AbQKRFUl>; Sat, 18 Nov 2000 00:20:41 -0500
Date: Fri, 17 Nov 2000 20:50:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4) 
In-Reply-To: <20566.974522003@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10011172049280.1320-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Keith Owens wrote:

> On Fri, 17 Nov 2000 17:21:53 -0800 (PST), 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >There's a test11-pre7 there now, and I'd really ask people to check out
> >the isofs changes because slight worry about those is what held me up from
> >just calling it test11 outright.
> >
> >It's almost guaranteed to be better than what we had before, but anyway..
> >
> >		Linus
> 
> namei.c: In function `isofs_find_entry':
> namei.c:130: warning: passing arg 2 of `get_joliet_filename' from incompatible pointer type
> namei.c:130: warning: passing arg 3 of `get_joliet_filename' from incompatible pointer type

Thanks. The second and third arguments were switched around to match all
the other filename conversion stuff, and because I don't have joliet
enabled I didn't notice this. Just switch them around where the warning
occurs, and you should be golden.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
