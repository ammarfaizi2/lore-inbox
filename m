Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSEXUZu>; Fri, 24 May 2002 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSEXUZt>; Fri, 24 May 2002 16:25:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26634 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314957AbSEXUZt>; Fri, 24 May 2002 16:25:49 -0400
Date: Fri, 24 May 2002 13:25:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] change of ->bd_op->open() semantics
In-Reply-To: <Pine.GSO.4.21.0205241603270.9792-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0205241323240.11918-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Alexander Viro wrote:
>
> 	It has an additional benefit of killing the array of default
> queues on the same pass - a thing we will need to do sooner or later
> anyway.

I'd like to see this, because we want to make the "find the right queue" a
much more expensive operation (no longer some fairly simple mapping from
major number - a more dynamic and general "register this queue for minors
xxxx-yyyy of major zzz").

Doing it just once at open() time allows for that to happen without any
performance downside.

		Linus

