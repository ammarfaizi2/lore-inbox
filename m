Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbSKSUjw>; Tue, 19 Nov 2002 15:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSKSUjw>; Tue, 19 Nov 2002 15:39:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267209AbSKSUjt>; Tue, 19 Nov 2002 15:39:49 -0500
Date: Tue, 19 Nov 2002 15:46:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
In-Reply-To: <20021119202931.GA15161@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Sam Ravnborg wrote:

> On Tue, Nov 19, 2002 at 03:22:45PM -0500, Richard B. Johnson wrote:
> > I have a question; "What problem is this supposed to solve?"
> 
> Two problems (at least):
> 
> 1) You want to compile your kernel based on two different configurations,
> but sharing the same src. No need to have a duplicate of all src.
> - There are other ways to do this using symlinks
> 
> 2) You have the src located on a read-only filesystem.
> I have been told this is the case for some SCM systems.
> 
> People has requested this feature at several occasions, and here
> it is based on the current build system.
> It's not ready for inclusion (obviously), and you shall
> also see this as a way to check that this is considered usefull
> by someone.
> 
> 	Sam

Hmmm. If your source is located on a read-only file-system, you
can't modify it. You are therefore doomed to use only "known working"
distributions that are known to work with all possible module
combinations (these don't exist). So you get to compile the kernel
just as a test exercise or a gimmick like; "what did you do today?..."
answer; "I compiled the kernel..." This seems to not be very practical
since the purpose of compiling the kernel was to add something or
fix something. Now, its just to see if it compiles.

Different configurations are handled with different ".config"
files.

I think all you did was increase the compile time by writing
output files to different directories than the ones currently
in cache. There are a lot of negatives. It would be a shame for
you to waste a great deal of time on something that would not
be accepted into the distribution. Remember the earlier `make modules`
where the new objects went into a separate directory with sym-links?
That got changed. I think it got changed for good reasons.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


