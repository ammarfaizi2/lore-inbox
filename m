Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTBRP60>; Tue, 18 Feb 2003 10:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbTBRP6Z>; Tue, 18 Feb 2003 10:58:25 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:46726 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267871AbTBRP6Y>;
	Tue, 18 Feb 2003 10:58:24 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200302181606.TAA03838@sex.inr.ac.ru>
Subject: Re: sendmsg and IP_PKTINFO
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Tue, 18 Feb 2003 19:06:34 +0300 (MSK)
Cc: davem@redhat.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <15954.4693.893707.471216@notabene.cse.unsw.edu.au> from "Neil Brown" at Feb 18, 3 10:00:37 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So yes, the current behaviour seems to match part of the
> documentation.

Good. :-)

>  "the outgoing packet will be sent over the interface specified in
>  ipi_ifindex if that interface has a valid route to the packets
>  destination.  Otherwise normal rouing rules apply".
> 
> I further argue that this is not only more rational, but is actually
> more useful (which is a more telling point).

Either you rely on routing tables, or you do not, which is used
when routing tables are still not set up, or setup ambiguously,
or use of them just do not make sense which happens for multicasts/
limited/broadcasts/link local addresses. It is the thing which ifi_ifindex
does.

I do no see how it is possible to classify a middle way as "rational".
Well, and frankly speaking I do not see how it could be useful.

Alexey

