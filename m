Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269451AbRGaUAQ>; Tue, 31 Jul 2001 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269452AbRGaUAG>; Tue, 31 Jul 2001 16:00:06 -0400
Received: from netcore.fi ([193.94.160.1]:16900 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S269450AbRGaUAA>;
	Tue, 31 Jul 2001 16:00:00 -0400
Date: Tue, 31 Jul 2001 22:59:39 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Chris Wedgwood <cw@f00f.org>
cc: <kuznet@ms2.inr.ac.ru>, <therapy@endorphin.org>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: missing icmp errors for udp packets
In-Reply-To: <20010801074132.G8228@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107312249230.20772-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001, Chris Wedgwood wrote:
>    --- cheap router thing
>
> "really good ping responder" is a pointless purpose.

bad ping responder == bad PR ;-)

And anyway, who is anyone to judge what the system should be used for?

I want a system to respond to ping without limitations; it's good for
debugging, diagnostics, etc.  If I want, I can just filter the requests
out, or rate-limit the responses.

However, ICMP error messages cannot be effectively filtered; they may
happen due to TTL=0 when forwarding, legit or illegit UDP connection etc.;
only way to effectively limit them is by rate-limiting.  If rate-limiting
with informational and error types are the same, we have an inflexible
situation here.

>     Then kernel must be shipped out without rate-limiting enabled by
>     default, that's problem.
>
> I guess I missed something.  That doesn't seem like a problem to
> me... and if you need to ship with a rate by default, then ship with a
> very-high rate.  I've never managed to respond to more than 60,000
> ICMP packets/second, so I suggest 60,001.

Yes you did.  60,000 responses/sec is effectively no protection at all,
and most people would appeaciate protection for the error messages, which
are crucial to the working of TCP/IP; not so with informational ICMP
messages.

And by the way, rate-limiting ICMP error messages is a MUST item for IPv6.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

