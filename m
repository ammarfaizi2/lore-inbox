Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSJAUlt>; Tue, 1 Oct 2002 16:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbSJAUlt>; Tue, 1 Oct 2002 16:41:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7949 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262489AbSJAUlq>; Tue, 1 Oct 2002 16:41:46 -0400
Date: Tue, 1 Oct 2002 13:49:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.44.0210012219460.21087-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0210011345260.1372-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Ingo Molnar wrote:
> 
> Despite all the previous fuss about the problems of typedefs, i've never
> had *any* problem with using typedefs in various code i wrote.

Big things should have big names. That's why "u8" is u8, because it's not 
just physically small, it also has very little semantics associated with 
it.

I want those variable declarations to stand out, and make people 
understand that this is not just a variable, it's a structure, and it may 
be taking up a noticeable amount of space on the stack, for example.

That's the main issue for me. I don't personally care so much about trying
to avoid dependencies in the header files that can also be problematic.  
That's probably partly because I use fast enough machines that parsing
them a few extra times doesn't much bother me, and circular requirements
tend to be rare enough not to bother me unduly.

So the thing is a big red warning sign that you're now using a complex 
data structure, and you should be aware of the semantics that go with it.

			Linus

