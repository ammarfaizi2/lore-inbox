Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSAPSF0>; Wed, 16 Jan 2002 13:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAPSFR>; Wed, 16 Jan 2002 13:05:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42500 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284305AbSAPSFJ>; Wed, 16 Jan 2002 13:05:09 -0500
Date: Wed, 16 Jan 2002 10:04:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116185814.I22791@athlon.random>
Message-ID: <Pine.LNX.4.33.0201161002390.2112-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
>
> This patch in short will move pagetables into highmem, obviously it
> breaks all the archs out there.

Hmm.. Looks ok, although I miss the "obviously". Archs have their own page
table allocator functions, so by allocating lowmem (and most non-x86 won't
care) the change _should_ have zero impact on them simply because they
don't need to unmap. No?

		Linus

