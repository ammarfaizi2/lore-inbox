Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135478AbRAWCCX>; Mon, 22 Jan 2001 21:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135625AbRAWCCO>; Mon, 22 Jan 2001 21:02:14 -0500
Received: from vitelus.com ([64.81.36.147]:21512 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S135478AbRAWCCE> convert rfc822-to-8bit;
	Mon, 22 Jan 2001 21:02:04 -0500
Date: Mon, 22 Jan 2001 18:01:58 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010122180158.B24670@vitelus.com>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14KsZI-0006IU-00@halfway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14KsZI-0006IU-00@halfway>; from rusty@linuxcare.com.au on Tue, Jan 23, 2001 at 12:48:20PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:48:20PM +1100, Rusty Russell wrote:
> So I reimplimented 2.2-style masquerading on top of the new NAT
> infrastructure: ideally this would mean that it could use the new
> helpers, but there were some minor technical problems, and it was
> never tested.
> 
> Those who berated Aaron for not wanting to upgrade: he is the Debian
> maintainer for crashme, gtk-theme-switch, koules, pngcrush, and
> xdaliclock.  By wasting his time making him convert a perfectly
> working system, you are taking away time from those projects.  I'd
> rather see him spend time on Cool Stuff(TM) which benefits all of us.

Thank you for your support, but it seems clear that they were right.
I changed the kernel settings to have pure netfilter configuration,
read the NAT-HOWTO, and followed its instructions. I reccomend that any
others still trying to use the 2.[02].x style interfaces do the same.

netfilter seems not only much cleaner than ipchains or ipfwadm, but also
much more powerful. I read into the HOWTO a bit and was very impressed
by the capabilities. In particular, it's nice to have port forwarding
integrated with NAT rather than as a seperate chunk of kernel code using
different userspace tools.

I hope that netfilter will last longer than the last two packet
filtering/mangling/masquerading mechanisms. :)

P.S.: The only thing I did not get working successfully was IRC DCC. I
sent a bug report to the maintainer of the patch from the
patch-o-matic, but did not recieve an immediate response, so I'll
include it below in case anyone else has any ideas.
_______________________________________________________________________________

>From aaronl@vitelus.com Sun Jan 21 00:44:17 2001
Date: Sun, 21 Jan 2001 00:44:17 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: laforge@gnumonks.org
Subject: irc-conntrack-nat doesn't work for me

I applied irc-conntrack-nat from iptables-1.2's patch-o-matic onto a
Linux 2.4.0 kernel with XFS support. I tried several different IRC
clients on the sending end (which was of course behind this NAT box)
and different IRC servers (all on port 6667). On the recieving end, I
would always get:

-:- DCC GET request from aaronl_[aaronl@vitelus.com
          [64.81.36.147:33989]] 150 bytes /* That's the NAT box's IP */
-:- DCC Unable to create connection: Connection refused

Any idea what's wrong? I have irc-conntrack-nat compiled into the
kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
