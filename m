Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313265AbSDTXYC>; Sat, 20 Apr 2002 19:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDTXYB>; Sat, 20 Apr 2002 19:24:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38411 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313265AbSDTXYA>; Sat, 20 Apr 2002 19:24:00 -0400
Date: Sat, 20 Apr 2002 16:23:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420232818.N1291@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204201619170.3643-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
>
> pxor+xorps is definitely faster than fxrestor on athlon-mp.

Andrea, that's not the _comparison_.

The "fxrestor" replaces the "fninit" too, so you have to take that into
account.

> fxrestor on athlon-mp 1600, on cold cache (the "default fpu state" will
> be cold most of the time, it's only ever used at the first math fault of
> a task):

Except it's _never_ cold-cache the way it's coded now. In fact it's always
hot-cache - which are exactly the numbers I posted.

> Go ahead and try yourself setting the #if to 0 or 1. The benchmark is
> very accurate.

It may have high precision, but since it's testing something that has
nothing to do with the problem at hand, it's basically 100% useless.

		Linus

