Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSHSOTh>; Mon, 19 Aug 2002 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318921AbSHSOTh>; Mon, 19 Aug 2002 10:19:37 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:13514 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318920AbSHSOTg> convert rfc822-to-8bit; Mon, 19 Aug 2002 10:19:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Marco Colombo <marco@esi.it>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: Mon, 19 Aug 2002 16:22:39 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208191248130.26653-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.44.0208191248130.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208191622.39957.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 1. You create a problem for in kernel users of random numbers.
> > 2. You forgo the benefit of randomness by concurrent access to
> > /dev/urandom 3. You will not benefit from hardware random number
> > generators as easily.
>
> You lost me. The kernel of course has "client" access to the internal
> pool. And since the userspace reads from /dev/random, it benefits

The kernel users of random numbers may be unable to block.
Thus the kernel has to have a PRNG anyway.
You may as well export it.

> from HRNG just the same way it does now. Point 2 is somewhat obscure
> to me. The kernel has only one observer to deal with, in theory.

In theory. In practice what goes out through eg. the network is
most important. Additional accesses to a PRNG bitstream unknown
outside make it harder to predict the bitstream.

	Regards
		Oliver

