Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAAU60>; Mon, 1 Jan 2001 15:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRAAU6H>; Mon, 1 Jan 2001 15:58:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16389 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129413AbRAAU57>; Mon, 1 Jan 2001 15:57:59 -0500
Date: Mon, 1 Jan 2001 12:27:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <Pine.LNX.4.10.10101011124160.22396-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10101011222560.22433-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2001, Andre Hedrick wrote:

> On Mon, 1 Jan 2001, Alan Cox wrote:
> 
> > > > as it apparently makes CONFIG_IDEDMA_IVB a complete no-op?
> > > 
> > > Exactly what it is designed to do, Ignore Validity Bits, because the whole
> > > damn messedup the rules between ATA-4 and ATA-6
> > 
> > I think the question is more - so why not lose the ifdef
> > -
> 
> Because there are the exceptions that get it correct based on the level of
> ATA support reported in the IDENTIFY page.

Andre, stop blathering, and answer the question.

The code on both sides of the #ifdef is the same.

WHY IS THE IFDEF THERE?

Don't bleat about standards and ATA-4/5/6. They won't make the code behave
any other way.

Why do you have a config option that doesn't _do_ anything, except restate
the exact same test in two different ways?

Doing the same test in two different ways and making it _look_ like two
different tests is confusing. Your explanation seems to be that "the
standards are confusing, the source code had better be confusing too". And
quite frankly, that is not a very good reason.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
