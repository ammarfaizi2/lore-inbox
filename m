Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290062AbSAKSni>; Fri, 11 Jan 2002 13:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290063AbSAKSn2>; Fri, 11 Jan 2002 13:43:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290062AbSAKSnI>; Fri, 11 Jan 2002 13:43:08 -0500
Date: Fri, 11 Jan 2002 10:40:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
In-Reply-To: <20020111181714.GR13931@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201111038170.3952-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Tom Rini wrote:
>
> After talking with Franz Sirl abit (and reading the thread on the
> patch), the fix is in the gcc-3.1 branch (so gcc-3.1.0 will work), and
> the patch can be applied to 3.0.x

Ok.

> So should we workaround this now in 2.4.x or no?

I'll apply it to the 2.5.x tree - it's not as if it can hurt anything (it
will actually generate better code, as a signed divide is slightly more
complex than just a shift due to rounding issues, and gcc doesn't know
that the inode length will always be non-negative).

Whether it is worth working around in 2.4.x I don't have any real opinion
on, but I doubt it is worthwhile to compile 2.4.x with gcc-3.0.x anyway.
But again, applying it won't hurt.

		Linus

