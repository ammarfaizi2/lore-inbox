Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280902AbRKGSz5>; Wed, 7 Nov 2001 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280906AbRKGSzq>; Wed, 7 Nov 2001 13:55:46 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:52750 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280902AbRKGSzf>;
	Wed, 7 Nov 2001 13:55:35 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111071855.VAA07803@ms2.inr.ac.ru>
Subject: Re: ip_conntrack & timing out of connections
To: david.lang@digitalinsight.COM (David Lang)
Date: Wed, 7 Nov 2001 21:55:20 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111061038160.24952-100000@dlang.diginsite.com> from "David Lang" at Nov 6, 1 10:15:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the tcp dimeout is 60 seconds and the ip_conntrack timeout is 120 seconds.

This is absolutely different case.


> > From: pcg@goof.com
...
> > linux-2.4.13-ac5 (other versions untested) has this peculiar behaviour: If I
> > "killall -STOP thttpd", I, of course, still get connection requests which
> > usually time out:
> >
> > tcp      238      0 217.227.148.85:80       213.76.191.129:3120 CLOSE_WAIT

Blatant lie. Such connections cannot timeout. If they do, kernel really
have fatal bug.


> > Nov  6 02:39:55 doom kernel: ip_conntrack: table full, dropping packet.
> >
> > /proc/net/ip_conntrack has lots of connections like these:
> >
> > tcp      6 430665 ESTABLISHED src=213.76.191.129 dst=217.227.148.85 sport=3881 dport=80 src=217.227.148.85 dst=213.76.191.129 sport=80 dport=388 1 [ASSURED] use=1

It is absolutely right. Established connections must not timeout.

Alexey
