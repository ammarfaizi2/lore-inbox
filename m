Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRBOTeS>; Thu, 15 Feb 2001 14:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbRBOTeJ>; Thu, 15 Feb 2001 14:34:09 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:22532 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129110AbRBOTeC>;
	Thu, 15 Feb 2001 14:34:02 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102151933.WAA20558@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 15 Feb 2001 22:33:23 +0300 (MSK)
Cc: roger@kea.GRace.CRi.NZ, linux-kernel@vger.kernel.org
In-Reply-To: <E14TTRF-0000Ul-00@the-village.bc.nu> from "Alan Cox" at Feb 15, 1 06:47:31 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please cite an exact RFC reference.

No need to cite RFC, this is plain sillogism.

A. Datagram protocols do not work with mtus not allowing to send
   512 byte frames (even DNS).
B. Accoutning, classification, resource reervation does not work on
   fragmented packets.

-> IP suite is not full functional with low MTUs and must be eliminated.


Current setting of min_adv_mss to 536 is actually occasional.
I tested pmtu discovery on local clients using mtu 296 and did not
change the value to less fascist after this. I happened to be not
mistake, I found some fun talking to people, which suffer of superstition
that "mtu 296 is good for..." (latency for example) 8)8)8)


> to put it back together. Our handling of DF on syn frames is also broken
> due to that misassumption, but fortunately only for crazy mtus like 70.

Right observation. It stops to work even earlier: at mtu<128.
It is strict limit. Pardon, discussing marginal cases is useless.
If someone has device with mtu of 128, let him to put it back to the place,
where he found it.

Preventing DoSes requires to block pmtu discovery at 576 or at least 552.

More practical question is mtu=296. There exist old myth that this value
is good for PPP. This is nothing but myth. 14% of overhead.

I would prefer that minimal MTU on internet stayed on 576, which
is already fact.

Alexey
