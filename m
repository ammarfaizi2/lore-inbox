Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRIATBx>; Sat, 1 Sep 2001 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRIATBn>; Sat, 1 Sep 2001 15:01:43 -0400
Received: from tantalophile.demon.co.uk ([193.237.65.219]:11648 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S271112AbRIATBZ>; Sat, 1 Sep 2001 15:01:25 -0400
Date: Sat, 1 Sep 2001 19:55:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Excessive TCP retransmits over lossless, high latency link
Message-ID: <20010901195532.B2714@thefinal.cern.ch>
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch> <200109011808.WAA19782@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109011808.WAA19782@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Sep 01, 2001 at 10:08:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > The interesting thing is that there isn't any evidence of packet loss.
> 
> Why did you disable bith sacks and timestamps? Exactly to get
> maximal damage from long delay link?
>
> What OS is sender? If it is linux too, try to use default configuration
> not playing with /proc/sys/net/tcp_*, especially with timestamps
> and sacks and the situation should rectify.

Unfortunately the other machine is my ISP, who I do not control.  I have
no idea what the sender OS is, but it's obviously not a standard recent
Linux judging from the lack of SACK.

> Also, please, send full (binary!) tcpdump from SYN and to FIN.

I have send myself a 30k mail and produced a trace of receiving it.  A
binary trace with "tcpdump -n -w" is attached, and a text version of it
with "tcpdump -r pktlog2" is appended below.

> Well, and if sender is not linux... no ideas.

I am wondering if not sending so many duplicate ACKs would help the
broken sender (I know, that is against RFC793 but hey if it works...).

For the sake of a Linux test, I shall try proxying this stream via a
Linux 2.4.2 box I have on the net, and see if it is an improvement.

-- Jamie
