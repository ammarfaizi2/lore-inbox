Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277055AbRJDAtY>; Wed, 3 Oct 2001 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277054AbRJDAtQ>; Wed, 3 Oct 2001 20:49:16 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:52152 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277056AbRJDAtF>;
	Wed, 3 Oct 2001 20:49:05 -0400
Date: Wed, 3 Oct 2001 20:46:45 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031840580.7244-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.30.0110032044411.8016@shell.cyberus.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> On Wed, 3 Oct 2001, jamal wrote:
>
> (and the only thing i pointed out was that the patch as-is did not limit
> the amount of polling done.)

you mean in the softirq or the one line in the driver?

>
> > > *if* you can make polling a success in ~90% of the time we enter
> > > tulip_poll() under non-specific server load (ie. not routing), then i
> > > think you have really good metrics.
> >
> > we can make it 100% successful; i mentioned that we only do work, if
> > there is work to be done.
>
> can you really make it 100% successful for rx? Ie. do you only ever call
> the ->poll() function if there is a new packet waiting? How do you know
> with a 100% probability that someone on the network just sent a new packet
> waiting? (without receiving an interrupt to begin with that is.)
>

Take a look at what i think is the NAPI state machine pending a nod
from Alexey and Robert:
http://www.cyberus.ca/~hadi/NAPI-SM.ps.gz

cheers,
jamal


