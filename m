Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSKFQGT>; Wed, 6 Nov 2002 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265758AbSKFQGT>; Wed, 6 Nov 2002 11:06:19 -0500
Received: from pump3.york.ac.uk ([144.32.128.131]:58012 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S265757AbSKFQGQ>;
	Wed, 6 Nov 2002 11:06:16 -0500
Date: Wed, 6 Nov 2002 16:12:34 +0000
From: Ewan Mac Mahon <ecm103@york.ac.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christopher Li <chrisl@vmware.com>,
       "'Linux Kernel '" <linux-kernel@vger.kernel.org>,
       "'ext2-devel@lists.sourceforge.net '" 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.5.46 ext3 errors
Message-ID: <20021106161234.GB17138@york.ac.uk>
References: <3C77B405ABE6D611A93A00065B3FFBBA36A493@PA-EXCH2> <20021106101806.B2663@redhat.com> <20021106130521.GB839@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106130521.GB839@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:05:21PM +0100, Jens Axboe wrote:
> On Wed, Nov 06 2002, Stephen C. Tweedie wrote:
> > 
> > error is just ext3's normal reaction to a fatal error detected in the
> > filesystem, so that in itself isn't a worry.  The cause of the problem
> > it spotted is the worry; is this reproducible?
> 
> I can try. The kernel run had my rbtree deadline patches, however
> they've been well tested and are likely not the cause of the problem. It
> cannot be 100% ruled out though, I'm testing for this very thing right
> now. I will let you know what happens.

I think I can rule that out, I've got much the same[1] from a vanilla 
2.5.46, and the filesystem's recent history has been plain 2.5.XXs as 
well.

Ewan


EXT3-fs error (device ide0(3,5)): ext3_new_inode: Free inodes count
corrupted in group 18
Aborting journal on device ide0(3,5).
ext3_abort called.
EXT3-fs abort (device ide0(3,5)): ext3_journal_start: Detected aborted
journal
Remounting filesystem read-only
EXT3-fs error (device ide0(3,5)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,5)) in ext3_new_inode: error 28
EXT3-fs error (device ide0(3,5)) in ext3_create: IO failure
EXT3-fs error (device ide0(3,5)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,5)) in start_transaction: Journal has aborted

etc. etc.
