Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbULOAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbULOAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbULOARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:17:23 -0500
Received: from unthought.net ([212.97.129.88]:25749 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261787AbULNXkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:40:14 -0500
Date: Wed, 15 Dec 2004 00:40:12 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041214234012.GX347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209215414.GA21503@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 09:54:14PM +0000, Christoph Hellwig wrote:
...
> 
> If it's really st_mode I suspect it's a different problem.  Can you retry
> with current oss.sgi.com CVS (or the patch below).  Note that this patch
> breaks xfsdump unfortunately, we're looking into a fix.

I'm running plain 2.6.9 plus the patch you sent now.

So far, the server hasn't hosed itself (and it's been running for almost
half an hour - woohoo)

Now I can check out CVS trees without getting files with weird ownership
and undeletable directories  (which as *extremely* common before - in
fact, earlier today before I applied the patch, I was unable to complete
a cvs checkout of a moderately large software project).

I guess this is a thumbs up for your patch so far  :)


> > > Maybe some data is flushed in an incorrect order?
> > 
> > Maybe  :)
> 
> No, the problem I've fixed was related to XFS getting the inode version
> number wrong - or at least different than NFSD expects.

I have seen problems that your patch probably won't fix (like
undeletable directories randomly occuring on ext3 filesystems as well -
seems that once the dcache gets confused, it *really* gets confused).

Let's see how the box fares with your patch - I'll report back on new
bugs as I find them.

-- 

 / jakob

