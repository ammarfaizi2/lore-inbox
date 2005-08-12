Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVHLRfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVHLRfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHLRfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:35:12 -0400
Received: from cramus.icglink.com ([66.179.92.18]:8163 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S1750753AbVHLRfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:35:11 -0400
Date: Fri, 12 Aug 2005 12:35:05 -0500
From: Phil Dier <phil@icglink.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, ziggy@icglink.com, scott@icglink.com,
       jack@icglink.com
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-Id: <20050812123505.1515634c.phil@icglink.com>
In-Reply-To: <17148.1113.664829.360594@cse.unsw.edu.au>
References: <20050811105954.31f25407.phil@icglink.com>
	<17148.1113.664829.360594@cse.unsw.edu.au>
Organization: ICGLink
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 12:07:21 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:
> You could possibly put something like
> 
> 	struct bio_vec *from;
> 	int i;
> 	bio_for_each_segment(from, bio, i)
> 		BUG_ON(page_zone(from->bv_page)==NULL);
> 
> in generic_make_requst in drivers/block/ll_rw_blk.c, just before
> the call to q->make_request_fn.
> This might trigger the bug early enough to see what is happening.


I've got tests running with this code in place, by I/O is so slow now
I don't think it's going to oops (or if it does, it'll be a while)..

Is there any other info I can collect to help track this down?

-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
