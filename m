Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264695AbSJUC3y>; Sun, 20 Oct 2002 22:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264696AbSJUC3y>; Sun, 20 Oct 2002 22:29:54 -0400
Received: from waste.org ([209.173.204.2]:47791 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264695AbSJUC3u>;
	Sun, 20 Oct 2002 22:29:50 -0400
Date: Sun, 20 Oct 2002 21:35:46 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: patch management scripts
Message-ID: <20021021023546.GK26443@waste.org>
References: <3DB30283.5CEEE032@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB30283.5CEEE032@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 12:22:43PM -0700, Andrew Morton wrote:
> 
> I finally got around to documenting the scripts which I use
> for managing kernel patches.  See
> 
> http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.1/
> 
> These scripts are designed for managing a "stack" of patches against
> a rapidly-changing base tree. Because that's what I use them for.
> 
> I've been using and evolving them over about six months.  They're
> pretty fast, and simple to use.  They can be used for non-kernel
> source trees.

Thanks for posting these - hopefully it will generate some discussion.

My own personal scripts (while obviously not getting nearly the
workout yours are) make at least one part noticeably simpler - I use a
complete 'cp -al' for the current "top of the applied stack" rather
than your foo.c~bar files. This means I don't have to explicitly keep
track of which files I'm touching and just let diff compare the entire
tree (which is fast as diff apparently recognizes hard links). My
equivalent of refpatch spews out a diffstat so that I can easily
notice if I touched something I didn't mean to.

My "apply patches up to x" script does some tricks so it generally
only does one 'cp -al', so the overhead is generally only a second or
two. The error handling got a little tedious in bash, so I rewrote
mine in Python..

I also have all my secondary directories outside of the source tree
proper, so it's easy to keep a completely pristine base tree and a
couple "branches".

What I'd really like is if someone were industrious enough to post a
"grab all patches to upgrade to current {release, bk, mm, ac}" script.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
