Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268235AbRGWOTc>; Mon, 23 Jul 2001 10:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbRGWOTW>; Mon, 23 Jul 2001 10:19:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32570 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268235AbRGWOTJ>; Mon, 23 Jul 2001 10:19:09 -0400
Date: Mon, 23 Jul 2001 16:18:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010723161804.C822@athlon.random>
In-Reply-To: <20010723013416.B23517@athlon.random> <Pine.LNX.4.33.0107231113150.27373-100000@chaos.tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107231113150.27373-100000@chaos.tp1.ruhr-uni-bochum.de>; from kai@tp1.ruhr-uni-bochum.de on Mon, Jul 23, 2001 at 11:25:23AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 11:25:23AM +0200, Kai Germaschewski wrote:
> Hmmh, wait a second. I take it that means calling netif_rx not from 
> hard-irq context, but e.g. from bh is a bug? (Even if the only consequence 

No it isn't a bug either, calling it from irq or bh is perfectly fine
w.r.t. softirq latency. If you post it from softirq ksoftirqd will
handle the overflow event exactly like in net_rx_action.

Andrea
