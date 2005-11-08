Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVKHGck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVKHGck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVKHGck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:32:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29962 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030187AbVKHGci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:32:38 -0500
Date: Tue, 8 Nov 2005 07:18:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Miles Bader <miles@gnu.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Message-ID: <20051108061819.GA11460@alpha.home.local>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be> <20051031211422.GC4367@waste.org> <20051101065327.GP22601@alpha.home.local> <Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be> <20051101085740.GR22601@alpha.home.local> <buowtjjsmgq.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buowtjjsmgq.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 03:05:57PM +0900, Miles Bader wrote:
> Willy Tarreau <willy@w.ods.org> writes:
> > I don't know if x86_64 is LP64 or LLP64 on Linux, but at least my alpha
> > and sparc64 are LP64, so is another PPC64 I use for code validation.
> > LPC64 is the recommended model for easier 32 to 64 portability (where
> > ints are 32 ; long, longlong, ptrs are 64).
> 
> Are there _any_ (widespread) platforms except Windows that use LLP64?

I don't think so, ask google for LLP64 and click the second link (blogs),
you will like it :-)

Basically, they choose LLP64 because they have declared some structures
as LONG (eg: in bitmaps) instead of making them int32 ! I didn't know
that they were losers to the point of not understanding a typedef !
This may explain why they stopped supporting alpha long ago...

> LP64 seems to be by far the most common in the unix world.

it seems so, but I'd be interested in counter-examples too.

> -miles
> -- 
> "1971 pickup truck; will trade for guns"

Willy

