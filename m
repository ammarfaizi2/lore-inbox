Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSA3HSH>; Wed, 30 Jan 2002 02:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288742AbSA3HSC>; Wed, 30 Jan 2002 02:18:02 -0500
Received: from waste.org ([209.173.204.2]:44948 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288733AbSA3HRv>;
	Wed, 30 Jan 2002 02:17:51 -0500
Date: Wed, 30 Jan 2002 01:17:50 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poor
 dcache  utilization under high memory pressure
In-Reply-To: <3C56FE14.15EA248E@zip.com.au>
Message-ID: <Pine.LNX.4.44.0201300113120.25123-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Andrew Morton wrote:

> Andreas Dilger wrote:
> >
> > But if it is unused and not recently referenced, there is little benefit
> > in keeping it around, is there?
>
> In all of this, please remember that all caches are not of
> equal value-per-byte.  A single page contains 32 dentries,
> and can thus save up to 32 disk seeks.  It's potentially
> a *lot* more valuable than a (single-seek) pagecache page.

Or it might equally well be 32 contiguous directory entries that you
scanned over to get to the file you wanted. If it's 32 hot items, as a
page it's going to be aged significantly less than one equally hot
pagecache page, so I don't think we need to worry about that too much.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

