Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132023AbQKKBKt>; Fri, 10 Nov 2000 20:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132259AbQKKBKk>; Fri, 10 Nov 2000 20:10:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132165AbQKKBK1>; Fri, 10 Nov 2000 20:10:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 10 Nov 2000 17:10:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui698$c2q$1@cesium.transmeta.com>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu> <20001110192751.A2766@munchkin.spectacle-pond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001110192751.A2766@munchkin.spectacle-pond.org>
By author:    Michael Meissner <meissner@spectacle-pond.org>
In newsgroup: linux.dev.kernel
> 
> Generally with ABIs you don't want to mess with it (otherwise you can't be
> guaranteed that a library built by somebody else will be compatible with your
> code, without all sorts of bits in the e_flags field).  It allows multiple
> compilers to be provided that all interoperate (as long as they follow the same
> spec).
> 
> Don't get me wrong -- in my 25 years of compiler hacking, I've never seen an
> ABI that I was completely happy with, including ABI's that I designed myself.
> ABIs by their nature are a compromise.  That particular ABI was short sighted
> in that it wants only 32-bit alignment for doubles, instead of 64-bit alignment
> for instance, and also doesn't align the stack to higher alignment boundaries.
> 

We can mess with the ABI, but it requires a wholescale rev of the
entire system.  We have had such revs before -- each major rev of libc
is one -- but they are incredibly painful.  However, if we find
ourselves in a situation where there are enough reasons to introduce
libc.so.7 then perhaps looking at some revs to the ABI might be in
order -- passing arguments in registers and aligning the stack to 64
bits probably would be the main items.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
