Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289867AbSAKEcH>; Thu, 10 Jan 2002 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289866AbSAKEb6>; Thu, 10 Jan 2002 23:31:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289867AbSAKEbr>; Thu, 10 Jan 2002 23:31:47 -0500
Date: Thu, 10 Jan 2002 20:29:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
In-Reply-To: <3C3E6163.2E4ECB03@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201102027500.3540-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Jeff Garzik wrote:
>
> wow, I always assumed the compiler was smart enough to replace a "/ 512"
> with a shift.

It is, but there was a bug in the PPC machine description in 3.0.x
(x=0,1), or something. It's supposedly fixed in later gcc's.

Tom, which gcc version do you have? I thought the fix made it into 3.0.3
(and from other issues I suspect it's better to upgrade to that anyway for
kernel compilation).

Or is this some other problem (ie if you see this on non-ppc compilation,
holler, and we'll try to see what's up)

		Linus

