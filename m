Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSCDFMw>; Mon, 4 Mar 2002 00:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291547AbSCDFMm>; Mon, 4 Mar 2002 00:12:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55539
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291545AbSCDFM0>; Mon, 4 Mar 2002 00:12:26 -0500
Date: Sun, 3 Mar 2002 21:13:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Christoph Hellwig <hch@caldera.de>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre2-ac2
Message-ID: <20020304051310.GC1459@matchmail.com>
Mail-Followup-To: Ed Tomlinson <tomlins@cam.org>,
	Christoph Hellwig <hch@caldera.de>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20020303210346.A8329@caldera.de> <20020304045557.C1010BA9E@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020304045557.C1010BA9E@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 11:55:57PM -0500, Ed Tomlinson wrote:
> On March 3, 2002 03:03 pm, Christoph Hellwig wrote:
> > I have uploaded an updated version of the radix-tree pagecache patch
> > against 2.4.19-pre2-ac2.  News in this release:
> >
> > * fix a deadlock when vmtruncate takes i_shared_lock twice by introducing
> >   a new mapping->page_lock that mutexes mapping->page_tree. (akpm)
> > * move setting of page->flags back out of move_to/from_swap_cache. (akpm)
> > * put back lost page state settings in shmem_unuse_inode. (akpm)
> > * get rid of remove_page_from_inode_queue - there was only one caller. (me)
> > * replace add_page_to_inode_queue with ___add_to_page_cache. (me)
> >
> > Please give it some serious beating while I try to get 2.5 working and
> > port the patch over 8)
> 
> Got this after a couple of hours with pre2-ac2+preempth+radixtree.
> 

Can you try again without preempt?
