Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbRGZOpt>; Thu, 26 Jul 2001 10:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbRGZOpj>; Thu, 26 Jul 2001 10:45:39 -0400
Received: from [216.21.153.1] ([216.21.153.1]:45834 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S267999AbRGZOp2>;
	Thu, 26 Jul 2001 10:45:28 -0400
Date: Thu, 26 Jul 2001 07:47:47 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: kuznet@ms2.inr.ac.ru
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        net-tools@lina.inka.de, philb@gnu.org
Subject: Re: ifconfig and SIOCSIFADDR
In-Reply-To: <200107251940.XAA12699@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.10.10107260723130.12930-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I used to be all for the OS guessing the correct mask.  Then I started
work for my latest employer and tried to trace down strange errors that
were reported to me as an attack on our system.  What I discovered was
that the last few people to attempt my job had set the IP and let the OS
guess at the mask. The result? Everything had 66.0.0.0 as the mask (and
66.255.255.255 for the broadcast). And not just linux either.. freebsd,
nt 4/windows 2000 and even the cisco catalysts all had the same
default mask set.

Please *don't* guess.  If the admin fails to enter it just spit back an
error or something.  You have no way to know the layout and that gets even
more annoying in these days of isps handing out blocks of 16 and 32. 

	Gerhard


On Wed, 25 Jul 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > Yes. It didn't in 2.0.
> 
> Soooory, it did. This behavior is copied from there. :-)
> 
> 
> 
> > Yes. I liked such logic thirty years ago. That is Unix.
> 
> :-) Seems, thirty years ago there were not only Internet but Unix too.
> 
> BTW I did not hear about any kind of Unix, which forgets
> to set a valid mask on newly selected address.
> 
> ifconfig eth0 193.233.7.65 works nicely everywhere.
> Only on 4.2BSD it creates bad "zero" broadcast.
> 
> Alexey
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

