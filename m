Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314676AbSDTRjr>; Sat, 20 Apr 2002 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDTRjp>; Sat, 20 Apr 2002 13:39:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27921 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314676AbSDTRjc>; Sat, 20 Apr 2002 13:39:32 -0400
Date: Sat, 20 Apr 2002 10:38:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420192729.I1291@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204201036400.19512-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
>
> Then the thing is different, I expected SSE3 not to mess the xmm layout.
> If you just know SSE3 would break with the xorps the fxrestor way is
> better. Anyways the problems I have about the implementation remains
> (memset and duplicate efforts with ptrace in creating the empty fpu
> state).

Hey, send a clean patch and it will definitely get fixed.. I don't
disagree with that part, although actual numbers are always good to have.

> If they tell you the xmm registers won't change with SSE3 instead I
> still prefer the xorps, that's 3bytes x 8 registers = 24 bytes of
> icachce, compared to throwing away 512bytes/32 = 16 dcache cachelines so
> it should be significantly faster.

Oh, if they promise to not add registers we have an easy time, I agree.

		Linus

