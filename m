Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbTGDJ1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbTGDJ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:27:54 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:1287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265920AbTGDJ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:27:11 -0400
Date: Fri, 4 Jul 2003 10:41:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Andrew Morton <akpm@osdl.org>,
       Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030704104134.B9740@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jari Ruusu <jari.ruusu@pp.inet.fi>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl,
	akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl> <3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi> <3F046A30.6080509@nortelnetworks.com> <3F05300E.AA26A021@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F05300E.AA26A021@pp.inet.fi>; from jari.ruusu@pp.inet.fi on Fri, Jul 04, 2003 at 10:43:10AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 10:43:10AM +0300, Jari Ruusu wrote:
> Changing transfer function prototype may be a tiny speed improvement for one
> implementation that happens to use unoptimal API, but at same time be tiny
> speed degration to other implementations that use more saner APIs. I am
> unhappy with that change, because I happen to maintain four such transfers
> that would be subject to tiny speed degration.

You've so far only made ubacked claims in this thread.  Show the
numbers and tell us why your implementation is faster and show the
numbers and explain why this change should make your module slower.

If you can't benefit from using the page frame + offset the worst
thing you'd have to do is doing the kmap yourself instead of loop.c
doing it.  And no, kmap doesn't get magically slower when called from
a different module.

