Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319243AbSIKRRx>; Wed, 11 Sep 2002 13:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319309AbSIKRRx>; Wed, 11 Sep 2002 13:17:53 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:38631 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319243AbSIKRRw>;
	Wed, 11 Sep 2002 13:17:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Wed, 11 Sep 2002 19:14:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>, <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209111317450.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209111317450.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pB4t-0007SN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 18:18, Rik van Riel wrote:
> On Tue, 10 Sep 2002, Andrew Morton wrote:
> 
> > We _could_ walk the pte chain in writeback.  But that would involve
> > visiting every page in the mapping, basically.  That could hurt.
> >
> > But if a page is already dirty, and we're going to write it anyway,
> > it makes tons of sense to run around and clean all the ptes which
> > point at it.
> 
> Walking ptes probably doesn't hurt as much as doing extra
> disk IO, so I guess you're right ;)

Well, but the thing I'm worried about is that we have failed to
implement sys_msync at this point, please reassure me on that, if
possible.

-- 
Daniel
