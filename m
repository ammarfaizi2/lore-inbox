Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277053AbRJDArP>; Wed, 3 Oct 2001 20:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277052AbRJDArE>; Wed, 3 Oct 2001 20:47:04 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:50360 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277047AbRJDAqx>;
	Wed, 3 Oct 2001 20:46:53 -0400
Date: Wed, 3 Oct 2001 20:44:30 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031853220.8633-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031828100.7244-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

> i like this approach very much, and indeed this is not polling in any way.
>
> i'm worried by the dev->quota variable a bit. As visible now in the
> 2.4.10-poll.pat and tulip-NAPI-010910.tar.gz code, it keeps calling the
> ->poll() function until dev->quota is gone. I think it should only keep
> calling the function until the rx ring is fully processed - and it should
> re-enable the receiver afterwards, when exiting net_rx_action.

This would result in an unfairness. Think of one device which receives
packets really fast that it takes most of the CPU capacity just processing
it.

cheers,
jamal


