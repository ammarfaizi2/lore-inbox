Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTBSDWU>; Tue, 18 Feb 2003 22:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBSDWU>; Tue, 18 Feb 2003 22:22:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35602 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267886AbTBSDWT>; Tue, 18 Feb 2003 22:22:19 -0500
Date: Tue, 18 Feb 2003 19:29:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate warnings in generated module files
In-Reply-To: <20030218184317.A20436@twiddle.net>
Message-ID: <Pine.LNX.4.44.0302181925360.1468-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Feb 2003, Richard Henderson wrote:
>
> The compiler.h fragment should describe the problem well enough.

Have you tested this with older compilers?

In particular, I have this dim memory of gcc historically not liking 
multiple separate __attribute__ bits, ie

	__attribute__((unused,__section__ ...))

would be fine, but

	__attribute__((unused)) __attribute__((__section__ ...))

would not compile.

But hey, my brain is cabbage, and my memory might be crap.

		Linus

