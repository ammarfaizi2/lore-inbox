Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137059AbREKHEE>; Fri, 11 May 2001 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137058AbREKHDy>; Fri, 11 May 2001 03:03:54 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136913AbREKHDh>;
	Fri, 11 May 2001 03:03:37 -0400
Date: Mon, 7 May 2001 19:07:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: agrawal@ais.org
Cc: linux-kernel@vger.kernel.org
Subject: vsyscallRe: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010507190726.C45@(none)>
In-Reply-To: <20010503210904.B9715@bug.ucw.cz> <Pine.LNX.4.10.10105031541190.32369-100000@SLASH.REM.CMU.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10105031541190.32369-100000@SLASH.REM.CMU.EDU>; from agrawal@ais.org on Thu, May 03, 2001 at 03:50:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That means that for fooling closed-source statically-linked binary,
> > you now need to patch kernel. That's regression; subterfugue.org could
> > do this with normal user rights in 2.4.0.
> 
> This is particularly pretty, but something that might work:
> 
> 1. a "deceiver" process creates a shared memory page, populates shared
>    page with appropriate magic (perhaps copying from its own magic page?)
> 2. have subterfuge unmap the magic page for the fooled process, and map in
>    the shared page in its place (assumes subterfuge can insert system
>    calls, instead of just modifying them)

subterfugue can insert calls just fine; just I'm not sure if vsyscall
implementation will let you unmap magic page.

> 3. deceiver periodically updates magic page

This is going to be the hard part.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

