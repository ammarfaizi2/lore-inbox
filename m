Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJCI5D>; Thu, 3 Oct 2002 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbSJCI5D>; Thu, 3 Oct 2002 04:57:03 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:15845 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263207AbSJCI5C>; Thu, 3 Oct 2002 04:57:02 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "David S. Miller" <davem@redhat.com>, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Allow Both IPv6 and IPv4 Sockets on the Same Port Number (IPV6_V6ONLY Support)
Date: Thu, 3 Oct 2002 18:55:11 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
References: <20021003.121350.119660876.yoshfuji@linux-ipv6.org> <20021003.012904.75241727.davem@redhat.com>
In-Reply-To: <20021003.012904.75241727.davem@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210031855.12148.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 3 Oct 2002 18:29, David S. Miller wrote:
> For example, this IPV6_V6ONLY socket option is flawed.  What we
> really need is a generic socket option which says "my family only"
>
> There is nothing ipv6 specific about such a socket attribute.
>
> So please, create instead "SO_ONEFAMILY" or similar generic
> socket option.
>
> I still need to review the rest of the patch for functional
> correctness.  This is probably the most complex area of the
> socket identity code in TCP/UDP :-)
While you are grotting aroung in this area - a thought / request.

When we get IPv4 link-local autoconf addressing in widespread use, there is a 
problem on multi-homed machines.

Assume B has two network interfaces (B1 and B2) on seperate IPv4 links (net1 
and net2). Host A is on net1 and Host C is on net2. Assume that both Host A 
and Host C have the same autoconf address. So IP address is not enough 
information for Host B to use to determine which interface to use in order to 
contact Host A (instead of Host C).

If host B has socket binding on IP+port+local interface, it all works out.

Is this going to work?

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9nAXwW6pHgIdAuOMRAscOAKC/TyYdV1IOjDMlYZghhLf1mYtrKgCfbDEh
VJAdPL1Rc1Z2uM6RCIgSYOE=
=JZGw
-----END PGP SIGNATURE-----

