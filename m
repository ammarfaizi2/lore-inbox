Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUKZXtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUKZXtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKZTp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:45:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262435AbUKZT1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:30 -0500
Date: Fri, 26 Nov 2004 00:09:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20041125230937.GA2909@elf.ucw.cz>
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A1FFFC.70507@hist.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Such support may happen for a few fs'es - people who
> want this will then use those fses.  Those who don't
> like the ideas will use others.
> 
> >(.tar, .tar.gz, ...) support in the VFS itself, and of course
> >transparent to any fs and any user-land application. There are many
> >archive FSs around, but how feasible would it be to implement the
> >archive file support in the VFS at dentry-level? I'd be happy to share
> >my proposal.
> >
> > 
> >
> You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
> 1. .tar and .tar.gz are complicated formats, and are therefore better
>   left to userland.  You can get some of the same effect by using a shared
>   library that redefines fopen() and fread() though.  It'll work fine for
>   the vast majority of apps that happens to use the C library.

It is not same effect -- with shared library you get no caching. And
that hurts a lot.

>   It is hard to make a guaranteed bug-free decompressor that
>   is efficient and works with a finite amount of memory.  The kernel
>   needs all that - userland doesn't.

If you have bug in decompressor, you are screwed, anyway, because you
get remote user exploit when mozilla gets the file from
web. Oops. [Ok, you at least do not get remote root exploit, but...]

								Pavel 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
