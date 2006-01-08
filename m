Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWAHDuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWAHDuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbWAHDuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:50:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34756
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750894AbWAHDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:50:46 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Date: Sat, 7 Jan 2006 21:50:14 -0600
User-Agent: KMail/1.8
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060107023713.GA13285@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601072150.14855.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 09:12, Jan Engelhardt wrote:
> >The skas vs tt distinction is the address space part of this.  How we
> > nullify system calls is separate.  That's the PTRACE_SYSCALL vs
> > PTRACE_SYSEMU (which is now in mainline) thing.
>
> ...
> So there is no way to get UML compile on non-Linux.

Not out of the box, no.  You need some equivalent debugging facility, but 
that's not too high a barrier.  It's really that there's no way for a 
userspace process to fiddle around with the MMU the way an OS wants to, 
unless you A) put hooks in the OS, or B) have multiple processes with 
different memory contexts, which means debugging hooks if you want one thread 
to intercept the syscalls made by another thread.

There have been occasional attempts at doing this, by the way.  (If I had 
gotten a mac mini I was going to give it a try, but about two _hours_ before 
I had scheduled an extra long lunch hour to go visit the Apple store in the 
barton creek mall, I heard about Jobs' announcement of the switchover to 
Intel processors, so I didn't.  Not like I really _need_ another todo item 
that's going to wind up taking up six months of my free time.  Just use 
qemu...)

> Jan Engelhardt

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
