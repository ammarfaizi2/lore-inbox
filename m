Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135536AbRDXK4T>; Tue, 24 Apr 2001 06:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135537AbRDXK4K>; Tue, 24 Apr 2001 06:56:10 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:16923 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S135536AbRDXKz7>; Tue, 24 Apr 2001 06:55:59 -0400
Date: Tue, 24 Apr 2001 13:55:38 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Joseph Carter <knghtbrd@debian.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fully-OT] Dual Athlon support in kernel
Message-ID: <20010424135537.C3682@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.33.0104240115050.21785-100000@asdf.capslock.lan> <3AE52C2C.C6B2B472@mountain.net> <20010424131857.F3529@niksula.cs.hut.fi> <20010424033922.A5878@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424033922.A5878@debian.org>; from knghtbrd@debian.org on Tue, Apr 24, 2001 at 03:39:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 03:39:22AM -0700, you [Joseph Carter] claimed:
> 
> A warning about agcc, I've discovered that it does not always compile code
> quite the way you expect it.  This is unsurprising given it's based on
> pgcc which is known to change alignments on you in ways that sometimes
> break things subtly.

While people always bash pgcc, I've had pretty good experiences with it.
Mostly everything I've compiled with it has worked quite well - even a
2.0.34 kernel (which I compiled accidentally with pgcc) ran with no problems
for long times. Sometimes pgcc does give internal errors with highest
optimizations, though. 

Don't take me wrong: I'm not advocating using pgcc for any serious
production systems (nevermind any kernel stuff), but perhaps it shouldn't be
completely discarded for perfomance hungry stuff (where a miscompile won't
cause third World War). It does gain as much as 30% in some cases over older
gcc - I'm not sure how good the newest gcc's are, but oldish pgcc does beat
gcc-2.96 on stuff I tried. (Didn't gcc get a new IA32 backend some time ago?
How good is that?)

> I do not know if agcc actually can produce code which simply does not work
> as is reported with pgcc (I suspect the alignment differences account for
> many of those cases), but I recall reading in the past few days that agcc
> is not supported for compiling the kernel.

Any pgcc variant is quite bad idea for kernel stuff. There are known
problems (I think), and it doesn't even gain that much since kernel is
pretty much hand optimized anyway.

But if the instruction scheduler in the compiler knows about K7, I imagine
that could gain something. Perhaps it could use the preload instructions etc
as well? The again, I'm no kernel NOR compiler guru.
 
> It also fails to properly compile certain other programs, notably anything
> that includes asm functions.  As a result, my own experience suggests you
> consider agcc in the same class as gcc 3.0 at the moment - experimental.
> Hopefully the k7 optimizations that work well will find their way into a
> nice athlon subarch options in standard gcc and agcc won't be necessary.

Hope so. Unfortunately AMD doesn't seem to be doing all that much compiler
work (Intel has a whole compiler suite for Win, and did the beginnings of
pgcc, if I've not mistaken.)


-- v --

v@iki.fi
