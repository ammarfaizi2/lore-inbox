Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131522AbQLLTLb>; Tue, 12 Dec 2000 14:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbQLLTLL>; Tue, 12 Dec 2000 14:11:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:42509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131522AbQLLTLF>; Tue, 12 Dec 2000 14:11:05 -0500
Date: Tue, 12 Dec 2000 10:40:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <scole@lanl.gov>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121211182600.11576@spc.esa.lanl.gov>
Message-ID: <Pine.LNX.4.10.10012121031200.2239-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2000, Steven Cole wrote:
> 
> Executive summary: SMP 2.4.0 is 2% faster than SMP 2.2.18.

Note that kernel compilation really isn't a very relevant benchmark,
because percentage differences in this range can be basically just noise:
things like driver version differences that show up, but impact different
machines different ways (maybe one driver is better for certain machines,
and worse on others. Things like that).

The setup you descibe is just too CPU-intensive, with little potential for
truly interesting differences.

> I ran X and KDE 2.0 during the tests to provide a greater though
> reproducable load on the tested kernel.  

You might want to do the same in 32-64MB of RAM. And actually move your
mouse around a bit to keep KDE/X from just being paged out, at which point
it turns un-interesting again. I don't know how to do that repeatably,
though, but one thing I occasionally do is to read my email (which is not
very CPU-intensive, but it does keep the desktop active and also gives me
a feel for interactive behaviour).

At that point the numbers are probably going to show more difference (and
the variation is probably going to be much bigger).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
