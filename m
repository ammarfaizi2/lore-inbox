Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319495AbSIMBxV>; Thu, 12 Sep 2002 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319511AbSIMBvT>; Thu, 12 Sep 2002 21:51:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43203 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319488AbSIMBuu>;
	Thu, 12 Sep 2002 21:50:50 -0400
Date: Thu, 12 Sep 2002 18:47:19 -0700 (PDT)
Message-Id: <20020912.184719.126771896.davem@redhat.com>
To: pasky@pasky.ji.cz
Cc: zdzichu@irc.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020912150609.GE21715@pasky.ji.cz>
References: <20020819043941.GA31158@irc.pl>
	<20020818.213719.117777405.davem@redhat.com>
	<20020912150609.GE21715@pasky.ji.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Petr Baudis <pasky@pasky.ji.cz>
   Date: Thu, 12 Sep 2002 17:06:09 +0200

   - IPsec for IPv6

Without ipv4 part and stackable destination cache, we do
not see any way in which they could make this cleanly and
properly and thus make patch acceptable.

All of IPSEC is a routing and data representation problem, so unless
routing code of ipv6 was rewritten by USAGI folks to support
representation of security database (this means addition of
protocol/source_port/dest_port route demux selectors and also
RTA_IPSEC routing attribute for actual ESP/AH rule insertion), the
patch is not likely to be accepted.

So if done right, ipv4 would be just as easy to support and thusly
I make parallel ipv6/ipv4 support a requirement for any ipsec
implementation that goes into the tree.

I also want ipsec to be implemented using rtnetlink which doubly means
that it must be solved at the routing level.

This also means that PF_KEY socket implementation is merely translator
into rtnetlink messages and nothing more and that "ip" tool would be
used for manual keying.

The fact that I have so much to say about the implementation details
of ipsec might suggest something if you're paying attention :-) And
that's where I'll leave the topic of ipsec at the moment.

Otherwise I look forward to seeing their other patches, but I find it
strange that it takes them on the order months to submit things, which
I have maintained from the start.  They work on this stuff nearly full
time and it is very important to them, they also have high claims as
to it's readiness, so what could possibly take so long?
