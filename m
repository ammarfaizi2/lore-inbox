Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbREMCfi>; Sat, 12 May 2001 22:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbREMCf2>; Sat, 12 May 2001 22:35:28 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:4871 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261369AbREMCfR>; Sat, 12 May 2001 22:35:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Sun, 13 May 2001 04:13:19 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0105121817020.11973-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105121817020.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01051304131900.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2001 00:18, Alexander Viro wrote:
> On Sat, 12 May 2001, Andreas Dilger wrote:
> > We could use the "buffer_uptodate" flag on the buffer to signal
> > that the block has been checked.  AFAIK, a new buffer will not be
> > uptodate, and once it is it will not be read from disk again... 
> > However, if a user-space process read the buffer would also mark it
> > uptodate without doing the check...  Maybe we should use a new BH_
> > pointer... Just need to factor out the ext2_check_page() code so
> > that it works on a generic memory pointer and end pointer.
>
> Or you could simply use ext2_get_page() and forget about this crap.

I tried that first.  The resulting code was not nice and worked only 
for 4K block_size, as far as I took it.

I'm not sure what advantage you see in ext2_get_page, perhaps you can 
explain.
--
Daniel
