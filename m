Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265976AbSKDHIW>; Mon, 4 Nov 2002 02:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265980AbSKDHIG>; Mon, 4 Nov 2002 02:08:06 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:14502 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265976AbSKDHH5> convert rfc822-to-8bit; Mon, 4 Nov 2002 02:07:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Tom Rini <trini@kernel.crashing.org>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: CONFIG_TINY
Date: Mon, 4 Nov 2002 02:13:48 +0000
User-Agent: KMail/1.4.3
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
References: <20021031011002.GB28191@opus.bloom.county> <Pine.LNX.3.96.1021031205920.22444F-100000@gatekeeper.tmr.com> <20021101141559.GD815@opus.bloom.county>
In-Reply-To: <20021101141559.GD815@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012059.32304.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 14:15, Tom Rini wrote:

> > Sure, and unrolling loops can cause cache misses and be slower than that
> > jmp back in a loop. The point is this is a string, the people who think
> > they're able to hand diddle the options can change it. And more to the
> > point anyone who can't find a string in a makefile shouldn't be second
> > guessing the compiler anyway.
>
> Yes, so why can't those who still need a few more kB after trying some
> of the other options go and find '-O2' and replace it with '-Os' ?

Because the point of CONFIG_TINY is to make the kernel smaller and this is 
something that makes the kernel smaller?  (In fact telling the compiler 
"optimize for size" is one of the most OBVIOUS things to do?)

I've used -Os.  I've compiled dozens and dozens of packages with -Os.  It has 
always saved at least a few bytes, I have yet to see it make something 
larger.  And in the benchmarks I've done, the smaller code actually runs 
slightly faster.  More of it fits in cache, you know.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?



