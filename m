Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSBSBuP>; Mon, 18 Feb 2002 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSBSBuG>; Mon, 18 Feb 2002 20:50:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289277AbSBSBtu>; Mon, 18 Feb 2002 20:49:50 -0500
Date: Mon, 18 Feb 2002 17:48:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.33L.0202182221040.1930-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0202181746090.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2002, Rik van Riel wrote:
>
> We'll need protection from the swapout code.

Absolutely NOT.

If the swapout code unshares or shares the PMD, that's a major bug.

The swapout code doesn't need to know one way or the other, because the
swapout code never actually touches the pmd itself, it just follows the
pointers - it doesn't ever need to worry about the pmd counts at all.

		Linus

