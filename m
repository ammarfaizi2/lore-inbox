Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVJaH10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVJaH10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVJaH10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:27:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21893 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932323AbVJaH1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:27:25 -0500
Date: Mon, 31 Oct 2005 07:27:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, ak@suse.de, tytso@mit.edu, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051031072714.GU7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org> <200510310145.43663.ak@suse.de> <20051031001810.GQ7992@ftp.linux.org.uk> <20051030191402.669273d5.pj@sgi.com> <20051031033426.GT7992@ftp.linux.org.uk> <20051030232234.3ebf77c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030232234.3ebf77c8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 11:22:34PM -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > On Sun, Oct 30, 2005 at 07:14:02PM -0800, Paul Jackson wrote:
> > > I think you are exagerating.
> > > 
> > > It builds on most configs most of the time in my experience.  If I
> > > haven't tried a crosstool rebuild of the several defconfig arch's in a
> > > week, I might expect one of the less popular archs to drop out, usually
> > > for something so easy even I can figure some sort of fix or workaround.
> > 
> > Try allmodconfig for a change...  I'm doing that for mainline on a regular
> > basis and even that turns into considerable amount of time.  I have tried
> > that for -mm and had to give up.
> 
> fud.  Every -mm release is built with allmodconfig on x86 and on x86_64. 
> It's also cross-compiled on fat configs for alpha, ppc32, ppc64, sparc64,
> arm and ia64.  It's booted on x86, x86_64, ppc64 and ia64.  Every release.

What fud?  I stand by my claim - I have tried to do the same thing for
-mm and found that I didn't have guts for that; too much work.  For mainline
I do cross-builds for allmodconfig on a *lot* more targets than what you've
mentioned and generally it stays within ~150-200Kb of patches, about half
of that being a fix for 8390 mess.

_IF_ somebody wants to do that for -mm, yell and you are more than welcome
to all infrastructure, except for the cycles on build box I'm using.
Incidentally, it is a box at work - my energy bill is high enough as it
is, without adding an 8-way 3GHz iamd64 to it...

The last time I've attempted that for -mm was this summer; right now mainline
is quite enough work, TYVM...  Especially since I use the same tree as a
staging point for annotations and watch for build regressions both for gcc
and sparse.
