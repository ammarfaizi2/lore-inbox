Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264738AbSJOSX5>; Tue, 15 Oct 2002 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSJOSX5>; Tue, 15 Oct 2002 14:23:57 -0400
Received: from thunk.org ([140.239.227.29]:32718 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264738AbSJOSXz>;
	Tue, 15 Oct 2002 14:23:55 -0400
Date: Tue, 15 Oct 2002 14:29:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Add extended attributes to ext2/3
Message-ID: <20021015182943.GA1335@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <agruen@suse.de>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200210151640.15581.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210151640.15581.agruen@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:40:15PM +0200, Andreas Gruenbacher wrote:
> Hello,
> 
> Here are two fixes as incrementals to the xattr/acl patches:
> 
> fix-xattr.diff: The bad_block bug Andreas Dilger has reported

I've fixed this already in my patches, thanks.

> fix-acl.diff: Make change in ext[23]_new_inode() less intrusive.

Uh, I must be missing something.

It looks like the ext3 change in fix-acl.diff was to revert a change
that I never had; it's not in the 2.4 0.8.50 patches, and it wasn't in
my patches.  So I'm not sure what's going on there.

The ext2 change in fix-acl.diff looks *wrong*.  It removes a call to
mark_inode_dirty which was there in the original, and which is
necessary.

Are you sure you sent me the right diff, or that you diffed the
correct set of trees/files?

						- Ted
