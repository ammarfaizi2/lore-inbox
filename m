Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRDPXnt>; Mon, 16 Apr 2001 19:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDPXnj>; Mon, 16 Apr 2001 19:43:39 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:27368 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132414AbRDPXnb>; Mon, 16 Apr 2001 19:43:31 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200104162342.AAA01383@mauve.demon.co.uk>
Subject: Re: IP Acounting Idea for 2.5
To: linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2001 00:42:52 +0100 (BST)
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446D9FF@berkeley.gci.com> from "Leif Sawyer" at Apr 16, 2001 02:35:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Manfred Bartz responded to
> > Russell King <rmk@arm.linux.org.uk> who writes:
<snip>
> > You just illustrated my point.  While there is a reset capability
> > people will use it and accounting/logging programs will get wrong
> > data.  Resetable counters might be a minor convenience when debugging
> > but the price is unreliable programs and the loss of the ability of
> > several programs to use the same counters.
> 
> You of course, are commenting from the fact that your applications are
> stupid, written poorly, and cannot handle 'wrapped' data.  Take MRTG
<snip>
> Similarly, if my InPackets are at 102345 at one read, and 2345 the next
> read,
> and I know that my counter is 32 bits, then I know i've wrapped and can do

I think the point being made is that if InPackets are at 102345 at one read,
and 2345 the next, and you know it's a 32 bit counter, it's completely
unreliable to assume that you have in fact recieved 4294867295
packets, if the counter can be zeroed.
You can say nothing other than at least 2345 packets, at most 
2345+n*2^32 have been got since you last checked.
