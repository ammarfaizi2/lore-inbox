Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265021AbSKFM6x>; Wed, 6 Nov 2002 07:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265022AbSKFM6x>; Wed, 6 Nov 2002 07:58:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5256 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265021AbSKFM6v>;
	Wed, 6 Nov 2002 07:58:51 -0500
Date: Wed, 6 Nov 2002 14:05:21 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christopher Li <chrisl@vmware.com>,
       "'Linux Kernel '" <linux-kernel@vger.kernel.org>,
       "'ext2-devel@lists.sourceforge.net '" 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.5.46 ext3 errors
Message-ID: <20021106130521.GB839@suse.de>
References: <3C77B405ABE6D611A93A00065B3FFBBA36A493@PA-EXCH2> <20021106101806.B2663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106101806.B2663@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, Nov 06, 2002 at 01:43:45AM -0800, Christopher Li wrote:
> > Can you put the e2image of that device to some URL I can
> > download?
> 
> It's unlikely to be useful.  A journal abort will cause existing
> transactions to be suspended midstream, so any errors afterwards may
> be due to updates which were in progress at the time and which didn't
> complete.  And since a fsck has been done, we've lost those errors
> anyway.

It's a 151gb partition anyways, so not very easy to give access to. And
as Stephen mentions, it has been file system checked and is clean now.

> Is the problem reproducible?  The basic
> 
> > EXT3-fs error (device ide1(22,1)): ext3_new_inode: Free inodes count
> > corrupted in group 688 Aborting journal on device ide1(22,1).
> 
> error is just ext3's normal reaction to a fatal error detected in the
> filesystem, so that in itself isn't a worry.  The cause of the problem
> it spotted is the worry; is this reproducible?

I can try. The kernel run had my rbtree deadline patches, however
they've been well tested and are likely not the cause of the problem. It
cannot be 100% ruled out though, I'm testing for this very thing right
now. I will let you know what happens.

-- 
Jens Axboe

