Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRAPNpO>; Tue, 16 Jan 2001 08:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbRAPNo6>; Tue, 16 Jan 2001 08:44:58 -0500
Received: from comunit.de ([195.21.213.33]:14368 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S129485AbRAPNof>;
	Tue, 16 Jan 2001 08:44:35 -0500
Date: Tue, 16 Jan 2001 14:44:32 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: rtviado <root@iligan.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ip_conntrack: maximum limit of 16368 entries exceeded
In-Reply-To: <Pine.LNX.4.30.0101161444450.24215-100000@bigbird-ipgi.iligan.com>
Message-ID: <Pine.LNX.4.30.0101161442330.14328-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, rtviado wrote:

> I got this in my logs:
>
>  ip_conntrack: maximum limit of 16368 entries exceeded
>
> what does this mean, I know i can change the limits in
> /proc/sys/net/ipv4/ip_conntrack_max, but I want to know what this is for.

This means that iptable is tracking more than 16368 parallel connections.
Either a very busy box or some spoofed flooding.

> P.S. I looked into linux/Documentation but did not find any mention of
> this configrable parameter....

see http://netfilter.kernelnotes.org/ - seems that the in-kernel documents
are not uptodate

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
