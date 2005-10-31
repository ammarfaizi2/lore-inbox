Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVJaGXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVJaGXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJaGXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:23:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932470AbVJaGXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:23:36 -0500
Date: Sun, 30 Oct 2005 23:22:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: pj@sgi.com, ak@suse.de, tytso@mit.edu, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030232234.3ebf77c8.akpm@osdl.org>
In-Reply-To: <20051031033426.GT7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<p73r7a4t0s7.fsf@verdi.suse.de>
	<20051030213221.GA28020@thunk.org>
	<200510310145.43663.ak@suse.de>
	<20051031001810.GQ7992@ftp.linux.org.uk>
	<20051030191402.669273d5.pj@sgi.com>
	<20051031033426.GT7992@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Sun, Oct 30, 2005 at 07:14:02PM -0800, Paul Jackson wrote:
> > I think you are exagerating.
> > 
> > It builds on most configs most of the time in my experience.  If I
> > haven't tried a crosstool rebuild of the several defconfig arch's in a
> > week, I might expect one of the less popular archs to drop out, usually
> > for something so easy even I can figure some sort of fix or workaround.
> 
> Try allmodconfig for a change...  I'm doing that for mainline on a regular
> basis and even that turns into considerable amount of time.  I have tried
> that for -mm and had to give up.

fud.  Every -mm release is built with allmodconfig on x86 and on x86_64. 
It's also cross-compiled on fat configs for alpha, ppc32, ppc64, sparc64,
arm and ia64.  It's booted on x86, x86_64, ppc64 and ia64.  Every release.

Yes, some tty drivers have been busted in recent releases, as described in
the release notices.  That's why the tty patches are at the end of the -mm
series: so I can back them off for the allmodconfig builds.

I usually do allnoconfig and allyesconfig, too.
