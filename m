Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbSLEVEm>; Thu, 5 Dec 2002 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbSLEVEY>; Thu, 5 Dec 2002 16:04:24 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:22984 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267428AbSLEVAO>; Thu, 5 Dec 2002 16:00:14 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: root@chaos.analogic.com, Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [OT] ipv4: how to choose src ip?
Date: Fri, 6 Dec 2002 07:56:31 +1100
User-Agent: KMail/1.4.5
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212060756.31469.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 6 Dec 2002 07:37, Richard B. Johnson wrote:
> > I'm not interested in rewriting the source address with netfilter based
> > on destination and/or service;  What I'm looking for is rather a way to
> > initiate two connections to the same destination host using the two
> > different source IP addresses.
>
> The simple answer is that if you need a specific IP address
> associated with a "multi-honed" host, that has only one interface,
> then something is broken. And you get to keep the pieces.

There are some reasons why you might like to use a specific address on a 
machine that is multi-homed, although normally the logic in the kernel works 
fine. I won't try to explain it in detail at this stage, but link-local is a 
personal favourite.

Probably all you want is to use the SO_BINDTODEVICE socket option.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9771/W6pHgIdAuOMRAjZGAKC8anD6rum/sEuYJRX2XZNEtEOG2gCdFBUq
SOK8RUP9Ub2hX1HGej9vxhU=
=KHOl
-----END PGP SIGNATURE-----

