Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268603AbRGYSEL>; Wed, 25 Jul 2001 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268604AbRGYSEB>; Wed, 25 Jul 2001 14:04:01 -0400
Received: from [213.82.86.194] ([213.82.86.194]:23050 "EHLO fatamorgana.net")
	by vger.kernel.org with ESMTP id <S268603AbRGYSDy>;
	Wed, 25 Jul 2001 14:03:54 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roberto Arcomano <berto@fatamorgana.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch suggestion for proxy arp on shaper interface
Date: Wed, 25 Jul 2001 20:06:34 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200107242231.CAA00481@mops.inr.ac.ru>
In-Reply-To: <200107242231.CAA00481@mops.inr.ac.ru>
MIME-Version: 1.0
Message-Id: <01072520063402.01036@berto.casa.it>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Il 00:31, mercoledì 25 luglio 2001, Alexey Kuznetsov ha scritto:
> Hello!
>
> > Recently I have had a problem with Linux proxy arp feature (using with
> > shaper
>
> You must not enable proxy arp, when routing is asymmetric or configure
> it manually. Shaper device is one of cases, when proxy arp cannot work
> correctly.
>
> Alexey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hello,
First thank you for your answer. I must enable proxy arp cause I need it with 
shaper interface. During configuration in user mode I noticed that kernel 
sees shaper device instead of using its device attached (in fact I received 
from a lan machine a "IP conflit"): I think that it is more correct to use 
the device attached to shaper, for 2 reasons:
1-) shaper is not a "real" interface (I mean directly connected to a wire or 
wireless physical interface), while proxy arp sends "ARP REPLY" using 
physical devices only.

2-) Proxy arp would become more flexible, also using proxy arp interface: 
proxy arp is a great thing, particulary with complex wireless networks. Like 
all good thinks I think that we have to keep it under kernel to keep simplify 
sysadmin life!

Anyway, there are some applications that need shaper and proxy arp (for 
example using a traffic manager behind a firewall).

As I said in my first message, I tested it with 2.4.6 and it "appears" (I 
tested it in a very little net) to work well (but I think performance aren't 
so well...).

Thank you for your help.
Best regards
Roberto Arcomano
