Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSI0Oic>; Fri, 27 Sep 2002 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbSI0Oic>; Fri, 27 Sep 2002 10:38:32 -0400
Received: from web21406.mail.yahoo.com ([216.136.232.76]:36106 "HELO
	web21406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261707AbSI0Oib>; Fri, 27 Sep 2002 10:38:31 -0400
Message-ID: <20020927144332.74044.qmail@web21406.mail.yahoo.com>
Date: Fri, 27 Sep 2002 07:43:32 -0700 (PDT)
From: Venkatesh Rao <rpranesh@yahoo.com>
Subject: Re: Problems with tcp_retransmit_skb - Please omit the previous incomplete mail
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209270353.HAA19674@sex.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Even i thought of this scenario, but what puzzles me,
other sockets running in the system are able to
receive data (ie) send TCP ACKs through the same
driver.

This is the only socket which *sends* relatively huge
amount of data, other sockets running when this
happens are able to receive data (ie) send TCP ACK's.


Retransmit fails only when there is high activity on
the network cable (caused by flood pinging). When
there is no flood pinging(or high network activity),
apps work for days together.

Can this still be a network driver problem?

Thanks & Cheers,
Venkatesh



--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > When conditions fails, the value of wmem_alloc is
> ~ 
> > around 56K-154K,
> 
> ... which means that you already have 64-154K
> transmitted
> and all this buffers still not left the host. So,
> further
> retransmission is pointless.
> 
> 
> > Each time it tries to retransmit this if condition
> > always fail
> ...
> > Any hints in  helping me debug this issue will be
> > appreciated.
> 
> Most likely, this means that driver leaks memory.
> 
> Alexey


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
