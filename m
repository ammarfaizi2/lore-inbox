Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSE1Lyj>; Tue, 28 May 2002 07:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSE1Lyi>; Tue, 28 May 2002 07:54:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54290 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314079AbSE1Lyh>; Tue, 28 May 2002 07:54:37 -0400
Date: Tue, 28 May 2002 10:29:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Weinehall <tao@acc.umu.se>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix compilation for other architectures
Message-ID: <20020528082941.GB4986@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020527172156.GA3907@elf.ucw.cz> <20020528073303.K9911@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Currently, on machine where suspend is not yet supported, compilation
> > fails even in case user did not actually requested suspend. This
> > "fixes" it -- compilation only fails when suspend is needed and not
> > supported. Please apply,
> > 								Pavel
> > 
> > --- clean/include/asm-i386/suspend.h	Sun May 26 19:32:03 2002
> > +++ linux-swsusp/include/asm-i386/suspend.h	Mon May 27 19:11:25 2002
> > @@ -1,13 +1,8 @@
> > -#ifndef __ASM_I386_SUSPEND_H
> > -#define __ASM_I386_SUSPEND_H
> > -#endif
> 
> You probably want to move the #endif to the end of the file instead of
> removing it; having #ifndef/#define/#endif-traps for all header-files is
> good practice.

Actually, I do not want to. This header file is somehow special, and
suspend.c needs special "private" part of it, too. I'll clean that up
later.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
