Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271550AbRICR7a>; Mon, 3 Sep 2001 13:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271573AbRICR7W>; Mon, 3 Sep 2001 13:59:22 -0400
Received: from [195.89.159.99] ([195.89.159.99]:57844 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S271550AbRICR7H>; Mon, 3 Sep 2001 13:59:07 -0400
Date: Mon, 3 Sep 2001 18:57:00 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Excessive TCP retransmits over lossless, high latency link
Message-ID: <20010903185700.A12529@thefinal.cern.ch>
In-Reply-To: <20010901210212.A3361@thefinal.cern.ch> <200109031714.VAA24484@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109031714.VAA24484@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Sep 03, 2001 at 09:14:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > Yes, definitely.  Btw, I saw a ping round trip time of 162s just now.
> 
> I do not understand, do you share this link with someone or
> ping over tcp connection?

I was doing ping with the TCP connection going.  When there is no TCP
connection, ping time is 1-1.5 seconds.

> > I saw very few retransmits in a single message download.  SACK appears
> > occasionally.  I don't really understand the local reaction to SACK, or
> > why a SACK option appears in one ACK sent locally and not the following
> > ACK, even though the SACK mentions data that does not arrive between the
> > two locally sent ACKs.
> 
> But I do not see _any_ sacks in your tcpdumps.

Sorry, you are right.  I did see an sack, but not in this trace.

> > The throughput difference was obvious: POP3 negotiation + 30k message +
> > headers took:
> > 
> >         5 min 31 sec       downloading unknown OS   ->  Linux 2.4.7
> >         2 min 15 sec       downloading Linux 2.4.2  ->  Linux 2.4.7
> 
> It is dominated by rtt, one rtt per segment. It is very strange
> that cwnd does not want to open. Maybe, it is worth to tcpdump at proxy.

Do you mean that you want to see the Linux -> Linux connection, with
tcpdumps at both ends?

-- Jamie
