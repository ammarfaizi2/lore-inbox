Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277273AbRJNSsx>; Sun, 14 Oct 2001 14:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277281AbRJNSsn>; Sun, 14 Oct 2001 14:48:43 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:28544 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277273AbRJNSs0>; Sun, 14 Oct 2001 14:48:26 -0400
Message-ID: <3BC9DE09.747F45B2@welho.com>
Date: Sun, 14 Oct 2001 21:48:41 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110141820.WAA06484@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > The assumption is that the peer is implemented the way you expect and
> > that the application doesn't toy with TCP_NODELAY.
> 
> Sorry??
> 
> It is the most important _exactly_ for TCP_NODELAY, which
> generates lots of remnants.

I simply meant that with the application in control of packet size, you
simply can't make a reliable estimate of maximum receive MSS unless our
assumption that only maximum sized segments don't have PSH.

> > Not really. You could do one of two things: either ack every second
> > segment
> 
> I do not worry about this _at_ _all_. See?
> "each other", "each two mss" --- all this is red herring.

Whatever.

> I do understand your problem, which is not related to rcv_mss.

I know.

> When bandwidth in different directions differ more than 20 times,
> stretch ACKs are even preferred. Look into tcplw work, using stretch ACKs
> is even considered as something normal.

I know. It's a difficult tradeoff between saving bandwidth on the return
path, trying to maintain self clocking, and avoiding bursts caused by
ack compression.

> I really commiserate and think that removing "final cut" clause
> will help you.

Yes.

> But sending ACK on buffer drain at least for short
> packets is real demand, which cannot be relaxed.

Why? This one has me stumped.

> "final cut" is also better not to remove actually, but the case
> when it is required is probabilistically marginal.
> 
> Alexey

Regards,

	MikaL
