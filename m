Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbSKQSc2>; Sun, 17 Nov 2002 13:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbSKQSc2>; Sun, 17 Nov 2002 13:32:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267545AbSKQSc1>; Sun, 17 Nov 2002 13:32:27 -0500
Date: Sun, 17 Nov 2002 10:39:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] change allow_write_access/deny_write_access prototype
In-Reply-To: <20021117193100.A6763@lst.de>
Message-ID: <Pine.LNX.4.44.0211171036360.22525-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Christoph Hellwig wrote:
>
> Make them take an inode instead of a file, this way we don't need
> to derefence struct dentry in fs.h and with a few more steps we can
> get rid of dcache.h in fs.h

This is the point where I say "NO!"

If we're making code uglier because we want to include fewer files, we're 
doing something WRONG!

It's a lot more important to have readable code than it is to try to avoid 
a file include. And this patch makes code less readable, just look at it.

Also, I'm going to stop applying the header file cleanups altogether 
unless the people who send them to me check that things compile afterwards 
a lot better.

Arnaldo has been helping a lot in fixing stuff up after the cleanups,
thanks go to him. The last net.h/fs.h cleanup broke pcm_native.c, for
example. 

Cleanups are only good if they make things BETTER. Making things worse is 
not a good thing.

		Linus

