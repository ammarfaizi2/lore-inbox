Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSE1Fd3>; Tue, 28 May 2002 01:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSE1Fd2>; Tue, 28 May 2002 01:33:28 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:41346 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S312601AbSE1Fd2>;
	Tue, 28 May 2002 01:33:28 -0400
Date: Tue, 28 May 2002 07:33:03 +0200
From: David Weinehall <tao@acc.umu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix compilation for other architectures
Message-ID: <20020528073303.K9911@khan.acc.umu.se>
In-Reply-To: <20020527172156.GA3907@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 07:21:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> Currently, on machine where suspend is not yet supported, compilation
> fails even in case user did not actually requested suspend. This
> "fixes" it -- compilation only fails when suspend is needed and not
> supported. Please apply,
> 								Pavel
> 
> --- clean/include/asm-i386/suspend.h	Sun May 26 19:32:03 2002
> +++ linux-swsusp/include/asm-i386/suspend.h	Mon May 27 19:11:25 2002
> @@ -1,13 +1,8 @@
> -#ifndef __ASM_I386_SUSPEND_H
> -#define __ASM_I386_SUSPEND_H
> -#endif

You probably want to move the #endif to the end of the file instead of
removing it; having #ifndef/#define/#endif-traps for all header-files is
good practice.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
