Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLFBUK>; Tue, 5 Dec 2000 20:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbQLFBUB>; Tue, 5 Dec 2000 20:20:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129655AbQLFBTs>; Tue, 5 Dec 2000 20:19:48 -0500
Date: Tue, 5 Dec 2000 16:48:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012060118580.5125-100000@chaos.thphy.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10012051645080.811-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Kai Germaschewski wrote:

> 
> On Tue, 5 Dec 2000, H. Peter Anvin wrote:
> 
> > If you have had A20M# problems with any kernel -- recent or not --
> > *please* try this patch, against 2.4.0-test12-pre5:
> 
> Just a datapoint: This patch doesn't fix the problem here (Sony
> PCG-Z600NE). Still the spontaneous reboot exactly the moment I expect to
> get my console back from resumeing.

Can you test whether it's the "and 0xfe" or the "or $2" that does it for
you?

Right now we know that the Olivetti M4 has problems with the "or $2". I'd
like to know if this is the same bit #1, or whether it's #0.

[ And I agree with Peter - if somebody knows BIOS programming and how to
  use "int 15" to enter protected mode, then that migth well be the
  easiest solution. The only real reason the linux setup code does it by
  hand is that the original code was written that way - and it was written
  that way because I had never used the BIOS in my life before, _and_ I
  wanted to learn the i386. Both of which were valid reasons back in 1991.
  Neither of which is probably a very good reason ten years later ;]

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
