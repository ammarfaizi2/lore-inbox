Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQKRSeq>; Sat, 18 Nov 2000 13:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbQKRSeg>; Sat, 18 Nov 2000 13:34:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9483 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130386AbQKRSeT>; Sat, 18 Nov 2000 13:34:19 -0500
Date: Sat, 18 Nov 2000 10:03:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <E13xBcX-0001sY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011181002190.1655-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Alan Cox wrote:

> > Linus Torvalds wrote:
> > > 
> > > I sure as hell hope this isn't an Athlon issue.  Can other people try
> > > the test-program and see if we have a pattern (ie "it happens only on
> > > Athlons", or "Linus is on drugs and it happens for everybody else").
> > 
> > I've tried both variants (fesetenv and inline-asm) with glibc-2.1.3,
> > 2.4.0-test11pre7 and an AMD Thunderbird. Neither does freeze, but
> > both yield:
> > 
> > Floating point exception (core dumped)
> 
> Compiler specific ?

There's almost certainly more than that. I'd love to have a report on my
asm-only version, but even so I suspect it also requires the 3dnow stuff,
because I'm not able to trigger anything like this on any machines I have
access to (none of them are AMD, though)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
