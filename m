Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRLRCxS>; Mon, 17 Dec 2001 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282859AbRLRCxI>; Mon, 17 Dec 2001 21:53:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27912 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281488AbRLRCxB>; Mon, 17 Dec 2001 21:53:01 -0500
To: linux-kernel@vger.kernel.org
From: Daniel Quinlan <quinlan@transmeta.com>
Subject: Re: [PATCH] Endianness-aware mkcramfs
Date: 17 Dec 2001 18:52:30 -0800
Organization: Transmeta Corporation
Message-ID: <6ylmg1tf2p.fsf@sodium.transmeta.com>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch>
X-Trace: palladium.transmeta.com 1008643950 1309 127.0.0.1 (18 Dec 2001 02:52:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 18 Dec 2001 02:52:30 GMT
Original-Sender: quinlan@transmeta.com
X-Newsreader: Gnus v5.7/Emacs 20.4
Cache-Post-Path: palladium.transmeta.com!unknown@sodium.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Marmier <daniel.marmier@lightning.ch> writes:

> Here you are, against kernel 2.4.16. The patch is not as clean as one
> would like it to be, but we use it and it works well for us.
> 
> Basically it adds a "-b" (byteorder option) which can take four parameters:
>    -bb	creates a big-endian cramfs,
>    -bl	creates a little-endian cramfs,
>    -bh	creates a cramfs with the same endianness as the host,
>    -br	creates a cramfs with the reverse endianness as the host,
> where "host" refers to the machine running the mkcramfs program.
> 
> As told above, it could be cleaner, but I don't know of a nice method of
> accessing byteorder dependent data through structures.
> 
> Have a nice day,

Hmm... I've been on vacation, so I'm joining the discussion a little
late here, but as hpa and others have said, cramfs is defined to be
little-endian -- we do not want two different versions of the
filesystem.

Send me a patch so big-endian systems byte-swap metadata (and the
equivalent for the mkcramfs/cramfsck programs) and I'd be happy to
help you clean it up and get it into the kernel.

 Dan

