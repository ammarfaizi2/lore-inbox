Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTISG6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTISG6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:58:16 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:12498 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261373AbTISG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:58:15 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0309182225430.6680-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309182225430.6680-100000@deadlock.et.tudelft.nl>
Message-Id: <1063954659.617.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 08:57:39 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It also makes me think of the 63 MHz clock speed, as you did indicate it
> should be 67 MHz. Knowing that the memory clock speed is used in the display
> fifo calculation, I wonder if it was tweaked to get things right.
> 
> Enough speculation, I'll post a patch asap, but I have currently no Linux
> machines around me. Expect a patch tomorrow.

Don't change the clock speeds for now. I'll do some more tests with
67Mhz clocks to make sure it's ok, but since I won't be able to do
that until wedenesday next week, let's get a known working version
in asap. Also, I just got confirmation that the 101 PowerBook with
an LT-Pro works fine as well.

The only additional "fix" I have here is some bts making the sleep
code slightly more robust (by preventing things like blank from
touching chip registers when the chip is asleep if the blank timer
triggers after sleep callback, same goes for cursor etc...)
There is no emergency getting that in. It would be nice if that
fixes could make it to 2.4.23 final, but I can send a separate patch
later.

Ben.


