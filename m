Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313997AbSDQBKi>; Tue, 16 Apr 2002 21:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313998AbSDQBKh>; Tue, 16 Apr 2002 21:10:37 -0400
Received: from bitmover.com ([192.132.92.2]:60607 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313997AbSDQBKg>;
	Tue, 16 Apr 2002 21:10:36 -0400
Date: Tue, 16 Apr 2002 18:10:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020416181034.C24069@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"M. R. Brown" <mrbrown@0xd6.org>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 07:08:18PM -0500, M. R. Brown wrote:
> * Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:
> 
> > > Please tell us that primary framebuffer/input/console development will
> > > continue in the CVS drop-in tree on SourceForge?  Bitkeeper is unable to
> > > support this (easier, more efficient) style of development.
> > 
> > Could you please explain why you think CVS is easier and more efficient?
> > Last I checked, BK was a superset of CVS, but could be used pretty much
> > identically to CVS if that's what you want.
> 
> A drop-in tree (also called "shadow trees" by Keith Owens of kbuild), is a
> small set of files intended to be applied against a larger parent body of
> code.  For example, a kernel subsystem or backend project (linuxconsole,
> LinuxSH, Linux-MIPS) will only maintain the minimal number of files that
> are specific to that backend, e.g. include/asm-mips/, arch/mips,
> /arch/mips64, etc. for any files local to the project.  

Ahh, OK, we're already working on this.  We call 'em nested repositories
and one of the problems they solve is exactly the problem you described.
Think of them as CVS modules, with a little more formality, and you're
about there.  They also solve a bunch of performance problems.

I tend to agree with your comments about not wanting the whole tree, to
some extent.  You are aware, of course, that your drop in may not work
if the rest of the tree has moved on.  So the drop in has a limited
life span in isolation.  With that caveat, drop ins are nice and we'll
have them before too long.  Unlike CVS, we like to be able to reproduce
the tree accurately so there is more work to do.

On your comments about CVS being less complex, I don't agree at all.
Almost all of the BK complexity is to handle problems CVS doesn't
handle at all.  Another way to say that is when you hit those problems
BK is much much less complex that CVS.  For example, a simple file
rename is a nightmare in CVS and a non-issue in BK, it just propogates.

If you want to eliminate learning "bk mv foo.c bar.c", just don't do
that and all of that complexity is never used.

I'll be the first to admit that BK is a big system, but it's no more
complex than CVS if you limit yourself to CVS-like operations.  And 
when you go beyond those limits, then BK becomes less complex to the
user just as CVS is starting to fall over.  Or am I missing something?
Have you read http://www.bitkeeper.com/cvs2bk.html ?  That covers the
translation.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
