Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSEQVPu>; Fri, 17 May 2002 17:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316696AbSEQVPt>; Fri, 17 May 2002 17:15:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38413 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316695AbSEQVPt>;
	Fri, 17 May 2002 17:15:49 -0400
Message-ID: <3CE572BE.DF2E4406@zip.com.au>
Date: Fri, 17 May 2002 14:14:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <86256BBC.0072F8A9.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> I'm not sure I understand what you're saying here.  Yes, the build system is
> mostly the same across all these versions -- that's my point.  I want it to STAY
> the same as long as possible.  What's the relationship between kbuild and the
> size of the kernel source?  Are you saying a new build system would make the
> kernel smaller?  Or do you mean that it would be faster, or would require
> recompiling smaller portions of the kernel after patching?  That wouldn't help
> me, because I'll never trust *any* build system -- even good ol' "make" itself
> -- to make the right determination of what to recompile after applying one of
> Linus's or Alan's patch sets.  I *always* "make mrproper" and recompile
> *everything* after patching.  (Back in my Minix days I usually didn't stop with
> recompiling the kernel, but recompiled everything -- libraries, user-space
> programs like "cat" and "ls," etc. -- after applying patches.  Minix upgrades
> frequently took me 10 hours or more on my 8088 system.)  As for speed, my
> Pentium II laptop compiles 2.5.15 a lot faster than my old 486 desktop compiled
> 0.99pl13 (my first kernel).
> 

That's you. On May 15 and May 16 I rebuilt the kernel over
150 times.

The deteriorating performance of gcc and the tendency of
the current build system to needlessly recompile stuff are
acute problems.  ccache saves me probably one hour per day.

-
