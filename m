Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKSItS>; Mon, 19 Nov 2001 03:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRKSIs7>; Mon, 19 Nov 2001 03:48:59 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([194.237.142.110]:942 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S275224AbRKSIst>; Mon, 19 Nov 2001 03:48:49 -0500
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Mon, 19 Nov 2001 09:48:01 +0100 (MET)
Message-Id: <200111190848.JAA23707@duna207.danubius>
To: Jamie Lokier <lfs@tantalophile.demon.co.uk>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
In-Reply-To: <20011117175253.A5003@kushida.jlokier.co.uk> (message from Jamie
	Lokier on Sat, 17 Nov 2001 17:52:53 +0000)
Subject: Re: Introducing FUSE: Filesystem in USErspace
In-Reply-To: <200111121128.MAA15119@duna207.danubius> <20011117175253.A5003@kushida.jlokier.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Minimal caching?  I would hope for maximal caching, for when userspace
> is able to say "yes the page you have is still valid".  Preferably
> without a round trip to userspace for every page.

I made some performance tests with FUSE, and the raw throughput is
about 60MBytes/s on a Celeron/360 for both reads and writes.  And yes,
that includes two context switches and a copy_to_user/copy_from_user
pair for each page.

I think that at such speed it's not really such a grave problem if
caching is not done in kernel, and it simplifies things a _lot_.

Miklos


