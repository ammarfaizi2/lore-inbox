Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSJJDCD>; Wed, 9 Oct 2002 23:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJJDCD>; Wed, 9 Oct 2002 23:02:03 -0400
Received: from adedition.com ([216.209.85.42]:4615 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262981AbSJJDCC>;
	Wed, 9 Oct 2002 23:02:02 -0400
Date: Wed, 9 Oct 2002 23:07:36 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010030736.GA8805@mark.mielke.cc>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc> <20021009232002.GC2654@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009232002.GC2654@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 12:20:02AM +0100, Jamie Lokier wrote:
> Mark Mielke wrote:
> >     2) Pages should not be candidates for dropping if the pages belong
> >        to the first few pages of a file. (First = 2? 4? 8?) The theory
> >        being, that somebody could begin reading the file again from the
> >        beginning.
> This breaks the benefit of using O_STREAMING to read a lot of small
> files once, as you might do when grepping the kernel tree for example.

It doesn't break it. It reduces it to current speeds.

I might be wrong, but it seems to me that O_STREAMING isn't the answer
to everything. The primary benefactors of O_STREAMING would be
applications that read very large files that do not fit into RAM, from
start to finish.

If you want to improve grepping the kernel tree, the answer lies in
improving the standard scheme, not overloading the specialized
O_STREAMING scheme.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

