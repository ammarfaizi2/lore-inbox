Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTISHJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbTISHJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:09:27 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:23747 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261380AbTISHJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:09:24 -0400
Date: Fri, 19 Sep 2003 09:09:17 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063954659.617.31.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309190902480.17132-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Sep 2003, Benjamin Herrenschmidt wrote:

>
> > It also makes me think of the 63 MHz clock speed, as you did indicate it
> > should be 67 MHz. Knowing that the memory clock speed is used in the display
> > fifo calculation, I wonder if it was tweaked to get things right.
> >
> > Enough speculation, I'll post a patch asap, but I have currently no Linux
> > machines around me. Expect a patch tomorrow.
>
> Don't change the clock speeds for now. I'll do some more tests with
> 67Mhz clocks to make sure it's ok, but since I won't be able to do
> that until wedenesday next week, let's get a known working version
> in asap.

Indeed, we cannot change clocks because of results of only one machine. It
just makes me wonder. Perhaps the best thing to do is to check this with
ATi too.

> Also, I just got confirmation that the 101 PowerBook with
> an LT-Pro works fine as well.

Nice!

> The only additional "fix" I have here is some bts making the sleep
> code slightly more robust (by preventing things like blank from
> touching chip registers when the chip is asleep if the blank timer
> triggers after sleep callback, same goes for cursor etc...)
> There is no emergency getting that in. It would be nice if that
> fixes could make it to 2.4.23 final, but I can send a separate patch
> later.

Okay.... By the way, how shall we get the powermanagement code to work on
x86? As far as I saw that register backlight procedure exists only on PowerPC.


Greetings,

Daniël Mantione

