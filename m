Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131121AbRAGMUZ>; Sun, 7 Jan 2001 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRAGMUP>; Sun, 7 Jan 2001 07:20:15 -0500
Received: from james.kalifornia.com ([208.179.0.2]:44139 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131121AbRAGMUD>; Sun, 7 Jan 2001 07:20:03 -0500
Date: Sun, 7 Jan 2001 04:19:59 -0800 (PST)
From: David Ford <david@linux.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010108011308.A2575@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.10.10101070416250.4173-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Chris Wedgwood wrote:
> Bind knows about multiple virtual interfaces; but we can also have
> multiple addresses on a single interface and have no virtual
> interfaces at all.
> 
> I doubt bind knows about this nor handles it.
> 
> <pause>
> 
> OK, I'm a liar -- bind does handle this. Cool.
> 
> Jan  8 01:09:12 tapu named[599]: listening on [127.0.0.1].53 (lo)
> Jan  8 01:09:12 tapu named[599]: listening on [10.0.0.1].53 (lo)
> Jan  8 01:09:12 tapu named[599]: listening on [x.x.x.x].53 (x0)
> Jan  8 01:09:12 tapu named[599]: Forwarding source address is [0.0.0.0].1032
> 
> This is good news, because it means there is a precedent for multiple
> addresses on a single interface so we can kill the <ifname>:<n>
> syntax in favor of the above which is cleaner of more accurately
> represents what is happening.

I've been using the new form for a long long time now and I assure you, BIND
hasn't had any problems with it for a long long time. :)

BIND as most all programs, should not care what the interface is or how it
is laid out.  It binds to an address and port and shouldn't care otherwise.

Would I really put you in a quandry if I told you I had multiple different
media interfaces all with the same IP and BIND happily answered on all of
them? ;)

-d


--
---NOTICE--- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
