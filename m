Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270773AbRHTNHn>; Mon, 20 Aug 2001 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270593AbRHTNHe>; Mon, 20 Aug 2001 09:07:34 -0400
Received: from miranda.axis.se ([193.13.178.2]:39562 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S270773AbRHTNHY>;
	Mon, 20 Aug 2001 09:07:24 -0400
Message-ID: <21e701c12979$227eee10$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Johan Adolfsson" <johan.adolfsson@axis.com>
Cc: "Robert Love" <rml@tech9.net>, "Oliver Xymoron" <oxymoron@waste.org>,
        <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy> <3B80E01B.2C61FF8@evision-ventures.com> <21a701c12963$bcb05b60$0a070d0a@axis.se> <3B80EADC.234B39F0@evision-ventures.com>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: Mon, 20 Aug 2001 15:07:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Johan Adolfsson wrote:
> > Where would you get the single seed from in an embedded head
> > less system if you don't have a hardware random generator,
> > no disk and don't seed it from the network interrupts?

Martin Dalecki wrote: 
> The device get's powerd up at a random time for the attacker.

Perhaps true, but for some systems, the time it takes for a certain 
application that need some random data to start is the same at 
each powerup (more or less) so the application might use the 
same session key the first time after each powerup.
(Not that gathering info from network interrupt necessarily 
would improve this case, but it might)

> That's entierly sufficient if you assume that your checksum function
> f(i) hat the property that there is no function g, where we have
> f(i+1)=g(f(i)), where g has a polynomial order over the time domain.
> i is unknown for the attacker.

Can't say I know the details of the functions used in the /dev/[u]random 
functions to say if that assumption is true. But I feel that stiring the
pool using interrupt timing and thus adding the number of unknowns
can't be a bad thing.
Simply relying on the uptime would make it really easy to
predict the f() function wouldn't it?

/Johan


