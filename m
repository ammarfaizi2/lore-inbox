Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSHOGkU>; Thu, 15 Aug 2002 02:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSHOGkU>; Thu, 15 Aug 2002 02:40:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13322 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S315285AbSHOGkT>;
	Thu, 15 Aug 2002 02:40:19 -0400
Date: Thu, 15 Aug 2002 08:44:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Willy Tarreau <willy@w.ods.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020815064404.GC7445@alpha.home.local>
References: <20020814204556.GA7440@alpha.home.local> <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 03:53:15PM -0700, David Lang wrote:
> why are you useing loops for delays in the first place? it's a solution
> that will fail as clock speeds keep improving (if for no other reason then
> your loop counter will end up needing to be a larger int to achieve the
> desired delay!!)
> 
> rather then debating how to convince gcc how to not optimize them away and
> messing up the timing we should be talking about how to eliminate such
> loops in the first place.

I'm NEVER using loops for delays, I find this awful and always a waste of
time. But sometimes, you want to benchmark some algorithms, and the compiler
makes this difficult by eliminating things it thinks are useless. I once had
this problem when comparing several linked lists algorithms, for example.

Moreover, some people complain about the fact that gcc doesn't optimize
everything because of people using loops for delays. If we provide convenient
ways to help the user tell gcc when not to optimize, gcc could optimize
everything possible by default.

Cheers,
Willy

