Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRHAX7P>; Wed, 1 Aug 2001 19:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbRHAX7F>; Wed, 1 Aug 2001 19:59:05 -0400
Received: from [63.209.4.196] ([63.209.4.196]:54279 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267890AbRHAX6w>; Wed, 1 Aug 2001 19:58:52 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 1 Aug 2001 16:57:38 -0700
Message-Id: <200108012357.f71Nvcd16065@penguin.transmeta.com>
To: adilger@turbolinux.com, linux-kernel@vger.kernel.org
Subject: Re: repeated failed open()'s results in lots of used memory [Was: [Fwd:
 memory consumption]]
Newsgroups: linux.dev.kernel
In-Reply-To: <200108012253.f71MrxGO007546@webber.adilger.int>
In-Reply-To: <3B688480.7090704@starentnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200108012253.f71MrxGO007546@webber.adilger.int> you write:
>
>Looking at the code, it appears that if we call shrink_dcache_memory()
>from while trying to allocate memoty for a filesystem, it returns
>without doing anything, to avoid a deadlock.  Al Viro and/or Marcelo
>Tosatti probably know how to fix this.

Note that negative dentries are different, and can be happily thrown
away even from a filesystem context - so the suggested fix with special
handling for negative dentries (another email) should work fine. 

		Linus
