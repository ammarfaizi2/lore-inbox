Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135424AbRAHR7Z>; Mon, 8 Jan 2001 12:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135538AbRAHR7C>; Mon, 8 Jan 2001 12:59:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131876AbRAHR6t>; Mon, 8 Jan 2001 12:58:49 -0500
Date: Mon, 8 Jan 2001 09:58:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Wayne Whitney <whitney@math.berkeley.edu>, linux-kernel@vger.kernel.org,
        "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.21.0101081514180.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101080951140.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Rik van Riel wrote:

> On Sun, 7 Jan 2001, Wayne Whitney wrote:
> 
> > Well, here is a workload that performs worse on 2.4.0 than on 2.2.19pre,
> 
> > The typical machine is a dual Intel box with 512MB RAM and 512MB swap.
> 
> How does 2.4 perform when you add an extra GB of swap ?
> 
> 2.4 keeps dirty pages in the swap cache, so you will need
> more swap to run the same programs...
> 
> Linus: is this something we want to keep or should we give
> the user the option to run in a mode where swap space is
> freed when we swap in something non-shared ?

I'd prefer just documenting it and keeping it. I'd hate to have two fairly
different modes of behaviour. It's always been the suggested "twice the
amount of RAM", although there's historically been the "Linux doesn't
really need that much" that we just killed with 2.4.x.

If you have 512MB or RAM, you can probably afford another 40GB or so of
harddisk. They are disgustingly cheap these days.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
