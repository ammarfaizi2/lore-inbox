Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbQLMU6C>; Wed, 13 Dec 2000 15:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131858AbQLMU5w>; Wed, 13 Dec 2000 15:57:52 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:33034 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131789AbQLMU5n>;
	Wed, 13 Dec 2000 15:57:43 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012132027.XAA15957@ms2.inr.ac.ru>
Subject: Re: linux ipv6 questions.  bugs?
To: pete@research.NETsol.COM (Pete Toscano)
Date: Wed, 13 Dec 2000 23:27:00 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001213144558.L1139@tesla.admin.cto.netsol.com> from "Pete Toscano" at Dec 13, 0 11:15:12 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 0.  whenever i ping6 the loopback interface (::1/128), all echo requests
> seem to be dropped and i get no echo replies.  is this correct?

Your guess? 8) Of course, it is incorrect. I even have no idea
how it is possible to put system into such sad state.
Though... probably, you forgot to up loopback.


> the destination mac address is set to the linux box's mac address and
> the source mac address is set to 0:0:0:0:0:0.

I think it is consequence of above. When loopback interface is missing,
networking does not work.


> other way around?  this would explain why the openbsd box doesn't
> respond to the linux box's n.s. until it starts looking at all the
> packets in promisc mode, right?

Rather it means that openbsd is buggy, its stack accepts packets
not destined to it. It cannot react to those strange packets, which
you have just described.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
