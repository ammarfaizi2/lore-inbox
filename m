Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWC3OhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWC3OhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWC3OhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:37:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54109 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932247AbWC3OhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:37:16 -0500
Date: Thu, 30 Mar 2006 16:37:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #3
Message-ID: <20060330143721.GM13476@suse.de>
References: <20060330131530.GI13476@suse.de> <20060330142532.GB11934@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330142532.GB11934@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Christoph Hellwig wrote:
> On Thu, Mar 30, 2006 at 03:15:30PM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > Ok, this should be it, I hope. Fixed the remaining issues spotted by
> > akpm, and also thanks to KAMEZAWA Hiroyuki for pointing out that the
> > page moving logic could get confused.
> 
> Haven't looked at this in details, but two small comments already:
> 
>  - generic_file_splice_read/write should probably go to filemap.c
>    where all the other generic pagecache file operations are

Perhaps, I kind of like it local to the splice stuff.

>  - could we try to replace ->sendfile and ->sendfile with the splice
>    operations completely?  Having two different sets of zero-copy
>    file to file transfer mechanisms will make the code pretty messy.

I've thought of that myself, and yes I hope we can implement
->sendfile() on top of splice if not now then in the immediate future.

-- 
Jens Axboe

