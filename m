Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290051AbSAKSRg>; Fri, 11 Jan 2002 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290052AbSAKSR0>; Fri, 11 Jan 2002 13:17:26 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:43183
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290051AbSAKSRP>; Fri, 11 Jan 2002 13:17:15 -0500
Date: Fri, 11 Jan 2002 11:17:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
Message-ID: <20020111181714.GR13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020111152950.GM13931@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0201111008240.3952-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201111008240.3952-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 10:09:08AM -0800, Linus Torvalds wrote:
> 
> On Fri, 11 Jan 2002, Tom Rini wrote:
> >
> > This was indeed on PPC (I tried x86 w/ the same package but it worked)
> > running gcc-3.0.3-1 (from Debian/sid).  So it seems the fix didn't make
> > it into a release yet.  I guess I'll go hunt down some compiler people
> > and get them to fix it.
> 
> I've seen the patch, so it definitely is fixed - rth posted it to the gcc
> lists. But it may be that it only went into the development tree, or that
> it happened after 3.0.3 was released.

After talking with Franz Sirl abit (and reading the thread on the
patch), the fix is in the gcc-3.1 branch (so gcc-3.1.0 will work), and
the patch can be applied to 3.0.x (I've done it locally and am
rebuilding).  He's going to try and get the patch applied to the 3.0.x
branch, but isn't sure if there will be another 3.0.x release with 3.1
coming out on april 15 (if on schedule).

So should we workaround this now in 2.4.x or no?  There's other changes
which need to get into 2.4.x / 2.5.x anyhow for gcc-3.0.x to be happy on
all PPC arches anyhow.  But I also get the feeling 2.4.x and gcc-3.1
will be unsupported/not a good idea for a while to come anyhow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
