Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSEQFSn>; Fri, 17 May 2002 01:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315426AbSEQFSm>; Fri, 17 May 2002 01:18:42 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:57579 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315425AbSEQFSh>;
	Fri, 17 May 2002 01:18:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Htree directory index for Ext2, updated
Date: Fri, 17 May 2002 07:18:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205170422.g4H4M5q295551@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178a8G-00005D-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 06:22, Albert D. Cahalan wrote:
> > After learning to my horror that gnu patch will, if a patch was made to be 
> > applied with option -p0, sometimes apply patches to your 'clean' tree (the 
> > one with the ---'s) instead of the target tree (the one with the +++'s) I 
> > decided to switch to -p1, and that is how this patch is to be applied.
> 
> The worst thing is that gnu patch will make
> this decision on a per-file basis, so you
> can't then back out the changes with -R.
> 
> Do like this:
> 
> diff -Naurd old new
> 
> IMPORTANT: the directory names should have
> the same number of characters in them.

Why is that?

> Do not try something like:
> 
> diff -Naurd bad idea
> diff -Naurd doomed 2fail
> 
> Don't use "linux" for a name. Don't use
> anything Linus might use. Pick your own
> equal-length directory names, and don't
> distribute tarballs containing them.
> This prevents source-destroying disasters.

I think you're saying that patch is broken by design.  And what's the standard 
argument for not fixing it?

-- 
Daniel
