Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313317AbSC2AmW>; Thu, 28 Mar 2002 19:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313319AbSC2AmN>; Thu, 28 Mar 2002 19:42:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12304 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313317AbSC2Al7>; Thu, 28 Mar 2002 19:41:59 -0500
Date: Thu, 28 Mar 2002 19:39:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Stephen Baker <stbaker@cisco.com>
cc: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Patch; setpriority
In-Reply-To: <3CA39732.2050209@cisco.com>
Message-ID: <Pine.LNX.3.96.1020328193113.19963A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Stephen Baker wrote:

> All this is really just pigeon dancing around the fact that Linux 
> doesn't implement the PTHREAD_SCOPE_PROCESS which is all I want .  I t 
> would make Linux match Solaris and BSD model for POSIX threads.  I guess 
> it wouldn't be POSIX if everyone implemented it the same set of 
> supported features.  That's why I resorted to changing the nice value in 
> hopes of have some say in how things get scheduled without all the 
> superuser / capabilities hacks.

  I just did a "man 3 pthreads" and that capability is listed as
available... If you can boil it down to a small test program as I did,
I'll run it on Linux and Solaris and see what I see.

  Of course Linux doesn't implement anything here, you choose the
implementation by pthreads lib and includes, the old MIT user-level one,
the so-called "Linux threads" model, or the current NGPT model in current
kernels and the library from IBM.

  The latter work, at least for some definitions of "work," but I know
there are some differences.

  I don't see why starting two threads at different priorities when the
program does init is enough overhead to notice, but I don't have your
program so you may need something inobvious.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

