Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289985AbSAKPaR>; Fri, 11 Jan 2002 10:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSAKPaG>; Fri, 11 Jan 2002 10:30:06 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:19118
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289985AbSAKP36>; Fri, 11 Jan 2002 10:29:58 -0500
Date: Fri, 11 Jan 2002 08:29:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
Message-ID: <20020111152950.GM13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C3E6163.2E4ECB03@mandrakesoft.com> <Pine.LNX.4.33.0201102027500.3540-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201102027500.3540-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 08:29:56PM -0800, Linus Torvalds wrote:
> 
> On Thu, 10 Jan 2002, Jeff Garzik wrote:
> >
> > wow, I always assumed the compiler was smart enough to replace a "/ 512"
> > with a shift.
> 
> It is, but there was a bug in the PPC machine description in 3.0.x
> (x=0,1), or something. It's supposedly fixed in later gcc's.
> 
> Tom, which gcc version do you have? I thought the fix made it into 3.0.3
> (and from other issues I suspect it's better to upgrade to that anyway for
> kernel compilation).

This was indeed on PPC (I tried x86 w/ the same package but it worked)
running gcc-3.0.3-1 (from Debian/sid).  So it seems the fix didn't make
it into a release yet.  I guess I'll go hunt down some compiler people
and get them to fix it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
