Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLOAv6>; Thu, 14 Dec 2000 19:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOAvi>; Thu, 14 Dec 2000 19:51:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23817 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129524AbQLOAv2>; Thu, 14 Dec 2000 19:51:28 -0500
Date: Thu, 14 Dec 2000 16:20:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Frost <sfrost@snowman.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
In-Reply-To: <20001214191018.Q26953@ns>
Message-ID: <Pine.LNX.4.10.10012141614310.12772-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Stephen Frost wrote:

> * Linus Torvalds (torvalds@transmeta.com) wrote:
> > 
> > A 100ms delay sounds like some interrupt shut up or similar (and then
> > timer handling makes it limp along).
> 
> 	Hmm, it's happening on all interfaces.

Ok, never mind me then. It's not an interrupt getting masked, the
likelihood of three different interrupts having trouble is basically zero
(it would be even smaller if it wasn't for the fact that they are all the
same typ eof device and are all handled by the same driver - but there
shouldn't be any shared data even so).

>	  No oops or anything in
> the logs/dmesg.  I can check console when I get home, but I doubt there's
> anything of interest.

If dmesg doesn't say anything, then the console will say even less.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
