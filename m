Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNTm3>; Thu, 14 Dec 2000 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLNTmS>; Thu, 14 Dec 2000 14:42:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30987 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129260AbQLNTmF>; Thu, 14 Dec 2000 14:42:05 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Signal 11
Date: 14 Dec 2000 11:11:28 -0800
Organization: Transmeta Corporation
Message-ID: <91b610$biq$1@penguin.transmeta.com>
In-Reply-To: <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com>,
Clayton Weaver  <cgweav@eskimo.com> wrote:
>
>There has a been a thread on the teTeX mailing list the last few days
>about a (RedHat, but probably more general than just their rpms)
>gcc-2.9.6 w/glibc-2.2.x bug. At -O2, it can miscompile 

Quite frankly, anybody who uses RedHat 7.0 and their broken compiler for
_anything_ is going to have trouble.

I don't know why RH decided to do their idiotic gcc-2.96 release (it
certainly wasn't approved by any technical gcc people - the gcc people
were upset about it too), and I find it even more surprising that they
apparently KNEW that the compiler they were using was completely broken. 
They included another (non-broken) compiler, and called it "kgcc". 

"kgcc" stands for "kernel gcc", apparently because (a) they realised
that a miscompiled kernel is even worse than miscompiling some random
user applications and (b) gcc-2.96 is so broken that it requires special
libraries for C++ vtable chunks handling that is different, so the
_working_ gcc can only be used with programs that do not need such
library support.  Namely the kernel. 

In case it wasn't obvious yet, I consider RedHat-7.0 to be basically
unusable as a development platform, and I hope RH downgrades their
compiler to something that works better RSN.  It apparently has problems
compiling stuff like the CVS snapshots of X etc too (and obviously,
anything you compile under gcc-2.96 is not likely to work anywhere else
except with the broken libraries). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
