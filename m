Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131304AbRBWSkv>; Fri, 23 Feb 2001 13:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131688AbRBWSkl>; Fri, 23 Feb 2001 13:40:41 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:27912 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131304AbRBWSk3>;
	Fri, 23 Feb 2001 13:40:29 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102231827.VAA21470@ms2.inr.ac.ru>
Subject: Re: Very high bandwith packet based interface and performance problems
To: raj@cup.hp.COM (Rick Jones)
Date: Fri, 23 Feb 2001 21:27:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A9556A7.D052D8A6@cup.hp.com> from "Rick Jones" at Feb 22, 1 10:15:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Yes its a SHOULD in RFC1122, but in any normal environment pretty much a
> > must and I know of no stack significantly violating it.
> 
> I didn't know there was such a thing as a normal environment :)

Jokes apart, such "normal" environments are rare today.

>From tcpdumps it is clear, that win2000 does not ack each other mss.
It can ack once per window at high load. I have seen the same behaviour
of solaris. freebsd-4.x surely does not ack each second mss
(it is from source code), which is probably bug (at least, it stops
to ack at all as soon as MSG_WAITALL is used. 8))

Acking each second mss is required to do slow start more or less
fastly. As soon as window is full, they are useless, so that win2000
is fully right and, in fact, optimal.

Alexey
