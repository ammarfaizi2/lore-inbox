Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDTTac>; Sat, 20 Apr 2002 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDTTab>; Sat, 20 Apr 2002 15:30:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312316AbSDTTa3>; Sat, 20 Apr 2002 15:30:29 -0400
Date: Sat, 20 Apr 2002 12:30:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420201205.M1291@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0204201221120.11732-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> 
> Well, my preferred patch is still this one :)

But this one simply will not get applied, for all the reasons already
outlined. It _will_ cause the same problems that it tries to fix, just at
some later time.

Besides, I seriously doubt it is any faster than what is there already.

Time it, and notice how:

 - fninit takes about 200 cycles
 - fxrstor takes about 215 cycles

and your added 16*(pxor/xorps) likely takes at least 8 cycles.

In short, your "fast" code isn't actually any faster than doing it right.

		Linus

