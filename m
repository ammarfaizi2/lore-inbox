Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSILXTA>; Thu, 12 Sep 2002 19:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSILXTA>; Thu, 12 Sep 2002 19:19:00 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:17286 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318743AbSILXTA>; Thu, 12 Sep 2002 19:19:00 -0400
Date: Thu, 12 Sep 2002 20:23:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>, <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D811A6C.C73FEC37@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209122022080.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Andrew Morton wrote:
> Rik van Riel wrote:

> > invalidate_page(struct page * page) {

> That's the bottom-up approach.  The top-down (vmtruncate) approach
> would also work, if the locking is suitable.

The top-down approach will almost certainly be most efficient when
invalidating a large chunk of a file (truncate, large file locks)
while the bottom-up approach is probably more efficient when the
system invalidates very few pages (small file lock, cluster file
system mmap() support).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

