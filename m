Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319204AbSIKQRT>; Wed, 11 Sep 2002 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319212AbSIKQPv>; Wed, 11 Sep 2002 12:15:51 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:54485 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319204AbSIKQOH>; Wed, 11 Sep 2002 12:14:07 -0400
Date: Wed, 11 Sep 2002 13:18:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Daniel Phillips <phillips@arcor.de>, Chuck Lever <cel@citi.umich.edu>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D7E8936.9882E929@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209111317450.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Andrew Morton wrote:

> We _could_ walk the pte chain in writeback.  But that would involve
> visiting every page in the mapping, basically.  That could hurt.
>
> But if a page is already dirty, and we're going to write it anyway,
> it makes tons of sense to run around and clean all the ptes which
> point at it.

Walking ptes probably doesn't hurt as much as doing extra
disk IO, so I guess you're right ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

