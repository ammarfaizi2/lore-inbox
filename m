Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRACTgX>; Wed, 3 Jan 2001 14:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbRACTgN>; Wed, 3 Jan 2001 14:36:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130072AbRACTgD>; Wed, 3 Jan 2001 14:36:03 -0500
Date: Wed, 3 Jan 2001 11:05:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <Pine.LNX.4.21.0101031653100.1403-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101031103440.7739-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Rik van Riel wrote:
> 
> I rediffed this trivial patch by Andrea (that went
> into 2.2.19-pre5) which adds 2nd chance replacement
> to the dentry cache, this should make our dcache
> behave a little bit better than the current FIFO.

Looks ok, but I'd be happier if the

	dentry->d_flags |= DCACHE_REFERENCED;

line would be inside the dcache lock (ie just move it up a line). 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
