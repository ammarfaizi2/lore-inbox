Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319504AbSIGSnz>; Sat, 7 Sep 2002 14:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319505AbSIGSnz>; Sat, 7 Sep 2002 14:43:55 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:32473 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319504AbSIGSnz>; Sat, 7 Sep 2002 14:43:55 -0400
Date: Sat, 7 Sep 2002 15:47:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, <trond.myklebust@fys.uio.no>,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <E17natE-0006OB-00@starship>
Message-ID: <Pine.LNX.4.44L.0209071547250.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2002, Daniel Phillips wrote:
> On Friday 06 September 2002 00:19, Andrew Morton wrote:
> > I'm not sure what semantics we really want for this.  If we were to
> > "invalidate" a mapped page then it would become anonymous, which
> > makes some sense.
>
> There's no need to leave the page mapped, you can easily walk the rmap list
> and remove the references.

A pagefaulting task can have claimed a reference to the page
and only be waiting on the lock we're currently holding.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

