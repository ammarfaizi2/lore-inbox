Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVADIsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVADIsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 03:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVADIsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 03:48:16 -0500
Received: from unthought.net ([212.97.129.88]:12445 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261539AbVADIsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 03:48:11 -0500
Date: Tue, 4 Jan 2005 09:48:10 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050104084810.GX347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182344.GB14586@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 06:23:44PM +0000, Christoph Hellwig wrote:
...
> I have a better patch than the one I gave you (attached below).  If you
> send me a mail with steps to reproduce your remaining problems I'll put
> this very high on my TODO list after christmas.  Btw, any chance you could
> try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
> there have been various other fixes in the last months.

I have been on XFS CVS + the patch you sent for five days now.

Summary:

 XFS and related dcache problems (seen in ext3 too) with files that get
created as symlinks to themselves or undeletable directories, or just
get plain wrong permissions or ownership:   These problems seem to have
gone away completely.   Very very nice!

 I still get NFS stale handle problems (the weird ones that can be
worked around at times by running a ls -l on the server-side).

 I talked Anders (as@cohaesio.com) into testing the same kernel on
another system he's running, where his main prolem were the stale
handles. He too now only sees the weird stale handle problems.

So, it looks like the current 2.6 status on file serving is:
 *) Can be done with XFS+NFS+SMP iff running a SGI kernel
 *) Will see weird NFS stale handle problems no matter which kernel
    is used

Which is a lot better than the previous "2.6 will eat your files and
make whatever remains owned by guest" situation   :)

Good work!

(Any suggestions on the knfsd issue with stale handles?)

-- 

 / jakob

