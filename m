Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263282AbSJCMge>; Thu, 3 Oct 2002 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbSJCMge>; Thu, 3 Oct 2002 08:36:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11910 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263282AbSJCMgd>; Thu, 3 Oct 2002 08:36:33 -0400
Date: Thu, 3 Oct 2002 08:42:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: hps@intermeta.de
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sequence of IP fragment packets on the wire
In-Reply-To: <20021003111847.AAA15244@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.3.95.1021003082804.13839B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as far as I can see, Linux sends out fragmented IP packets
> "butt-first":
> (where the first packet is actually the fragmented 2nd part of the
> second packet).
> This confuses at least one firewall appliance.
> 

The sequence-number of an IP Packet, whether or not it's fragmented,
has nothing to do with any order of reception. The "2nd" part of
a fragmented packet may be received at any time, in fact multiple
times. Any so-called Network appliance that assumes that there is
any specific order of packets being received is fundamentally
broken.

Well designed network software can sometimes optimize its buffer
handling if it "knows" that the last packet of a fragment has
been received, but it can't count on any specific order because
there isn't any. Even if you put all your "ducks in a row" on
the wire, once the least-cost route becomes different for different
packets, all bets are off. You might get one packet with satellite-
link latency (seconds) and another with terrestrial latency
(miliseconds).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

