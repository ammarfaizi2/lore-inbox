Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRIASIr>; Sat, 1 Sep 2001 14:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270999AbRIASIi>; Sat, 1 Sep 2001 14:08:38 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:36612 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S270958AbRIASI1>;
	Sat, 1 Sep 2001 14:08:27 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109011808.WAA19782@ms2.inr.ac.ru>
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Sat, 1 Sep 2001 22:08:24 +0400 (MSK DST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch> from "Jamie Lokier" at Sep 1, 1 06:17:29 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The interesting thing is that there isn't any evidence of packet loss.

Why did you disable bith sacks and timestamps? Exactly to get
maximal damage from long delay link?


> Is there some /proc/sys setting to fix this, a kernel patch, or is it
> perhaps fixed in a newer kernel already?

No patches to block send required ACKs exist of course. :-)

All the problem is at sender, it mispredicts rtt.
What OS is sender? If it is linux too, try to use default configuration
not playing with /proc/sys/net/tcp_*, especially with timestamps
and sacks and the situation should rectify.

Also, please, send full (binary!) tcpdump from SYN and to FIN.
Andi says right thing, but I am still puzzled why rtt is miscalculated
it should be estimated correctly.

Well, and if sender is not linux... no ideas.

Alexey
