Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131256AbRAOUCM>; Mon, 15 Jan 2001 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbRAOUCC>; Mon, 15 Jan 2001 15:02:02 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:48645 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131256AbRAOUBu>;
	Mon, 15 Jan 2001 15:01:50 -0500
Date: Mon, 15 Jan 2001 20:01:56 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Balazic <david.balazic@uni-mb.si>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR type AMD Duron/intel ?
In-Reply-To: <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101151955260.8658-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Linus Torvalds wrote:
> On Mon, 15 Jan 2001, Tobias Ringstrom wrote:
> >
> > Last time I checked this was issued for perfectly known and valid bridges
> > that advertice no IO resources.  Isn't it a bit silly to issue that
> > warning for that case, or am I missing something?
>
> Ehh - so what do they bridge, then?
>
> I'd say that a bridge that doesn't seem to bridge any IO or MEM region,
> yet has stuff behind it, THAT is the silly thing. Thus the "silly"
> warning.

I'm talking about bridges that bridge memory, but not io, which is quite
common.  (AGP bridges)

I do not have my PCI book right now, but there are two registers,
basically io_base and io_limit, and if io_limit == io_base-1, that means
that no io is bridged.

I still think its silly.  ;-)

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
