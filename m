Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSFKIdr>; Tue, 11 Jun 2002 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSFKIdq>; Tue, 11 Jun 2002 04:33:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2064 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316952AbSFKIdq>; Tue, 11 Jun 2002 04:33:46 -0400
Date: Tue, 11 Jun 2002 01:33:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: dent@cosy.sbg.ac.at, <adilger@clusterfs.com>, <da-x@gmx.net>,
        <patch@luckynet.dynu.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <20020611180051.6007ae94.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jun 2002, Rusty Russell wrote:
>
> Worst sin is that you can't predeclare typedefs.  For many uses (not the
> list macros of course):
> 	struct xx;
> is sufficient and avoids the #include hell,

True.

However, that only works for function declarations.

typedefs are easy to avoid.

The real #include hell comes, to a large degree, from the fact that we
like inline functions. Which have many wonderful properties, but they have
the same nasty property typedefs have: they require full type information
and cannot be predeclared.

And while I'd like to avoid #include hell, I'm not willing to replace
inline functions with #define's to avoid it ;^p

		Linus

