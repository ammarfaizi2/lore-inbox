Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFFQPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFFQPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:15:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:44960 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261994AbTFFQPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:15:54 -0400
Date: Fri, 6 Jun 2003 18:29:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: art_k@o2.pl
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk11 zlib reduce deflate workspace by 128k
Message-ID: <20030606162921.GA911@wohnheim.fh-wedel.de>
References: <20030606140149.GA20168@wohnheim.fh-wedel.de> <20030606170043.37965017.art_k@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606170043.37965017.art_k@o2.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 June 2003 17:00:43 +0200, art_k@o2.pl wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> (030606.160149,<20030606140149.GA20168@wohnheim.fh-wedel.de>):
> > Free lunch time.  There are currently no users in the kernel that use
> > a memlevel >8, but we reserve space for 9.  The patch saves 128k at no
> > cost.
> 
> >  /* Maximum value for memLevel in deflateInit2 */
> >  #ifndef MAX_MEM_LEVEL
> > -#  define MAX_MEM_LEVEL 9
> > +#  define MAX_MEM_LEVEL 8
> >  #endif
> 
> i like the direction this is going, but when making these kind of changes
> it would be even better if the reasoning would be noted in a short comment
> (eg. "/* no users of memlevel>8 in kernel; saves 128k RAM */").
> That way the next person looking at that code would immediately know why
> that number was chosen.

Usually, you would be right.  But in this case, the existing comments
in zconf.h match the situation *after* my patch.  Looks good to me.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
