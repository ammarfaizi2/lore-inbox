Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273080AbSISVNB>; Thu, 19 Sep 2002 17:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273175AbSISVNB>; Thu, 19 Sep 2002 17:13:01 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:28891 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S273080AbSISVNA>; Thu, 19 Sep 2002 17:13:00 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Michael Duane" <Mike.Duane@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CDCether.c
Date: Fri, 20 Sep 2002 07:11:45 +1000
User-Agent: KMail/1.4.5
References: <4C568C6A13479744AA1EA3E97EEEB32328EE9A@schumi.digeo.com>
In-Reply-To: <4C568C6A13479744AA1EA3E97EEEB32328EE9A@schumi.digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209200711.45276.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 20 Sep 2002 01:22, Michael Duane wrote:
> No, this is quite different. It appears to be a function of packet
> size. ping -s <size> <host> will generate packet loss up to 100
> percent with any size of (86+(64*n)).  All other values work fine.
> tcpdump on the linux side sees multiple packet retries with
> correct back-off timeing, but the network side never sees the
> packet. Now for the odd part - any network activity on another
> session to the same box will free the "wedged" packet and the
> network will recieve the last packet sent in the linux retry
> sequence.
Ahh, maybe a missing zero length packet problem.  I'll take another look.

Brad


- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ij2RW6pHgIdAuOMRAmgqAJwPPipMhYxO2QQ0L1VB6yXJtbX8GQCdGpvw
mWRRiqjOTJUmYWsXLyghSgo=
=LRBZ
-----END PGP SIGNATURE-----

