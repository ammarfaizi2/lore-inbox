Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRIATUy>; Sat, 1 Sep 2001 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271307AbRIATUo>; Sat, 1 Sep 2001 15:20:44 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:52484 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271283AbRIATUd>;
	Sat, 1 Sep 2001 15:20:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109011920.XAA20031@ms2.inr.ac.ru>
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Sat, 1 Sep 2001 23:20:09 +0400 (MSK DST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010901195532.B2714@thefinal.cern.ch> from "Jamie Lokier" at Sep 1, 1 07:55:32 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> binary trace with "tcpdump -n -w" is attached,

I am afraid you forgot it.


> I am wondering if not sending so many duplicate ACKs would help the
> broken sender (I know, that is against RFC793 but hey if it works...).

If it works, hack kernel not to send dupacks. What is the problem? :-)
Yes, on such links fast retransmit is not useful in any case.

Actually, you can make something from your side: if rtt is so high,
most likely this means excessive queueing. You can fight this
advertising smaller window (f.e. adding option "window N" to route).
If intepacket gap is 5sec and rtt 23, you can divide window by 23/5
and rtt should drop to some more reasonable number. "Theoretical"
bandwidth will reduce, but practical will grow.


> For the sake of a Linux test, I shall try proxying this stream via a
> Linux 2.4.2 box I have on the net, and see if it is an improvement.

Yes, it is intersting.

Alexey
